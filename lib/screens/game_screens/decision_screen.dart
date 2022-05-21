import 'package:el_lobo/components/components.dart';
import 'package:flutter/material.dart';
import 'package:el_lobo/model/model.dart';

class DecisionScreen extends StatefulWidget {
  // El rol y su jugador o jugadores
  final Rol rol;
  final Game game;

  final Function(Set<Player> selectedPlayers) onSubmit;

  const DecisionScreen({
    Key? key,
    required this.rol,
    required this.onSubmit,
    required this.game,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DecisionScreenState();
}

class _DecisionScreenState extends State<DecisionScreen> {
  /// Lista de Jugadores que deciden
  Set<Player> players = {};

  /// Lista de jugadores que se pueden seleccionar
  Set<Player> targetablePlayers = {};

  Set<Player> selectedPlayers = {};

  @override
  Widget build(BuildContext context) {
    players = widget.game.getPlayersOfRol(widget.rol);
    targetablePlayers = widget.game.getPlayersNotOfRol(widget.rol);

    return OrientationBuilder(
            builder: (context, orientation) =>
                orientation == Orientation.portrait
                    ? ListView(
                        shrinkWrap: true,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        children: [
                          _buildIcon(),
                          _buildSeparator(),
                          _buildText(context),
                          _buildSeparator(),
                          _buildPlayerGrid(),
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                            Expanded(
                                child: ListView(
                              shrinkWrap: true,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              children: [
                                _buildIcon(),
                                _buildSeparator(),
                                _buildText(context),
                              ],
                            )),
                            _buildPlayerGrid(),
                          ]));
  }

  Icon _buildIcon() => Icon(
        widget.rol.icon,
        size: 180,
      );

  SizedBox _buildSeparator() => const SizedBox(
        height: 40,
      );

  Widget _buildText(BuildContext context) => Center(
          child: Text(
        "Selecciona una víctima",
        style: Theme.of(context).textTheme.titleLarge,
      ));

  Widget _buildPlayerGrid() => Expanded(
      child: PlayerGrid(
          players: targetablePlayers, selectedPlayers: selectedPlayers));
}
