import 'package:el_lobo/components/components.dart';
import 'package:el_lobo/model/model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RolsScreen extends StatefulWidget {
  const RolsScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _RolsScreenState();
}

class _RolsScreenState extends State<RolsScreen> {
  @override
  Widget build(BuildContext context) {
    // Consultamos el Conjunto de Roles disponibles una sola vez:
    Iterable<Rol> rols = Provider.of<AppManager>(context, listen: false).rolsInGame.keys;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Roles",
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: shuffle,
            icon: const Icon(Icons.shuffle),
          ),
        ],
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
          ),
          // Boton ATRAS
          onPressed:  () {
            // Asigna los roles a cada Jugador al salir
            Provider.of<AppManager>(context, listen: false).assignRols2Players();
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: OrientationBuilder(builder: (context, orientation) {
          return CustomScrollView(
            scrollDirection: Axis.vertical,
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.only(bottom: 30, top: 5),
                sliver: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisExtent: 200,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final rol = rols.elementAt(index);
                      return Consumer<AppManager>(builder: (context, manager, child) => RolCard(
                        rol: rol,
                        num: manager.numRols(rol),
                        numVillagers: manager.numRols(Rol.villager),
                      ));
                    },
                    childCount: 2,
                  ),
                ),
              ),
              SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisExtent: 180,
                  crossAxisSpacing: 2,
                  mainAxisSpacing: 8,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final rol = rols.elementAt(index + 2);
                    return Consumer<AppManager>(builder: (context, manager, child) => RolCard(
                      rol: rol,
                      num: manager.numRols(rol),
                      numVillagers: manager.numRols(Rol.villager),
                    ));
                  },
                  childCount: rols.length - 2,
                ),
              )
            ],
          );
        }),
      ),
    );
  }

  void shuffle() {
    // Reseteamos los Roles y los asignamos de forma aleatoria
    setState(() => Provider.of<AppManager>(context, listen: false).shuffleRols());
  }
}
