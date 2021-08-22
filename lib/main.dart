import 'package:flutter/material.dart';
import 'package:weather_app/Widgets/homepage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  build(BuildContext context) {
    return MaterialApp(
      title: 'weather app',
      home: HomePage(),
    );
  }
}
