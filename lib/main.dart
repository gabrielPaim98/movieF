import 'package:flutter/material.dart';
import 'package:movief/view/login_screen.dart';
import 'package:movief/view_model/home_view_model.dart';
import 'package:movief/view_model/login_view_model.dart';
import 'package:provider/provider.dart';
import 'view/home_page.dart';
import 'consts/colors.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
        create: (context) => HomeViewModel(), child: MyApp()),
  );
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
      routes: {
        HomePage.route: (context) => HomePage(),
        LoginScreen.route: (context) => LoginScreen()
      },
      initialRoute: LoginScreen.route,
    );
  }
}
