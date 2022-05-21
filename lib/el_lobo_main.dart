import 'package:flutter/material.dart';

import 'el_lobo_app.dart';

void main() {
  ErrorWidget.builder = (details) => Material(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              details.exceptionAsString(),
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      );
  runApp(const ElLoboApp());
}
