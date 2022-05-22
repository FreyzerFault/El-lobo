import 'package:el_lobo/screens/screens.dart';

// Secciones del juego (escalable a mas secciones como eventos varios)
enum Cycle {
  night,
  day,
}

class GameCycle {
  Cycle currentCycle = Cycle.night;
  int numDays = 0;

  get currentCyclePage {
    switch (currentCycle) {
      case Cycle.night:
        return const NightScreen();
      case Cycle.day:
        return const DayScreen();
    }
  }

  /// Pasa al siguiente periodo del ciclo
  next() {
    currentCycle = Cycle.values[(currentCycle.index + 1) % Cycle.values.length];
    if (currentCycle.index == 0) numDays++;
  }

  @override
  String toString() =>
      "${currentCycle == Cycle.night ? "Noche" : "Día"} $numDays";
}
