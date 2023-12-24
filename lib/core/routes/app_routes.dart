import 'package:flutter/material.dart';
import 'package:test_firebase/feature/chat/presentation/screens/chat_screen.dart';

import '/feature/auth/presentation/screens/auth/login_screen.dart';
import '/feature/auth/presentation/screens/auth/register_screen.dart';
import '/feature/auth/presentation/screens/on_boarding_screens/on_boarding_screens.dart';
import '/feature/auth/presentation/screens/splash_screen/splash_screen.dart';

class Routes {
  static const String intitlRoute = '/';
  static const String onBoarding = '/onBoarding';
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';
  static const String chat = '/chat';
}

class AppRoutes {
  static Route? generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.intitlRoute:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case Routes.onBoarding:
        return MaterialPageRoute(builder: (_) => const OnBoaringScreens());
      case Routes.login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case Routes.register:
        return MaterialPageRoute(builder: (_) => const RegisterScreen());
      case Routes.chat:
        return MaterialPageRoute(builder: (_) => const ChatScreen());

      default:
        return MaterialPageRoute(
            builder: (_) => const Scaffold(
                  body: Center(
                    child: Text('No Found Route'),
                  ),
                ));
    }
  }
}
