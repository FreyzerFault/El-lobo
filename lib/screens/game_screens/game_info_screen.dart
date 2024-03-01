import 'package:el_lobo/components/player_card.dart';
import 'package:flutter/material.dart';
import 'package:el_lobo/model/model.dart';
import 'package:provider/provider.dart';

class GameInfoScreen extends StatelessWidget {
  const GameInfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Jugadores"),
      ),
      body: Consumer<Game>(
        builder: (context, game, child) => ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 30),
            itemCount: game.allPlayers.length,
            itemBuilder: (context, index) {
              Player player = game.allPlayers.elementAt(index);

              return GestureDetector(
                child: PlayerCard(player: player),
                onTap: () => Navigator.of(context)
                    .pushNamed('/game/info/player', arguments: player),
              );
            }),
      ),
    );
  }
}
