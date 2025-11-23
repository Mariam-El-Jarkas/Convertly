import 'package:flutter/material.dart';
import 'home.dart';

void main() {
  runApp(UnitConverterApp());
}

class UnitConverterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Convertly',
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
