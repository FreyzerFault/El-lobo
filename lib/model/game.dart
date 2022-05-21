import 'package:el_lobo/model/model.dart';
import 'package:flutter/cupertino.dart';
import 'package:quiver/collection.dart';

/// Gestiona los datos de la partida
class Game extends ChangeNotifier {
  /// ID del Juego incremental
  final int id;
  static int numGamesCreated = 0;

  /// Jugadores vivos agrupados por Rol
  final Multimap<Rol, Player> _alivePlayers = Multimap();

  /// Jugadores muertos con su informacion de su muerte
  final Map<Player, DeathReport> _deadPlayers = {};

  /// Ultimas muertes, se vacia cuando se consulta
  final List<Player> _lastDeaths = [];

  /// Guarda un conjunto de jugadores clasificados por su Rol
  Game({required Set<Player> players}) : id = numGamesCreated {
    for (var player in players) {
      _alivePlayers.add(player.rol!, player);
    }
    numGamesCreated++;
  }

  Set<Player> get allPlayers => Set.unmodifiable({... _alivePlayers.values, ... _deadPlayers.keys});
  Set<Player> get deadPlayers => Set.unmodifiable(_deadPlayers.keys);
  Set<Player> get alivePlayers => Set.unmodifiable(_alivePlayers.values);

  Set<Player> get villagerPlayers => getPlayersOfRol(Rol.villager);
  Set<Player> get wolfPlayers => getPlayersOfRol(Rol.wolf);

  /// Roles activos por la noche que deben tomar una decision
  Set<Rol> get activeRols => _alivePlayers.keys.toSet();

  // Condiciones de victoria:
  bool get wolfsWinCondition => villagerPlayers.isEmpty;
  bool get villagersWinCondition => wolfPlayers.isEmpty;


  /// Conjunto de jugadores con un Rol concreto
  Set<Player> getPlayersOfRol(Rol rol) => _alivePlayers[rol].toSet();

  /// Conjunto de jugadores excluyendo los de un Rol concreto
  Set<Player> getPlayersNotOfRol(Rol rol) =>
      _alivePlayers.values.toSet().difference(getPlayersOfRol(rol));

  /// Mata a un jugador si esta vivo y guarda un reporte de muerte
  bool killPlayer(Player player, DeathReport deathReport) {
    // Convertimos el jugador de vivo a muerto siempre que este entre los vivos
    if (_alivePlayers.remove(player.rol!, player)) {
      player.dead = true;
      _deadPlayers[player] = deathReport;
      _lastDeaths.add(player);
      notifyListeners();
      return true;
    }
    // No estaba vivo
    return false;
  }

  /// Consulta los reportes de las ultimas muertes desde la ultima consulta
  Iterable<DeathReport> get lastDeathReports {
    List<DeathReport> reports = [];
    for (Player player in _lastDeaths) {
      if (!_deadPlayers.containsKey(player)) {
        print("No existe el reporte de muerte de $player}");
      } else {
        reports.add(_deadPlayers[player]!);
      }
    }
    _lastDeaths.clear();
    notifyListeners();
    return reports;
  }

  /// Revive un jugador si esta muerto
  bool revivePlayer(Player player) {
    // Si existe entre los muertos, lo volvemos a añadir a los vivos
    if (_deadPlayers.remove(player) != null) {
      _lastDeaths.remove(player);
      player.alive = true;
      _alivePlayers.add(player.rol!, player);
      notifyListeners();
      return true;
    }
    // No estaba muerto, estaba de parranda
    return false;
  }
}
