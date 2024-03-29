import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:el_lobo/utils/el_lobo_icons.dart';
import 'model/model.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

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
      // El Boton de Empezar Partida esta desactivado hasta que hayan suficientes Jugadores seleccionados para Jugar
      ElevatedButton(
        child: const Text("Empezar Partida"),
        onPressed: manager.canStartGame
            ? () {
                Navigator.of(context).pushNamed('/game', arguments: manager);
              }
            : null,
      ),
      ElevatedButton(
          child: const Text("Jugadores"),
          onPressed: () =>
              Navigator.of(context).pushNamed('/players', arguments: manager)),
      ElevatedButton(
          child: const Text("Roles"),
          onPressed: () =>
              Navigator.of(context).pushNamed('/rols', arguments: manager)),
      ElevatedButton(
          child: const Text("Reglas"),
          onPressed: () => Navigator.of(context).pushNamed('/rules')),
    ];
  }
}
