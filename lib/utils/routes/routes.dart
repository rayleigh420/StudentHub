import 'package:boilerplate/presentation/home/home.dart';
import 'package:boilerplate/presentation/input_login/input_login.dart';
import 'package:boilerplate/presentation/login/login.dart';
import 'package:boilerplate/presentation/signup/identity_signup/identity_signup.dart';
import 'package:boilerplate/presentation/signup/input_signup/input_signup.dart';
import 'package:flutter/material.dart';

class Routes {
  Routes._();

  //static variables
  static const String splash = '/splash';
  static const String login_boilerplate = '/login_boilerplate';
  static const String home = '/post';
  static const String login = 'login';
  static const String signup = 'signup';
  static const String identity_signup = 'identity_signup';
  static final routes = <String, WidgetBuilder>{
    login_boilerplate: (BuildContext context) => LoginScreen(),
    home: (BuildContext context) => HomeScreen(),
    login: (BuildContext context) => InputLogin(),
    signup: (BuildContext context) => InputSignUp(
          type: 1,
        ),
    identity_signup: (context) => SignUpIdentity(),
  };
}
