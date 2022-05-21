import 'package:el_lobo/components/player_card.dart';
import 'package:el_lobo/screens/player_info_screen.dart';
import 'package:flutter/material.dart';
import 'package:el_lobo/model/model.dart';

class PlayersSummaryScreen extends StatelessWidget {
  final Set<Player> players;

  const PlayersSummaryScreen({Key? key, required this.players})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Jugadores"),
      ),
      body: ListView.builder(
          itemCount: players.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              child: PlayerCard(player: players.elementAt(index)),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                            PlayerInfoScreen(player: players.elementAt(index)),
                    ),
                );
              },
            );
          }),
    );
  }
}
