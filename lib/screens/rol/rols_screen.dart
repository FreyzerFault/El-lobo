import 'package:el_lobo/components/components.dart';
import 'package:el_lobo/model/model.dart';
import 'package:flutter/material.dart';

class RolsScreen extends StatefulWidget {
  final AppManager manager;

  const RolsScreen({Key? key, required this.manager}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _RolsScreenState();
}

class _RolsScreenState extends State<RolsScreen> {
  @override
  Widget build(BuildContext context) {
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
                      final rol = Rol.allRols.elementAt(index);
                      return RolCard(
                        rol: rol,
                        num: widget.manager.numRols(rol),
                        numVillagers: widget.manager.numRols(Rol.villager),
                        onRolUpdate: () => setState(() {}),
                      );
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
                    final rol = Rol.allRols.elementAt(index + 2);
                    return RolCard(
                      rol: rol,
                      num: widget.manager.numRols(rol),
                      numVillagers: widget.manager.numRols(Rol.villager),
                      onRolUpdate: () => setState(() {}),
                    );
                  },
                  childCount: Rol.allRols.length - 2,
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
    widget.manager.shuffleRols();
    setState(() {});
  }
}
