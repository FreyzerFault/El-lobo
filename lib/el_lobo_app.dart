import 'package:el_lobo/utils/route_generator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:el_lobo/screens/screens.dart';
import 'package:el_lobo/el_lobo_home_page.dart';
import 'package:el_lobo/model/model.dart';
import 'utils/el_lobo_theme.dart';

class ElLoboApp extends StatelessWidget {
  const ElLoboApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'El Lobo',

      //Themes
      theme: ElLoboTheme.light(),
      darkTheme: ElLoboTheme.dark(),
      themeMode: ThemeMode.system,

      // Rutas:
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
