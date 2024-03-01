import 'package:flutter/material.dart';

import 'package:el_lobo/model/model.dart';

class PlayerSelectible extends StatelessWidget {
  final Player player;
  final bool selected;
  final Icon icon;
  final Color selectedColor;

  static const double selectedRadius = 32;

  const PlayerSelectible(
      {Key? key,
      required this.player,
      required this.selected,
      required this.selectedColor,
      required this.icon})
      : super(key: key);

  factory PlayerSelectible.selectMode(
          {required Player player, required bool selected}) =>
      PlayerSelectible(
        player: player,
        selected: selected,
        selectedColor: Colors.orange,
        icon: Icon(Icons.check, color: Colors.white, size: selected ? 25 : 0,),
      );

  factory PlayerSelectible.deleteMode(
          {required Player player, required bool selected}) =>
      PlayerSelectible(
        player: player,
        selected: selected,
        selectedColor: Colors.red,
        icon: Icon(Icons.close, color: Colors.white, size: selected ? 25 : 0,),
      );

  @override
  Widget build(BuildContext context) {
    return Padding( padding: const EdgeInsets.symmetric(horizontal: 5),child:Column(
      children: [
        SizedBox(
          height: 80,
          width: 80,
          child: Stack(
            children: [
              Center(
                child: CircleAvatar(
                  radius: selectedRadius,
                  backgroundColor:
                      selected ? selectedColor : Colors.transparent,
                  child: player.profilePicture
                ),
              ),
              Positioned(
                child: CircleAvatar(
                  radius: selected ? 16 : 0,
                  backgroundColor: Theme.of(context).colorScheme.background,
                  child: CircleAvatar(
                    radius: 13,
                    backgroundColor: selectedColor,
                    child: icon,
                  ),
                ),
                right: 0,
                bottom: 0,
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          player.name,
          style: Theme.of(context).textTheme.titleLarge,
          textAlign: TextAlign.center,
        ),
      ],
    ));
  }
}
