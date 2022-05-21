import 'package:flutter/material.dart';
import 'package:el_lobo/model/model.dart';

class RolCard extends StatefulWidget {
  final Rol rol;
  final int num;
  final int numVillagers;

  final Function() onRolUpdate;

  const RolCard(
      {Key? key,
      required this.rol,
      required this.num,
      required this.numVillagers,
      required this.onRolUpdate})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _RolCardState();
  }
}

class _RolCardState extends State<RolCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: FittedBox(
                child: Icon(
                  widget.rol.icon,
                  color: (widget.num == 0) ? null : Colors.indigoAccent,
                ),
                fit: BoxFit.fill,
              ),
            ),
            Text(
              widget.rol.name,
              maxLines: 2,
              style: Theme.of(context).textTheme.titleSmall,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  onPressed: (widget.rol == Rol.villager || widget.num == 0)
                      ? null
                      : () {
                          AppManager.instance.deleteRol(widget.rol);
                          AppManager.instance.addRol(Rol.villager);
                          widget.onRolUpdate();
                        },
                  icon: widget.rol == Rol.villager
                      ? Container()
                      : const Icon(Icons.remove),
                ),
                Text(
                  widget.num.toString(),
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                IconButton(
                  // Solo si quedan aldeanos que sustituir podras agregar un rol
                  onPressed:
                      (widget.rol == Rol.villager || widget.numVillagers == 0)
                          ? null
                          : () {
                              AppManager.instance.addRol(widget.rol);
                              AppManager.instance.deleteRol(Rol.villager);
                              widget.onRolUpdate();
                            },
                  icon: widget.rol == Rol.villager
                      ? Container()
                      : const Icon(Icons.add),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
