import 'package:el_lobo/components/components.dart';
import 'package:el_lobo/screens/decision_screen.dart';
import 'package:flutter/material.dart';
import 'package:el_lobo/model/model.dart';
import 'package:el_lobo/el_lobo_icons.dart';

class NightScreen extends StatefulWidget {
  final Game game;
  final Function() onNightEnds;

  const NightScreen({Key? key, required this.game, required this.onNightEnds})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _NightScreenState();
}

class _NightScreenState extends State<NightScreen> {
  int index = 0;

  void next() {
    setState(index < widget.game.activeRols.length

        // Si aun quedan paginas continua
        ? () => index++

        // Si es la ultima pagina termina el dia
        : widget.onNightEnds);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: ElevatedButton(
      onPressed:
      next,
      child: const Text("Siguiente"),
    ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: IndexedStack(
        index: index,
        children: [
          DayNightSummary(
              icon: ElLoboIcons.moon,
              msg: "\"En un pueblecico perdido de la mano de dios...\"",
              next: next,
              deathReports: [
                DeathReport(
                    player: widget.game.villagerPlayers.first,
                    cause: DeathCause.byWolf,
                    subjectPlayer: widget.game.wolfPlayers.first,
                    subjectRol: Rol.wolf),
                DeathReport(
                    player: widget.game.villagerPlayers.first,
                    cause: DeathCause.byLove,
                    subjectPlayer: widget.game.villagerPlayers.first,
                    subjectRol: Rol.wolf),
                ...widget.game.lastDeathReports,
              ]),
          ..._buildDecisionScreens(),
        ],
      ),
    );
  }

  List<DecisionScreen> _buildDecisionScreens() {
    List<DecisionScreen> screens = List.empty(growable: true);

    for (Rol rol in widget.game.activeRols) {
      screens.add(
        DecisionScreen(
          rol: rol,
          game: widget.game,
          onSubmit: (selectedPlayers) {
            if (selectedPlayers.isNotEmpty) {
              widget.game.killPlayer(selectedPlayers.first,
                DeathReport.byDefault(player: selectedPlayers.first));
            }
          },
        ),
      );
    }
    return screens;
  }
}
