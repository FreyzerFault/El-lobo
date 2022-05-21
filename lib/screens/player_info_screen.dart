import 'package:flutter/material.dart';
import 'package:el_lobo/model/model.dart';

class PlayerInfoScreen extends StatelessWidget {
  final Player player;

  const PlayerInfoScreen({Key? key, required this.player}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(player.name),
        centerTitle: true,
      ),
      body: Container(
        color: player.getStatusMainColor().withOpacity(.3),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                player.rol!.icon,
                size: 400,
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 30,
                child: ListView.builder(
                    itemCount: player.status.length,
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemBuilder: (contex, index) {
                      Status stat = player.status.elementAt(index);
                      return Icon(
                        Player.getStatusIcon(stat),
                        color: Player.getStatusColor(stat),
                        size: 40,
                      );
                    }),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                player.rol!.name,
                style: Theme.of(context).textTheme.titleLarge,
                textScaleFactor: 4,
              ),
            ],
          )),
    );
  }
}
