import 'package:el_lobo/screens/players_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:el_lobo/el_lobo_icons.dart';
import 'screens/screens.dart';
import 'model/model.dart';

class ElLoboHomePage extends StatelessWidget {
  const ElLoboHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text("El Lobo"),
        ),
      ),
      body: Consumer<AppManager>(
        builder: (context, manager, child) => Center(
          child: OrientationBuilder(builder: (context, orientation) {
            if (orientation == Orientation.portrait) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox.square(
                    child: Icon(ElLoboIcons.wolf, size: 200),
                    dimension: 200.0,
                  ),
                  ..._buildButtonMenu(manager, context),
                ],
              );
            } else {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const SizedBox.square(
                    child: Icon(ElLoboIcons.wolf, size: 200),
                    dimension: 200.0,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: _buildButtonMenu(manager, context),
                  )
                ],
              );
            }
          }),
        ),
      ),
    );
  }

  List<Widget> _buildButtonMenu(AppManager manager, BuildContext context) {
    return [
      ElevatedButton(
        child: const Text("Empezar Partida"),
        onPressed: manager.enoughPlayers()
            ? () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                        ChangeNotifierProvider(
                          create: (context) => Game(players: manager.assignRols2Players()),
                          child: GameScreen(),
                        )));
              }
            : null,
      ),
      ElevatedButton(
          child: const Text("Jugadores"),
          onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => PlayersScreen(
                        manager: manager,
                      )))),
      ElevatedButton(
          child: const Text("Roles"),
          onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => RolsScreen(
                        manager: manager,
                      )))),
      ElevatedButton(
          child: const Text("Reglas"),
          onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => RulesScreen()))),
    ];
  }
}
