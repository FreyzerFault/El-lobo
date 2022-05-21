import 'dart:math';

import 'package:flutter/material.dart';
import 'model.dart';

class AppManager extends ChangeNotifier {
  static late final AppManager _instance = AppManager._();
  static AppManager get instance => _instance;

  static const int minPlayersToPlay = 4;

  ///////////////////////////////////////////////////////////
  // COLECCIONES TEMPORALES PARA HACER PRUEBAS
  static Set<Player> defaultPlayers = <Player>{
    Player(name: "David", avatarPicName: ""),
    Player(name: "Paqui", avatarPicName: ""),
    Player(name: "Fer", avatarPicName: ""),
    Player(name: "Andrea", avatarPicName: ""),
    Player(name: "Rivi", avatarPicName: ""),
    Player(name: "Luis", avatarPicName: ""),
  };
  static Map<Rol, int> defaultRols = <Rol, int>{
    Rol.wolf: 1,
    Rol.villager: 1,
    Rol.seer: 1,
    Rol.witch: 1,
    Rol.cupid: 1,
    Rol.hunter: 1,
  };
  ///////////////////////////////////////////////////////////

  // Se crea con la lista de todos los roles a 0
  AppManager._()
      /*
      : _rolsInGame = Map.fromIterables(
            Rol.allRols, Iterable.generate(Rol.allRols.length, (i) => 0));

   */
      : _rolsInGame = defaultRols,
        _playersInGame = defaultPlayers,
        _players = defaultPlayers;

  // Listas mutables
  final Map<Rol, int> _rolsInGame; // Numero de copias de cada rol
  Set<Player> _playersInGame = defaultPlayers; // Jugadores que juegan
  Set<Player> _players = defaultPlayers; // Biblioteca de Jugadores

  // Lista de Roles solo de Lectura
  Map<Rol, int> get rolsInGame => Map.unmodifiable(_rolsInGame);
  Set<Player> get playersInGame => Set.unmodifiable(_playersInGame);
  Set<Player> get players => Set.unmodifiable(_players);
  set playersInGame(Set<Player> newPlayers) => _playersInGame = newPlayers;
  set players(Set<Player> newPlayers) => _players = newPlayers;

  bool enoughPlayers() {
    return _playersInGame.length >= minPlayersToPlay;
  }

  bool playerInGame(Player player) {
    return _playersInGame.contains(player);
  }

  int numRols(Rol rol) {
    int? num = _rolsInGame[rol];
    if (num != null) {
      return num;
    }
    return 0;
  }

  int totalNumRols() {
    int numRols = 0;
    _rolsInGame.forEach((key, value) => numRols += value);
    return numRols;
  }

  // Cada método que cambie las listas notificara a los Observadores o Listeners:

  // Elimina
  void deleteRol(Rol rol) {
    if (numRols(rol) > 0) {
      _rolsInGame[rol] = _rolsInGame[rol]! - 1;
      notifyListeners();
    }
  }

  // Añade
  void addRol(Rol rol) {
    if (_rolsInGame.containsKey(rol)) {
      _rolsInGame[rol] = _rolsInGame[rol]! + 1;
      notifyListeners();
    }
  }

  // Actualiza el numero de roles de este tipo que hay
  void updateRol(Rol rol, int num) {
    if (_rolsInGame.containsKey(rol)) {
      _rolsInGame[rol] = num;
      notifyListeners();
    }
  }

  // Elimina un rol sin romper el ratio Aldeano : Lobo,
  // si elimina un aldeano y no hay elimina cualquier otro rol especial
  void deleteAnyRol() {
    if (ratioVillagersByWolf() < idealRatio) {
      deleteRol(Rol.wolf);
    } else {
      for (Rol rol in Rol.allRols) {
        if (_rolsInGame.containsKey(rol) &&
            _rolsInGame[rol]! > 0 &&
            rol != Rol.wolf) {
          deleteRol(rol);
          break;
        }
      }
    }
  }

  // Añade un rol sin romper el ratio Aldeano : Lobo
  void addAnyRol() {
    // Si el ratio se pasa de lo ideal añadimos un lobo
    if (ratioVillagersByWolf() >= idealRatio) {
      addRol(Rol.wolf);
    } else {
      addRol(Rol.villager);
    }
  }

  // Ratio ente Aldeano : Lobo que debe haber, ¿Se cumple?
  static const double idealRatio = 4; // 4:1
  double ratioVillagersByWolf() {
    final rols = Rol.allRols;
    int numVillagers = 0;
    int numWolfs = 0;
    for (Rol rol in rols) {
      if (_rolsInGame.containsKey(rol)) {
        if (rol == Rol.wolf) {
          numWolfs += _rolsInGame[rol]!;
        } else {
          numVillagers += _rolsInGame[rol]!;
        }
      }
    }
    if (numWolfs == 0) return idealRatio + 1;

    return numVillagers / numWolfs;
  }

  void updateRols() {
    int numRols = totalNumRols();
    // Si faltan roles se añaden
    if (numRols < _playersInGame.length) {
      for (int i = 0; i < _playersInGame.length - numRols; i++) {
        addAnyRol();
      }
    } else {
      for (int i = 0; i < numRols - _playersInGame.length; i++) {
        deleteAnyRol();
      }
    }
    notifyListeners();
  }

  void addPlayer(Player player) {
    _players.add(player);
    _playersInGame.add(player);
    notifyListeners();
  }

  void deletePlayers(Set<Player> players) {
    _players = _players.difference(players);
    _playersInGame = _playersInGame.difference(players);
  }

  void updatePlayer(Player player, String name, String picName) {
    Player? p = _players.lookup(player);
    if (p != null) {
      p.name = name;
      p.avatarPicName = picName;
    }
  }

  clearAll() {
    _players.clear();
    _playersInGame.clear();
    clearRols();
  }

  clearRols() {
    _rolsInGame.forEach((rol, val) {
      _rolsInGame[rol] = 0;
    });
  }

  shuffleRols() {
    if (totalNumRols() == 0) {
      return;
    }

    clearRols();
    var rols = Rol.allRols;
    Random rand = Random();

    // Minimo se añade 1 lobo:
    addRol(Rol.wolf);

    for (int i = 1; i < playersInGame.length; i++) {
      addRol(rols.elementAt(rand.nextInt(rols.length)));
    }
  }

  /// Asigna todos los Roles a los jugadores de forma aleatoria
  Set<Player> assignRols2Players() {
    Random rand = Random();

    // Creamos una lista con cada rol repetido las veces que haga falta
    List<Rol> rolList = <Rol>[];
    for (var entry in _rolsInGame.entries) {
      for (int i = 0; i < entry.value; i++) {
        rolList.add(entry.key);
      }
    }

    // Vamos cogiendo uno aleatorio, lo asignamos al jugador y lo eliminamos
    for (var player in _playersInGame) {
      int index = rand.nextInt(rolList.length);
      player.rol = rolList[index];
      rolList.removeAt(index);
    }
    return _playersInGame;
  }
}
