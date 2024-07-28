import 'package:flutter/material.dart';
import 'package:kps/utils/app_route_name.dart';
import 'package:kps/views/login_screen.dart';
import 'package:kps/views/main_screen.dart';
import 'package:kps/views/splash_screen.dart';

String route = "";

class AppRouter {
  Route onGenerateRoute(RouteSettings routeSettings) {
    route = routeSettings.name ?? "";
    return MaterialPageRoute(
        settings: routeSettings,
        builder: (BuildContext context) {
          switch (routeSettings.name) {
            //-------------- Common Navigation Routes ---------------------- //

            // Splash Screen
            case AppRouteName.SPLASH_SCREEN_ROUTE:
              return const SplashScreen();

            // Login Screen
            case AppRouteName.LOGIN_SCREEN_ROUTE:
              return const LoginScreen();

            // Main Screen
            case AppRouteName.MAIN_SCREEN_ROUTE:
              return const MainScreen();

            default:
              return const Placeholder();
          }
        });
  }
}
