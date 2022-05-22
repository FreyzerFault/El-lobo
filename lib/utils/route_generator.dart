import 'package:el_lobo/el_lobo_home_page.dart';
import 'package:el_lobo/model/model.dart';
import 'package:el_lobo/screens/player_storage/edit_player_screen.dart';
import 'package:el_lobo/screens/player_storage/players_screen.dart';
import 'package:el_lobo/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Argumentos que se pasan en Navigator.pushNamed
    final args = settings.arguments;

    switch (settings.name) {
      // PAGINA PRINCIPAL
      case '/':
        // Proporciona un MultiProvider a to el "Arbol" de vistas
        // que tiene cada uno de los Providers que vaya a usar la App
        return MaterialPageRoute(
          builder: (context) => MultiProvider(
            providers: [
              // AppManager con toda la logica necesaria antes de empezar una partida
              ChangeNotifierProvider(create: (context) => AppManager.instance),
            ],
            // Arbol de vistas:
            child: const HomePage(),
          ),
        );

      // PAGINA DEL JUEGO
      case '/game':
        // Necesita el AppManager para crear un Juego
        if (args is AppManager) {
          return MaterialPageRoute(builder: (context) {
            // Solo si se cumplen las condiciones para Empezar un Juego
            if (args.canStartGame) {
              return ChangeNotifierProvider(
                create: (context) => Game(players: args.playersInGame),
                child: const GameScreen(),
              );
            }
            throw ("Error al Empezar una Partida, no se cumplen las condiciones");
          });
        }
        throw ("Error al cargar Game");

      // PAGINA DE JUGADORES
      case '/players':
        if (args is AppManager) {
          return MaterialPageRoute(
              builder: (context) => ChangeNotifierProvider.value(
                    value: args,
                    child: const PlayersScreen(),
                  ));
        }
        throw ("Error al cargar Players");

      // PAGINA de CREACION y ACTUALIZACION de un JUGADOR
      case '/players/create':
        if (args is Function(Player)) {
          return MaterialPageRoute(
            builder: (context) => EditPlayerScreen.create(args),
          );
        }
        throw ("Error al cargar la pantalla de creacion de un Jugador");
      case '/players/update':
        // Necesita un Jugador y una Funcion para actualizarlo con un nombre y un nombre de imagen
        if (args is List<dynamic> &&
            args.length == 2 &&
            args[0] is Player &&
            args[1] is Function(String, String)) {
          return MaterialPageRoute(
            builder: (context) => EditPlayerScreen.update(args[0], args[1]),
          );
        }
        throw ("Error al cargar la pantalla de actualizacion de un Jugador");

      // PAGINA DE ROLES
      case '/rols':
        if (args is AppManager) {
          return MaterialPageRoute(
              builder: (context) => ChangeNotifierProvider.value(
                    value: args,
                    child: const RolsScreen(),
                  ));
        }
        throw ("Error al cargar Roles");

      // PAGINA DE REGLAS
      case '/rules':
        return MaterialPageRoute(builder: (context) => const RulesScreen());

      // Pagina de INFORMACION DE LA PARTIDA
      case '/game/info':
        if (args is Game) {
          return MaterialPageRoute(
              builder: (context) => ChangeNotifierProvider.value(
                  value: args, child: const GameInfoScreen()));
        }
        throw ("Error al cargar la Informacion de los Jugadores de la Partida");

      // Pagina de INFORMACION de un JUGADOR
      case '/game/info/player':
        if (args is Player) {
          return MaterialPageRoute(
            builder: (context) => PlayerInfoScreen(player: args),
          );
        }
        throw ("Error al cargar la Informacion del Jugador");
      default:
        throw ("Ruta erronea");
    }
  }

}
