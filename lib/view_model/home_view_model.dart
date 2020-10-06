import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:movief/model/mov_user.dart';

/// Classe model do Provider
///
/// Para utilizar algum widget que utiliza uma variável do model ->
/// Consumer<HomeViewModel>(
///   builder: (context, homeViewModel, child) =>
///   Widget(
///      top: homeViewModel.variável
///                     ),
///                    ),
///
/// Para utilizar alguma função do model ->
/// Provider.of<HomeViewModel>(context, listen: false).funçãoDoModel();
///


class HomeViewModel extends ChangeNotifier {
  MovUser currentUser;

  void setCurrentUser(User user){

    this.currentUser = MovUser(
      displayName: user.displayName,
      photoURL: user.photoURL,
    );
  }
}
