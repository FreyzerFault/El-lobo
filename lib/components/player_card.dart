import 'package:flutter/material.dart';
import 'package:el_lobo/model/model.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';

class PlayerCard extends StatelessWidget {
  final Player player;

  const PlayerCard({Key? key, required this.player}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          BoxDecoration(color: player.getStatusMainColor().withOpacity(.3)),
      height: 150,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildPlayer(context),
          _buildStatusColumn(context),
          _buildRol(context),
        ],
      ),
    );
  }

  Widget _buildPlayer(BuildContext context) {
    return FittedBox(
      fit: BoxFit.fitHeight,
      child: Column(
        children: [
          CircleAvatar(
            radius: 45,
            backgroundColor: Theme.of(context).colorScheme.secondary,
            child: player.avatarPicName == ""
                ? ProfilePicture(
                    name: player.name,
                    radius: 40,
                    fontsize: 45,
                    count: 2,
                  )
                : CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage(
                      "assets/player_pics/${player.avatarPicName}",
                    ),
                  ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            player.name,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ],
      ),
    );
  }

  Widget _buildStatusColumn(BuildContext context) {
    return Center(
      child: GridView.builder(
        shrinkWrap: true,
        itemCount: player.status.length,
        scrollDirection: Axis.horizontal,
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemBuilder: (context, index) {
          Status stat = player.status.elementAt(index);
          return Center(
            child: Icon(
              Player.getStatusIcon(stat),
              color: Player.getStatusColor(stat),
              size: 35,
            ),
          );
        },
      ),
    );
  }

  Widget _buildRol(BuildContext context) {
    return FittedBox(
      fit: BoxFit.fitHeight,
      child: Column(
        children: [
          Icon(
            player.rol!.icon,
            size: 80,
          ),
          Text(
            player.rol!.name,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ],
      ),
    );
  }
}
