import 'package:el_lobo/model/model.dart';
import 'package:flutter/material.dart';
import 'components.dart';

class DayNightSummary extends StatelessWidget {
  final String msg;
  final IconData icon;
  final List<DeathReport> deathReports;
  final Function() next;

  const DayNightSummary(
      {Key? key,
      required this.icon,
      required this.msg,
      this.deathReports = const [], required this.next})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: ElevatedButton(
        onPressed: next,
        child: const Text("Siguiente"),
    ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Center(
        child: ListView(
          children: [
            Icon(
              icon,
              size: 250,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(msg,
                style: Theme.of(context).textTheme.titleLarge,
                textAlign: TextAlign.center),
            const SizedBox(
              height: 20,
            ),
            DeathList(
              deaths: deathReports,
            ),
            const SizedBox(height: 50,),
          ],
        ),
      ),
    );
  }
}
