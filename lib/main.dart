import 'package:flutter/material.dart';

import 'el_lobo_app.dart';

void main() {
  ErrorWidget.builder = _errorBuilder;
  runApp(const ElLoboApp());
}

/// Pantalla de Error, Aparece cuando se realiza un throw
Widget _errorBuilder(FlutterErrorDetails details) => Material(
  child: ListView(
    shrinkWrap: true,
    children: [
      Text(
        details.exceptionAsString(),
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.red,
        ),
      ),
    ],
  ),
);