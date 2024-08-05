import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kps/services/models/cartModel.dart';

class AppConstants {
  static ValueNotifier<List<CartModel>> cart = ValueNotifier([]);
  static void unfocus() => FocusManager.instance.primaryFocus?.unfocus();

  static const darkThemeStatusBar = SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.black,
      systemNavigationBarIconBrightness: Brightness.light,
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.dark);

  static const lightThemeStatusBar = SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light);
}
