import 'package:el_lobo/screens/game_screens/day_screen.dart';
import 'package:el_lobo/screens/game_screens/night_screen.dart';
import 'package:flutter/material.dart';
import 'package:el_lobo/model/model.dart';
import 'package:provider/provider.dart';
import '../screens.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key,}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _GameScreenState();
}

// Secciones del juego (escalable a mas secciones como eventos varios)
enum GameSection {
  night,
  day,
}

class _GameScreenState extends State<GameScreen> {
  GameSection section = GameSection.night;
  int numDays = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title:
            Text("${section == GameSection.night ? "Noche" : "Dia"} $numDays"),
        actions: [
          // Boton REGLAS
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => RulesScreen()));
              },
              icon: const Icon(Icons.menu_book_rounded)),

          // Boton JUGADORES
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => Consumer<Game>(
                            builder: (context, game, child) =>
                                PlayersSummaryScreen(
                                    players: game.allPlayers))));
              },
              icon: const Icon(Icons.people))
        ],
      ),
      // Selecciona la pantalla que toca, primero comprueba la Win Condition
      // Si no gana nadie muestra la pantalla que toca (noche, dia, ...)
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Consumer<Game>(builder: (context, game, child) {
      // Comprobamos siempre si se da la condicion de Victoria
      // de parte de aldeanos o lobos
      if (game.villagersWinCondition) {
        return const WinScreen(winType: WinType.villagers);
      } else if (game.wolfsWinCondition) {
        return const WinScreen(winType: WinType.wolfs);
      }

      // Seleccionamos una de las pantallas segun la seccion del juego
      // en la que nos encontramos
      switch (section) {
        case GameSection.night:
          return NightScreen(
            game: game,
            onNightEnds: nextSection,
          );
        case GameSection.day:
          return DayScreen(
            game: game,
            onDayEnds: nextSection,
          );
      }
    });
  }

  void nextSection() {
    setState(() {
      section =
          GameSection.values[(section.index + 1) % GameSection.values.length];

      if (section == GameSection.night) {
        numDays++;
      }
    });
  }
}
