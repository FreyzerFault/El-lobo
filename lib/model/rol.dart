import 'package:el_lobo/el_lobo_icons.dart';
import 'package:flutter/material.dart';

class Rol
{
  final int id;
  final String name;
  final IconData icon;

  final String? decisionText;
  final String? deathMsg;

  const Rol._({required this.id, required this.name, required this.icon, this.decisionText, this.deathMsg});

  static Rol get villager => allRols.elementAt(0);
  static Rol get wolf => allRols.elementAt(1);
  static Rol get seer => allRols.elementAt(2);
  static Rol get cupid => allRols.elementAt(3);
  static Rol get witch => allRols.elementAt(4);
  static Rol get hunter => allRols.elementAt(5);
  static Rol get protector => allRols.elementAt(6);
  static Rol get oldman => allRols.elementAt(7);
  static Rol get girl => allRols.elementAt(8);
  static Rol get joker => allRols.elementAt(9);
  static Rol get childWolf => allRols.elementAt(10);
  static Rol get fool => allRols.elementAt(11);

  // Todos los Roles disponibles en el Juego
  // Para eliminar o añadir roles nuevos solo hay que modificar esta lista
  static Set<Rol> get allRols => {
    Rol._(id: 0, name: "Aldeano", icon: ElLoboIcons.icons[0],),
    Rol._(id: 1, name: "Lobo", icon: ElLoboIcons.icons[1], decisionText: "Elige una víctima", deathMsg: "ha sido devorado"),
    Rol._(id: 2, name: "Vidente", icon: ElLoboIcons.icons[2]),
    Rol._(id: 3, name: "Cupido", icon: ElLoboIcons.icons[3]),
    Rol._(id: 4, name: "Bruja", icon: ElLoboIcons.icons[4]),
    Rol._(id: 5, name: "Cazador", icon: ElLoboIcons.icons[5]),
    Rol._(id: 6, name: "Protector", icon: ElLoboIcons.icons[6]),
    Rol._(id: 7, name: "Anciano", icon: ElLoboIcons.icons[7]),
    Rol._(id: 8, name: "Niña", icon: ElLoboIcons.icons[8]),
    Rol._(id: 9, name: "Joker", icon: ElLoboIcons.icons[9]),
    Rol._(id: 10, name: "Tonto del Pueblo", icon: ElLoboIcons.icons[10]),
    Rol._(id: 11, name: "Niño Lobo", icon: ElLoboIcons.icons[11]),
  };

  // Para comprobar que dos roles son iguales y hacer un set se usa el id
  @override
  bool operator ==(other) => other is Rol && id == other.id;

  @override
  int get hashCode => id;

  @override
  String toString() {
    return name;
  }
}