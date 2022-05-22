import 'package:flutter/material.dart';

import 'package:el_lobo/utils/el_lobo_icons.dart';
import 'package:el_lobo/model/model.dart';

class RulesScreen extends StatelessWidget {
  const RulesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Reglas",
        ),
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Theme.of(context).colorScheme.onPrimary,
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1, mainAxisSpacing: 0, mainAxisExtent: 150),
            delegate: SliverChildBuilderDelegate(
              (context, index) => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.menu_book_rounded, size: 100),
                  Text(
                    "Reglas Generales",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ],
              ),
              childCount: 1,
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.only(top: 20),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1, mainAxisSpacing: 0, mainAxisExtent: 30),
              delegate: SliverChildBuilderDelegate(
                (context, index) => Text(
                  "Reglas de cada Rol:",
                  style: Theme.of(context).textTheme.titleLarge,
                  textAlign: TextAlign.center,
                ),
                childCount: 1,
              ),
            ),
          ),
          SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 0,
              crossAxisSpacing: 0,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                child: _RuleCard(
                  label: Rol.allRols.elementAt(index).name,
                  iconData: Rol.allRols.elementAt(index).icon,
                  context: context,
                ),
              ),
              childCount: Rol.allRols.length,
            ),
          ),
        ],
      ),
    );
  }
}

class _RuleCard extends Container {
  _RuleCard(
      {required String label,
      required IconData iconData,
      required BuildContext context})
      : super(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(iconData, size: 70),
            Text(
              label,
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ));
}
