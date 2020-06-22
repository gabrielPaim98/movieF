import 'package:flutter/material.dart';
import 'view/home_page.dart';
import 'consts/colors.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: KDark,
        primaryColor: KDarker,
        accentColor: KWhiter,
        textTheme: Theme.of(context).textTheme.apply(
          fontFamily: 'Gilroy',
          bodyColor: KWhiter,
          displayColor: KWhiter,
          decorationColor: KWhiter,
        ),
      ),
      home: HomePage(),
    );
  }
}