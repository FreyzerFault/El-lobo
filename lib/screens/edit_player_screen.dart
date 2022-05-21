import 'package:flutter/material.dart';
import 'package:el_lobo/model/model.dart';

class EditPlayerScreen extends StatefulWidget {
  final Function(Player player)? onCreate;
  final Player? player;

  final bool isUpdating;

  const EditPlayerScreen._({this.player, Key? key, this.onCreate})
      : isUpdating = (player != null),
        super(key: key);

  // Solo se puede construir de dos maneras, pasandole el jugador para actualizarlo
  factory EditPlayerScreen.update(Player player) {
    return EditPlayerScreen._(player: player,);
  }
  // O pasandole la funcion onCreate para actualizar el PlayerGrid una vez se
  // añada el jugador
  factory EditPlayerScreen.create(Function(Player player) onCreate) {
    return EditPlayerScreen._(onCreate: onCreate,);
  }

  @override
  State<StatefulWidget> createState() => _EditPlayerScreenState();
}

class _EditPlayerScreenState extends State<EditPlayerScreen> {
  final _nameController = TextEditingController();
  String _name = '';

  @override
  void initState() {
    super.initState();

    final player = widget.player;
    if (player != null) {
      _nameController.text = player.name;
      _name = player.name;
    }

    _nameController.addListener(() {
      setState(() {
        _name = _nameController.text;
      });
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Nuevo Jugador"),
        actionsIconTheme: IconThemeData(
          color: Theme.of(context).colorScheme.onPrimary,
          size: 30,
        ),
        iconTheme: IconThemeData(
          color: Theme.of(context).colorScheme.onPrimary,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () {
              widget.isUpdating
                  ? AppManager.instance.updatePlayer(widget.player!, _nameController.text, "")
                  : widget.onCreate!(
                      Player(name: _name, avatarPicName: ""));
              Navigator.pop(context);
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            buildNameField(),
            const SizedBox(
              height: 14,
            ),
            buildImageField(),
          ],
        ),
      ),
    );
  }

  Widget buildNameField() {
    return TextField(
      autofocus: true,
      controller: _nameController,
      decoration: const InputDecoration(
        hintText: 'Nombre',
        enabledBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
        focusedBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: Colors.green)),
        border:
            UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
      ),
    );
  }

  Widget buildImageField() {
    return Image.asset(
      "assets/player_pics/defaultImage.jpg",
    );
  }
}
