import 'package:flutter/material.dart';
import 'package:task/Screens/main_layout.dart';
import 'package:task/screens/home/home_screen.dart';
import 'package:task/screens/login_screen.dart';
import 'package:task/screens/register_screen.dart';

class AppRoutes {
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';
  static const String mainLayout = '/mainLayout';

  static final Map<String, WidgetBuilder> routes = {
    login: (context) => const LoginScreen(),
    register: (context) => const RegisterScreen(),
    home: (context) => const HomeScreen(),
    mainLayout: (context) => const MainLayout(),
  };
}
