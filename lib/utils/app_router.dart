import 'package:flutter/material.dart';
import 'package:kps/utils/app_route_name.dart';
import 'package:kps/views/cart_screen.dart';
import 'package:kps/views/login_screen.dart';
import 'package:kps/views/main_screen/main_screen.dart';
import 'package:kps/views/product_screen.dart';
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
              LoginScreenArguments? arg =
                  routeSettings.arguments as LoginScreenArguments?;
              return LoginScreen(fromMenu: arg?.fromMenu);

            // Main Screen
            case AppRouteName.MAIN_SCREEN_ROUTE:
              MainScreenArguments? arg =
                  routeSettings.arguments as MainScreenArguments?;
              return MainScreen(user: arg?.user);

            //-------------- Product Routes ---------------------- //

            // Product Screen
            case AppRouteName.PRODUCT_SCREEN_ROUTE:
              ProductScreenArguments arg =
                  routeSettings.arguments as ProductScreenArguments;
              return ProductScreen(index: arg.index);

            case AppRouteName.CART_SCREEN:
              return const CartScreen();

            default:
              return const Placeholder();
          }
        });
  }
}
