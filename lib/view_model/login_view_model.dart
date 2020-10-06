import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movief/service/sign_in.dart';
import 'package:movief/view/home_page.dart';

class LoginViewModel {
  static loginWithGoogle(BuildContext context) async {
    User _user = await signInWithGoogle();

    Navigator.popAndPushNamed(context, HomePage.route);
  }
}
