import 'package:flutter/material.dart';
import 'package:el_lobo/model/model.dart';

class PlayerRolStack extends Stack {
  final Player player;

  PlayerRolStack({Key? key, required this.player, required BuildContext context})
      : super(key: key, clipBehavior: Clip.none, children: [
    player.profilePicture,
    Positioned(
      child: CircleAvatar(
          radius: 18,
          child: Icon(player.rol!.icon),
          backgroundColor: Theme.of(context).colorScheme.secondary),
      bottom: -10,
      right: -10,
    ),
  ]);
}
