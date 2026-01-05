import 'package:flutter/cupertino.dart';

import '../models/user.dart';

class UserProvider extends ChangeNotifier{

  UserModel? _userModel;
  String? _token;

  ///set User
  void setUser(UserModel model){
    _userModel = model;
    notifyListeners();
  }

  ///set Token
  void setToken(String value){
    _token = value;
    notifyListeners();
  }

  ///Get User
  UserModel? getUser() => _userModel;

  ///Get Token
  String? getToken() => _token;


}