import 'package:flutter/material.dart';

import 'package:el_lobo/components/player_selectible.dart';
import 'package:el_lobo/model/model.dart';
import 'package:provider/provider.dart';

enum SelectionMode { select, delete, love }

class PlayerGrid extends StatefulWidget {
  final Set<Player> players; // Los Jugadores de la Grid
  final Set<Player> selectedPlayers; // Los Jugadores de la Grid
  final SelectionMode selectionMode; // El modo de seleccion
  final bool onLongTapEnabled;
  final bool scrollable;

  const PlayerGrid(
      {Key? key,
      required this.players,
      this.selectionMode = SelectionMode.select,
      required this.selectedPlayers,
      this.onLongTapEnabled = false,
      this.scrollable = false})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _PlayerGridState();
}

class _PlayerGridState extends State<PlayerGrid> {
  void toggleSelect(Player player) {
    setState(() {
      if (widget.selectedPlayers.contains(player)) {
        widget.selectedPlayers.remove(player);
      } else {
        widget.selectedPlayers.add(player);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) => GridView.builder(
          shrinkWrap: true,
          physics: widget.scrollable
              ? const AlwaysScrollableScrollPhysics()
              : const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          itemCount: widget.players.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: (orientation == Orientation.portrait) ? 3 : 5,
            mainAxisExtent: 150,
            mainAxisSpacing: 10,
          ),
          itemBuilder: (context, index) {
            final player = widget.players.elementAt(index);
            return GestureDetector(
                behavior: HitTestBehavior.translucent,
                child: buildPlayerSelectible(
                    player, widget.selectedPlayers.contains(player)),
                // Al tocar, selecciona (añade al juego),
                // y si ya esta en el juego, deselecciona (elimina del juego)
                onTap: () {
                  toggleSelect(player);
                },
                // Al pulsar un tap largo se abre la pantalla de edicion
                onLongPress: () => widget.onLongTapEnabled
                    ? Navigator.of(context)
                        .pushNamed('/players/update', arguments: [
                          // Necesita un Jugador y una Funcion para actualizarlo
                        player,
                        (name, pic) =>
                            Provider.of<AppManager>(context, listen: false)
                                .updatePlayer(player, name, pic)
                      ])
                    : null);
          }),
    );
  }

  Widget buildPlayerSelectible(Player player, bool selected) {
    switch (widget.selectionMode) {
      case SelectionMode.select:
        return PlayerSelectible.selectMode(player: player, selected: selected);
      case SelectionMode.delete:
        return PlayerSelectible.deleteMode(player: player, selected: selected);
      case SelectionMode.love:
        // TODO: Handle this case.
        break;
    }
    return PlayerSelectible.selectMode(player: player, selected: selected);
  }
}
