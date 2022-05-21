import 'package:el_lobo/components/components.dart';
import 'package:el_lobo/model/model.dart';
import 'package:flutter/material.dart';

class VoteScreen extends StatefulWidget {
  final Player votingPlayer;
  final Set<Player> voteList;

  const VoteScreen(
      {Key? key, required this.votingPlayer, required this.voteList})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _VoteScreen();
}

class _VoteScreen extends State<VoteScreen> {
  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
        builder: (context, orientation) => orientation == Orientation.portrait
            ? ListView(
                shrinkWrap: true,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                children: [
                  widget.votingPlayer.profilePictureWithRadius(50),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Acusa a un Jugador:",
                    style: Theme.of(context).textTheme.titleLarge,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  PlayerGrid(players: widget.voteList, selectedPlayers: {}),
                ],
              )
            : Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                Expanded(
                    child: ListView(
                  shrinkWrap: true,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  children: [
                    widget.votingPlayer.profilePicture,
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Acusa a un Jugador:",
                      style: Theme.of(context).textTheme.titleLarge,
                      textAlign: TextAlign.center,
                    ),
                  ],
                )),
                Expanded(
                    child: PlayerGrid(
                  players: widget.voteList,
                  selectedPlayers: {},
                  scrollable: true,
                ))
              ]));
  }
}
