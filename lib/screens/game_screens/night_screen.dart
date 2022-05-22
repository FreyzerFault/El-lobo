import 'package:el_lobo/components/components.dart';
import 'package:el_lobo/screens/game_screens/decision_screen.dart';
import 'package:flutter/material.dart';
import 'package:el_lobo/model/model.dart';
import 'package:el_lobo/utils/el_lobo_icons.dart';
import 'package:provider/provider.dart';

class NightScreen extends StatefulWidget {
  const NightScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _NightScreenState();
}

class _NightScreenState extends State<NightScreen> {
  int index = 0;
  Set<Player> selectedPlayers = {};

  void next(BuildContext context) {
    if (selectedPlayers.isNotEmpty) {
      // TODO hacer lo propio segun el rol que toque
      print(
          "Victimas de ${Provider.of<Game>(context, listen: false).nightActiveRols.elementAt(index - 1)}: $selectedPlayers");

      // Vacia los seleccionados para la siguiente decision
      selectedPlayers.clear();
    }
    if (index <
        Provider.of<Game>(context, listen: false).nightActiveRols.length) {
      setState(() => index++);
    } else {
      Provider.of<Game>(context, listen: false).endNight();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: ElevatedButton(
        onPressed: () => next(context),
        child: const Text("Siguiente"),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Consumer<Game>(
          builder: (context, game, child) => IndexedStack(
                index: index,
                children: [
                  DayNightSummary(
                      icon: ElLoboIcons.moon,
                      msg: "\"En un pueblecico perdido de la mano de dios...\"",
                      deathReports: [
                        ...game.lastDeathReports,
                      ]),
                  ..._buildDecisionScreens(game),
                ],
              )),
    );
  }

  List<DecisionScreen> _buildDecisionScreens(Game game) {
    // Lista de pantallas de decision
    List<DecisionScreen> screens = List.empty(growable: true);

    for (Rol rol in game.nightActiveRols) {
      screens.add(
        DecisionScreen(
          rol: rol,
          playersOfRol: game.getPlayersOfRol(rol),
          targetPlayers: game.getPlayersNotOfRol(rol),
          selectedPlayers: selectedPlayers,
        ),
      );
    }
    return screens;
  }
}
