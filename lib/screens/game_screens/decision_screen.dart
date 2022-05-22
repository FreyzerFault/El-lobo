import 'dart:ui';

import 'package:el_lobo/components/components.dart';
import 'package:flutter/material.dart';
import 'package:el_lobo/model/model.dart';

class DecisionScreen extends StatefulWidget {
  // El rol y su jugador o jugadores
  final Rol rol;
  final Set<Player> playersOfRol;
  final Set<Player> targetPlayers;
  final Set<Player> selectedPlayers;

  const DecisionScreen({
    Key? key,
    required this.rol,
    required this.playersOfRol,
    required this.targetPlayers,
    required this.selectedPlayers,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DecisionScreenState();
}

class _DecisionScreenState extends State<DecisionScreen> {
  /// Lista de Jugadores que deciden
  Set<Player> players = {};

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
        builder: (context, orientation) => orientation == Orientation.portrait
            ? ListView(
                shrinkWrap: true,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                children: [
                  _buildIcon(),
                  _buildText(context),
                  _buildPlayerGrid(),
                ],
              )
            : Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                Expanded(
                    child: ListView(
                  shrinkWrap: true,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  children: [
                    _buildIcon(),
                    _buildText(context),
                  ],
                )),
                _buildPlayerGrid(),
              ]));
  }

  Widget _buildIcon() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 30),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                widget.rol.icon,
                size: 180,
              ),
              widget.playersOfRol.length > 4
                  ? Container(
                      decoration: BoxDecoration(
                        gradient: widget.playersOfRol.length > 4
                            ? LinearGradient(
                                colors: [
                                  Theme.of(context)
                                      .backgroundColor
                                      .withOpacity(0),
                                  Theme.of(context).backgroundColor,
                                  Theme.of(context)
                                      .backgroundColor
                                      .withOpacity(0),
                                ],
                                stops: const [0, 0.5, 1],
                              )
                            : null,
                      ),
                      width: 250,
                      height: 80,
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: widget.playersOfRol.length,
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 5,
                          ),
                          child: widget.playersOfRol
                              .elementAt(index)
                              .profilePicture,
                        ),
                      ),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                          ...widget.playersOfRol.map((e) => e.profilePicture)
                        ]),
            ],
          ),
      );

  Widget _buildText(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Text(
          "Selecciona una víctima",
          style: Theme.of(context).textTheme.titleLarge,
          textAlign: TextAlign.center,
        ),
      );

  Widget _buildPlayerGrid() => PlayerGrid(
        players: widget.targetPlayers,
        selectedPlayers: widget.selectedPlayers,
        scrollable: false,
        onLongTapEnabled: false,
      );
}
