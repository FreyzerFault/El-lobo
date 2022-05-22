import 'package:el_lobo/components/player_grid.dart';
import 'package:el_lobo/model/model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PlayersScreen extends StatefulWidget {
  const PlayersScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayersScreen> {
  /// Modo BORRADO
  static bool onDeleteMode = false;

  /// Conjunto de Jugadores seleccionados en el PlayerGrid
  Set<Player> selectedPlayers = {};

  @override
  void initState() {
    super.initState();
    updateSelectedPlayers();
    onDeleteMode = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Jugadores",
        ),
        centerTitle: true,
        actions: onDeleteMode
            ? []
            : [
                // Boton BORRADO (solo visible si no esta activado)
                IconButton(
                  icon: const Icon(Icons.delete_forever),
                  onPressed: toggleDeleteMode,
                ),
                const SizedBox(
                  width: 10,
                ),
              ],
        // Boton ATRAS sobrecargado para que guarde los cambios:
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
          ),
          onPressed: onDeleteMode
              // Si esta en modo BORRADO salimos del modo
              ? toggleDeleteMode
              // Si no, Vamos ATRAS, pero antes guardamos los datos y actualizmos los roles
              : () {
                  saveSelected();
                  Navigator.pop(context);
                },
        ),
      ),
      body: Consumer<AppManager>(
          builder: (context, manager, child) => buildPlayerGrid(manager)),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: buildFloatButton(),
    );
  }

  PlayerGrid buildPlayerGrid(AppManager manager) {
    if (onDeleteMode) {
      return PlayerGrid(
        players: manager.players,
        selectionMode: SelectionMode.delete,
        selectedPlayers: selectedPlayers,
        scrollable: true,
      );
    }
    return PlayerGrid(
      players: manager.players,
      selectedPlayers: selectedPlayers,
      onLongTapEnabled: true,
      scrollable: true,
    );
  }

  FloatingActionButton buildFloatButton() {
    if (onDeleteMode) {
      // Boton ELIMINAR JUGADORES
      return FloatingActionButton(
        backgroundColor: Theme.of(context).errorColor,
        child: const Icon(
          Icons.remove,
        ),
        onPressed: () {
          // Elimina los jugadores seleccionados y sale del modo Borrado
          Provider.of<AppManager>(context, listen: false)
              .deletePlayers(selectedPlayers);
          toggleDeleteMode();
        },
      );
    }
    // Boton AÑADIR JUGADOR
    return FloatingActionButton(
      child: const Icon(
        Icons.add,
      ),
      onPressed: () {
        // Abre la Pantalla de CREACION de Jugadores y le pasa una funcion para cuando se cree
        Navigator.of(context).pushNamed(
          '/players/create',
          arguments: (player) {
            // Lo añade a la base de datos
            Provider.of<AppManager>(context, listen: false).addPlayer(player);
            // Y lo selecciona recien añadido para evitar EXCISE
            updateSelectedPlayers();
          },
        );
      },
    );
  }

  /// Cambia entre modo Borrado y modo Seleccion
  void toggleDeleteMode() {
    setState(() {
      // Si vamos a entrar en el modo borrado, guardamos los seleccionados para no perderlos
      // Y vaciamos los seleccionados
      if (!onDeleteMode) {
        saveSelected();
        selectedPlayers.clear();
        // Al salir del modo Borrado volvemos a seleccionar los que antes lo estaban
      } else {
        updateSelectedPlayers();
      }
      onDeleteMode = !onDeleteMode;
    });
  }

  /// Guarda los Jugadores Seleccionados y actualiza los Roles
  /// tal que haya tantos como jugadores (respetando el Ratio Aldeano:Lobo)
  void saveSelected() {
    AppManager manager = Provider.of<AppManager>(context, listen: false);
    manager.playersInGame = selectedPlayers;
    manager.updateRols();
    manager.assignRols2Players();
  }

  /// Actualiza los seleccionados en la interfaz para que sea los seleccionados en el Juego
  updateSelectedPlayers() {
    selectedPlayers =
        Set.from(Provider.of<AppManager>(context, listen: false).playersInGame);
  }
}
