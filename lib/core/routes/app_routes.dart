import 'package:flutter/material.dart';

import '../../feature/auth/presentation/screens/reset_password/reset_password.dart';
import '/feature/auth/presentation/screens/auth/login_screen.dart';
import '/feature/auth/presentation/screens/auth/register_screen.dart';
import '/feature/auth/presentation/screens/splash_screen/splash_screen.dart';

class Routes {
  static const String intitlRoute = '/';
  // static const String onBoarding = '/onBoarding';
  static const String login = '/login';
  static const String register = '/register';
  static const String forgetPassword = '/forgetPassword';
  static const String home = '/home';
}

class AppRoutes {
  static Route? generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.intitlRoute:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case Routes.forgetPassword:
        return MaterialPageRoute(builder: (_) => const ForgetPassword());
      case Routes.login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case Routes.register:
        return MaterialPageRoute(builder: (_) => const RegisterScreen());

      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text('No Found Route'),
            ),
          ),
        );
    }
  }
}
