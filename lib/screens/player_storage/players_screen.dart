import 'package:el_lobo/components/player_grid.dart';
import 'package:el_lobo/model/model.dart';
import 'package:flutter/material.dart';

import 'edit_player_screen.dart';

class PlayersScreen extends StatefulWidget {
  final AppManager manager;

  const PlayersScreen({Key? key, required this.manager}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayersScreen> {
  static bool onDeleteMode = false;
  PlayerGrid? playerGrid;

  @override
  void initState() {
    super.initState();
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
                IconButton(
                  icon: const Icon(Icons.delete_forever),
                  onPressed: toggleDeleteMode,
                ),
                const SizedBox(
                  width: 10,
                ),
              ],
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
          ),
          onPressed: onDeleteMode
              ? toggleDeleteMode
              : () {
                  saveSelected();
                  widget.manager.updateRols();
                  Navigator.pop(context);
                },
        ),
      ),
      body: playerGrid = buildPlayerGrid(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: buildFloatButton(),
    );
  }

  PlayerGrid buildPlayerGrid() {
    if (onDeleteMode) {
      return PlayerGrid(
        players: widget.manager.players,
        selectionMode: SelectionMode.delete,
        selectedPlayers: {},
        scrollable: true,
      );
    }
    return PlayerGrid(
      players: widget.manager.players,
      selectedPlayers: widget.manager.playersInGame,
      onLongTapEnabled: true,
      scrollable: true,
    );
  }

  FloatingActionButton buildFloatButton() {
    if (onDeleteMode) {
      return FloatingActionButton(
        backgroundColor: Theme.of(context).errorColor,
        child: const Icon(
          Icons.remove,
        ),
        onPressed: () {
          widget.manager.deletePlayers(playerGrid!.selectedPlayers.toSet());
          toggleDeleteMode();
        },
      );
    }
    return FloatingActionButton(
      child: const Icon(
        Icons.add,
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => EditPlayerScreen.create(
                    (player) =>
                        setState(() => widget.manager.addPlayer(player)),
                  )),
        );
      },
    );
  }

  void toggleDeleteMode() {
    // Si vamos a entrar en el modo borrado, guardamos los seleccionados para no perderlos
    if (!onDeleteMode) {
      saveSelected();
    }
    setState(() {
      onDeleteMode = !onDeleteMode;
    });
  }

  // Guarda los seleccionados en el GameManager
  void saveSelected() {
    widget.manager.playersInGame = playerGrid!.selectedPlayers.toSet();
  }
}
