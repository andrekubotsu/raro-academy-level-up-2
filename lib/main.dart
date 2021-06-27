import 'package:calculator_raro/pages/home_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora Raro Academy',
      themeMode: ThemeMode.dark,
      theme: ThemeData.dark(),
      home: MyHomePage(),
    );
  }
}
