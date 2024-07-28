import 'package:flutter/material.dart';
import 'package:kps/main.dart';

class AppNavigation {
  static navigateToRemovingAll(String routeName, {Object? arguments}) async {
    Navigator.pushNamedAndRemoveUntil(navigatorKey.currentContext!, routeName,
        (Route<dynamic> route) => false,
        arguments: arguments);
  }

  static navigatetoRemoveAll() {
    Navigator.popUntil(navigatorKey.currentContext!, (route) => route.isFirst);
  }

  static navigateTo(String routeName, {Object? arguments}) async {
    Navigator.pushNamed(navigatorKey.currentContext!, routeName,
        arguments: arguments);
  }

  static navigateReplacementNamed(String routeName, {Object? arguments}) async {
    Navigator.pushReplacementNamed(navigatorKey.currentContext!, routeName,
        arguments: arguments);
  }

  static navigatorPop({dynamic value}) {
    Navigator.pop(navigatorKey.currentContext!, value);
  }

  static navigateCloseDialog() async {
    Navigator.of(navigatorKey.currentContext!, rootNavigator: true).pop();
  }
}
