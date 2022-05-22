import 'package:flutter/material.dart';
import 'package:el_lobo/model/model.dart';
import 'package:provider/provider.dart';
import 'package:el_lobo/screens/screens.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _GameScreenState();
}



class _GameScreenState extends State<GameScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title:
            Consumer<Game>(builder: (context, game, child) => Text(game.currentCycleString),),
        actions: [
          // Boton REGLAS
          IconButton(
              onPressed: () => Navigator.of(context).pushNamed('/rules'),
              icon: const Icon(Icons.menu_book_rounded)),

          // Boton JUGADORES
          IconButton(
              onPressed: () => Navigator.of(context).pushNamed('/game/info',
                  arguments: Provider.of<Game>(context, listen: false)),
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
      return game.currentCyclePage;
    },
   );
  }

  void nextSection() {
    setState(() {
      // section =
      //     GameSection.values[(section.index + 1) % GameSection.values.length];
      //
      // if (section == GameSection.night) {
      //   numDays++;
      // }
    });
  }
}
