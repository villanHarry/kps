import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kps/utils/app_assets.dart';
import 'package:kps/utils/app_constants.dart';
import 'package:kps/utils/app_local_database.dart';
import 'package:kps/utils/app_navigation.dart';
import 'package:kps/utils/app_route_name.dart';
import 'package:kps/utils/app_text_style.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3), () async {
      SharedPreference localDatabase = SharedPreference();
      await localDatabase.sharedPreference;
      bool? tutorial = localDatabase.getTutorial();
      if (tutorial == true) {
        AppNavigation.navigateToRemovingAll(AppRouteName.MAIN_SCREEN_ROUTE);
      } else {
        await localDatabase.setTutorial();
        AppNavigation.navigateToRemovingAll(AppRouteName.LOGIN_SCREEN_ROUTE);
      }
    });

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: AppConstants.lightThemeStatusBar,
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Spacer(flex: 3),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(AppAssets.logo_image,
                      width: 50.r, height: 50.r, fit: BoxFit.contain),
                  10.horizontalSpace,
                  Text("K.P.S.",
                      style: AppTextStyle.customtextStyle(
                          letterSpacing: 2.5.sp,
                          fontSize: 35.sp,
                          fontWeight: FontWeight.w600)),
                ],
              ),
              10.verticalSpace,
              Text("KARACHI POWER SOLUTIONS",
                  textAlign: TextAlign.center,
                  style: AppTextStyle.customtextStyle(
                      letterSpacing: 2.sp,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600)),
              const Spacer(),
              const CircularProgressIndicator(color: Colors.green),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
