import 'package:el_lobo/components/components.dart';
import 'package:flutter/material.dart';
import 'package:el_lobo/model/model.dart';

class DeathList extends StatelessWidget {
  final List<DeathReport> deaths;

  const DeathList({Key? key, this.deaths = const <DeathReport>[]})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      itemCount: deaths.length,
      itemBuilder: (context, index) {
        DeathReport death = deaths[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              PlayerRolStack(player: death.player, context: context),
              SizedBox(
                width: 180,
                child: Text(
                  death.toString(),
                  maxLines: 3,
                  overflow: TextOverflow.clip,
                ),
              ),
              buildSubjectRevealed(death, context),
            ],
          ),
        );
      },
    );
  }

  Widget buildSubjectRevealed(DeathReport death, BuildContext context) {
    // Si el jugador culpable se puede revelar no sera null
    if (death.subjectPlayer != null) {
      return PlayerRolStack(player: death.subjectPlayer!, context: context);
    }
    // Si el Rol del sujeto se puede revelar no sera null
    if (death.subjectRol != null) {
      return Icon(death.subjectRol!.icon);
    }

    return Container();
  }
}
