import 'package:boilerplate/presentation/alert/alert.dart';
import 'package:boilerplate/presentation/browse_project/browse_project_main.dart';
import 'package:boilerplate/presentation/dashboard/dashboard.dart';
import 'package:boilerplate/presentation/home/home.dart';
import 'package:boilerplate/presentation/input_login/input_login.dart';
import 'package:boilerplate/presentation/login/login.dart';
import 'package:boilerplate/presentation/message/message.dart';
import 'package:boilerplate/presentation/profile/profile.dart';
import 'package:boilerplate/presentation/saved_project/saved_project.dart';
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
  static const String signup = '/signup';
  static const String identity_signup = '/identity_signup';
  static const String saved_project = '/saved_project';
  static const String project = '/project';
  static const String message = '/message';
  static const String alert = '/alert';
  static const String dashboard = '/dashboard';
  static const String profile = '/profile';

  static final routes = <String, WidgetBuilder>{
    login_boilerplate: (BuildContext context) => LoginScreen(),
    home: (BuildContext context) => HomeScreen(),
    login: (BuildContext context) => InputLogin(),
    signup: (BuildContext context) => InputSignUp(
          type: 1,
        ),
    identity_signup: (context) => SignUpIdentity(),
    saved_project: (context) => SavedProject(),
    // project: (context) => BrowseProjectScreen(),
    message: (context) => MessageScreen(),
    alert: (context) => AlerttScreen(),
    dashboard: (context) => DashBoardScreen(),
    profile: (context) => ProfileScreen(),
  };
}
