import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/network_layer/firebase_utils.dart';
import '../../core/provider/app_provider.dart';

class LoginViewModel extends ChangeNotifier {
  String? _userID;
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  LoginViewModel() {
    _userID = AppProvider.userID;
  }

  String? get userID => _userID;
  TextEditingController? get email => _email;
  TextEditingController? get password => _password;

  storeUserID(String id) async {
    _userID = id;
    AppProvider.userID = id;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("UID", _userID!);
  }

  Future<String> login({required var formKey}) async {
    String loginStatus = "";
    if (formKey.currentState!.validate()) {
      final response = await FirebaseUtils.logIn(_email.text, _password.text);
      response.fold((l) {
        loginStatus = 'invalid-credential';
      }, (r) {
        final UserCredential user = r;
        storeUserID(user.user!.uid);
        loginStatus =  "success";
      });
    }
    if (loginStatus.isEmpty) loginStatus = "invalid";
    return loginStatus;
  }
}
