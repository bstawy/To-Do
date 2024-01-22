import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/network_layer/firebase_utils.dart';
import '../../core/provider/app_provider.dart';

class LoginViewModel extends ChangeNotifier {
  String? _userID;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  String? _loginStatus = "";

  String? get userID => _userID;
  GlobalKey<FormState>? get formKey => _formKey;
  TextEditingController? get email => _email;
  TextEditingController? get password => _password;
  String? get loginStatus => _loginStatus;

  LoginViewModel() {
    _userID = AppProvider.userID;
  }

  login() async {
    if (_formKey.currentState!.validate()) {
      final response = await FirebaseUtils.logIn(_email.text, _password.text);
      response.fold(
        (l) {
          _loginStatus = 'invalid-credential';
        },
        (r) {
          final UserCredential user = r;
          if (isVerified(user)) {
            storeUserID(user.user!.uid);
            _loginStatus = "success";
          } else {
            _loginStatus = "email-not-verified";
          }
        },
      );
    }
    if (_loginStatus!.isEmpty) _loginStatus = "invalid";
    notifyListeners();
  }

  bool isVerified(UserCredential user) {
    if (user.user!.emailVerified) {
      return true;
    }
    return false;
  }

  storeUserID(String id) async {
    _userID = id;
    AppProvider.userID = _userID;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("UID", _userID!);
  }
}
