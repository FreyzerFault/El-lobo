import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'el_lobo_home_page.dart';
import 'el_lobo_theme.dart';
import 'model/model.dart';

class ElLoboApp extends StatelessWidget {
  const ElLoboApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'El Lobo',
      // Proporciona un MultiProvider a to el "Arbol" de vistas
      // que tiene cada uno de los Providers que vaya a usar la App
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(
              create: (context) => AppManager.instance
          ),
        ],
        // Arbol de vistas:
        child: const ElLoboHomePage(),
      ),
      theme: ElLoboTheme.light(),
      darkTheme: ElLoboTheme.dark(),
      themeMode: ThemeMode.system,
    );
  }
}
