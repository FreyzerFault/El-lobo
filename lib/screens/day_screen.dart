import 'package:el_lobo/components/components.dart';
import 'package:el_lobo/screens/vote_screens.dart';
import 'package:flutter/material.dart';
import 'package:el_lobo/model/model.dart';
import 'package:el_lobo/el_lobo_icons.dart';

class DayScreen extends StatefulWidget {
  final Game game;
  final Function() onDayEnds;

  const DayScreen({Key? key, required this.game, required this.onDayEnds})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _DayScreenState();
}

class _DayScreenState extends State<DayScreen> {
  int index = 0;

  void next() {
    setState(index < widget.game.alivePlayers.length

        // Si aun quedan paginas continua
        ? () => index++

        // Si es la ultima pagina termina el dia
        : widget.onDayEnds);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: ElevatedButton(
        onPressed: next,
        child: const Text("Siguiente"),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: IndexedStack(
        index: index,
        children: [
          DayNightSummary(
              icon: ElLoboIcons.sun,
              msg:
                  "\"El pueblo se despierta y se reune en la plaza del pueblo...\"",
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
                DeathReport(
                    player: widget.game.villagerPlayers.first,
                    cause: DeathCause.byLove,
                    subjectPlayer: widget.game.villagerPlayers.first,
                    subjectRol: Rol.wolf),
                DeathReport(
                    player: widget.game.villagerPlayers.first,
                    cause: DeathCause.byLove,
                    subjectPlayer: widget.game.villagerPlayers.first,
                    subjectRol: Rol.wolf),
                DeathReport(
                    player: widget.game.villagerPlayers.first,
                    cause: DeathCause.byLove,
                    subjectPlayer: widget.game.villagerPlayers.first,
                    subjectRol: Rol.wolf),
                DeathReport(
                    player: widget.game.villagerPlayers.first,
                    cause: DeathCause.byLove,
                    subjectPlayer: widget.game.villagerPlayers.first,
                    subjectRol: Rol.wolf),
                DeathReport(
                    player: widget.game.villagerPlayers.first,
                    cause: DeathCause.byLove,
                    subjectPlayer: widget.game.villagerPlayers.first,
                    subjectRol: Rol.wolf),
                ...widget.game.lastDeathReports,
              ]),
          ... _buildVoteScreens(),
        ],
      ),
    );
  }

  List<VoteScreen> _buildVoteScreens() {
    List<VoteScreen> screens = List.empty(growable: true);

    for (Player player in widget.game.alivePlayers) {
      screens.add(VoteScreen(
        votingPlayer: player,
        voteList: widget.game.alivePlayers.difference({player}),
      ));
    }
    return screens;
  }
}
