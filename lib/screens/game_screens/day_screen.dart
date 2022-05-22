import 'package:el_lobo/components/components.dart';
import 'package:el_lobo/screens/game_screens/vote_screens.dart';
import 'package:flutter/material.dart';
import 'package:el_lobo/model/model.dart';
import 'package:el_lobo/utils/el_lobo_icons.dart';
import 'package:provider/provider.dart';

class DayScreen extends StatefulWidget {
  const DayScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DayScreenState();
}

class _DayScreenState extends State<DayScreen> {
  int index = 0;

  next(BuildContext context) {
    // TODO Matar al que reciba mas votos y añadir Pagina de "Ha sido Linchado"
    // Pasa al siguiente voto si aun quedan
    if (index < Provider.of<Game>(context, listen: false).alivePlayers.length) {
      setState(() =>index++);
    } else {
      // Si no hay mas votos termina el dia
      Provider.of<Game>(context, listen: false).endDay();
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
      body: Consumer<Game>(builder: (context, game, child) => IndexedStack(
        index: index,
        children: [
          DayNightSummary(
              icon: ElLoboIcons.sun,
              msg:
              "\"El pueblo se despierta y se reune en la plaza del pueblo...\"",
              deathReports: game.lastDeathReports.toList(),),
          ... _buildVoteScreens(game.alivePlayers),
        ],
      ),
    ));
  }

  List<VoteScreen> _buildVoteScreens(Set<Player> players) {
    List<VoteScreen> screens = List.empty(growable: true);

    for (Player player in players) {
      screens.add(VoteScreen(
        votingPlayer: player,
        voteList: players.difference({player}),
      ));
    }
    return screens;
  }
}
