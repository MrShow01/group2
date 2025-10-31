import 'package:flutter/material.dart';
import 'package:task/screens/home_screen.dart';
import 'package:task/screens/login_screen.dart';
import 'package:task/screens/register_screen.dart';

class AppRoutes {
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';


  static final Map<String, WidgetBuilder> routes = {
    login: (context) => const LoginScreen(),
    register: (context) => const RegisterScreen(),
    home: (context) => const HomeScreen(),
  };
}
