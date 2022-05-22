import 'package:el_lobo/utils/el_lobo_icons.dart';
import 'package:flutter/material.dart';

enum WinType {
  villagers,
  wolfs,
}

class WinScreen extends StatelessWidget {
  final WinType winType;

  const WinScreen({Key? key, required this.winType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late Icon icon;
    late Text text;

    // El icono y el mensaje depende de quien gane,
    // es escalable a otros tipos de victoria
    switch (winType) {
      case WinType.villagers:
        icon = const Icon(ElLoboIcons.villager);
        text = Text("\"GANA EL PUEBLO\"",
            style: Theme.of(context).textTheme.titleLarge,
            textAlign: TextAlign.center);
        break;
      case WinType.wolfs:
        icon = const Icon(ElLoboIcons.wolf);
        text = Text("\"GANAN LOS LOBOS\"",
            style: Theme.of(context).textTheme.titleLarge,
            textAlign: TextAlign.center);
        break;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      child: Column(
        children: [
          icon,
          const SizedBox(
            height: 40,
          ),
          text,
        ],
      ),
    );
  }
}
