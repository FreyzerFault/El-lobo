import 'package:el_lobo/model/model.dart';

enum DeathCause {
  byWolf,
  byLove,
  byHunter,
  deathPotion,
  lynched,
  unknown,
}

class DeathReport {
  final Player player;
  final DeathCause cause;
  final Player? subjectPlayer;
  final Rol? subjectRol;

  DeathReport(
      {required this.player,
      this.cause = DeathCause.unknown,
      this.subjectPlayer,
      this.subjectRol});

  DeathReport.byDefault({required this.player})
      : cause = DeathCause.unknown,
        subjectPlayer = null,
        subjectRol = null;

  @override
  String toString() {
    switch (cause) {
      case DeathCause.byWolf:
        return "${player.name} ha sido devorado por un lobo";
      case DeathCause.byHunter:
        return "${player.name} recibió un disparo en el último aliento de ${subjectPlayer!.name}";
      case DeathCause.byLove:
        return "${player.name} no aguantó el dolor por la muerte de su amante ${subjectPlayer!.name} y se suicidó";
      case DeathCause.deathPotion:
        return "${player.name} fue envenenado por una poción de la bruja";
      case DeathCause.lynched:
        return "${player.name} ha sido linchado hasta la muerte por el pueblo";
      case DeathCause.unknown:
        return "${player.name} ha sido encontrado muerto";
    }
  }
}
