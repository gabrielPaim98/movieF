import 'package:flutter/material.dart';
import 'package:movief/consts/colors.dart';
import 'package:movief/view/home_page.dart';

class LoginScreen extends StatelessWidget {
  static const route = 'login_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KDarker,
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Spacer(flex: 3,),
            Image.asset('assets/launcher/movieF.png', height: MediaQuery.of(context).size.height*0.5),
            Spacer(flex: 5,),
            Text('Entre com ums das opções abaixo', style: TextStyle(fontSize: 18),),
            Spacer(),
            GestureDetector(
              onTap: () {
                Navigator.popAndPushNamed(context, HomePage.route);
              },
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: KWhite,
                  borderRadius: BorderRadius.all(Radius.circular(20))
                ),
                child: Icon(Icons.login_outlined, color: KDarker,),
              ),
            ),
            Spacer(flex: 3,)
          ],
        ),
      ),
    );
  }
}
