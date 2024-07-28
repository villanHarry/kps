import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kps/utils/app_route_name.dart';
import 'package:kps/utils/app_router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await ScreenUtil.ensureScreenSize();
  runApp(const MyApp());
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'KPS',
        debugShowCheckedModeBanner: false,
        navigatorKey: navigatorKey,
        initialRoute: AppRouteName.SPLASH_SCREEN_ROUTE,
        theme: ThemeData(
          fontFamily: "Roboto",
        ),
        onGenerateRoute: AppRouter().onGenerateRoute);
  }
}
