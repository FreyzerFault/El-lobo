import 'package:el_lobo/model/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:uuid/uuid.dart';


enum Status {
  dead,
  protected,
  inlove,
  alive,
}

class Player {
  static int contPlayers = 0;

  final String id;
  String name;
  String avatarPicName;
  Rol? rol;
  Set<Status> status = <Status>{
    Status.alive, Status.inlove, Status.protected,
  };

  Player({required this.name, required this.avatarPicName})
      : id = const Uuid().v1();

  Player.withoutPic({required this.name})
      : id = const Uuid().v1(), avatarPicName = '';

  bool get isDead => status.contains(Status.dead);
  bool get isAlive => status.contains(Status.alive);
  bool get isInLove => status.contains(Status.inlove);
  bool get isProtected => status.contains(Status.protected);

  set dead(bool dead) {
    if (dead) {
      status.remove(Status.alive);
      status.add(Status.dead);
    } else {
      status.remove(Status.dead);
      status.add(Status.alive);
    }
  }

  set alive(bool alive) {
    if (alive) {
      status.remove(Status.dead);
      status.add(Status.alive);
    } else {
      status.remove(Status.alive);
      status.add(Status.dead);
    }
  }

  set inLove(bool inlove) {
    if (inlove) {
      status.add(Status.inlove);
    } else {
      status.remove(Status.inlove);
    }
  }

  set protected(bool protected) {
    if (protected) {
      status.add(Status.protected);
    } else {
      status.remove(Status.protected);
    }
  }

  static const double picRadius = 28;

  Widget get profilePicture => avatarPicName == ""
      ? buildDefaultPicture()
      : buildProfilePicture(avatarPicName);

  Widget profilePictureWithRadius(double radius) => avatarPicName == ""
      ? buildDefaultPicture(radius: radius)
      : buildProfilePicture(avatarPicName, radius: radius);

  Widget buildProfilePicture(String picPath, {double? radius}) {
    return CircleAvatar(
      radius: radius ?? picRadius,
      backgroundImage: AssetImage(
        "assets/player_pics/$avatarPicName",
      ),
    );
  }

  Widget buildDefaultPicture({double? radius}) {
    return ProfilePicture(
      name: name,
      radius: radius ?? picRadius,
      fontsize: radius ?? 30,
      count: 2,
    );
  }


  static IconData getStatusIcon(Status stat) {
    switch(stat) {
      case Status.alive:
        return Icons.healing;
      case Status.dead:
        return Icons.cancel_outlined;
      case Status.inlove:
        return Icons.heart_broken;
      case Status.protected:
        return Icons.shield_moon;
    }
  }

  // Elije el color con mayor prioridad (su orden es el orden del enum)
  Color getStatusMainColor() {
    for (Status stat in Status.values) {
      if (status.contains(stat)) {
        return getStatusColor(stat);
      }
    }
    return Colors.transparent;
  }

  static Color getStatusColor(Status stat) {
    switch (stat) {
      case Status.alive:
        return Colors.green;
      case Status.dead:
        return Colors.black;
      case Status.protected:
        return Colors.amber;
      case Status.inlove:
        return Colors.pink;
    }
  }

  // Hasheado por id
  @override
  bool operator ==(other) => other is Player && id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return "$name${rol != null ? " ($rol)" : ""}";
  }
}
