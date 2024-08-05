import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kps/utils/app_appbar.dart';
import 'package:kps/utils/app_assets.dart';
import 'package:kps/utils/app_colors.dart';
import 'package:kps/utils/app_constants.dart';
import 'package:kps/utils/app_navigation.dart';
import 'package:kps/utils/app_route_name.dart';
import 'package:kps/utils/app_text_style.dart';
import 'package:kps/utils/app_validators.dart';
import 'package:kps/views/main_screen/main_screen.dart';
import 'package:kps/widgets/custom_button.dart';
import 'package:kps/widgets/custom_input_field.dart';

class LoginScreenArguments {
  const LoginScreenArguments({this.fromMenu});

  final bool? fromMenu;
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, this.fromMenu});

  final bool? fromMenu;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  void logInFunction() {
    if (_formKey.currentState?.validate() ?? false) {
      AppNavigation.navigateToRemovingAll(AppRouteName.MAIN_SCREEN_ROUTE,
          arguments: const MainScreenArguments(user: true));
    }
  }

  void googleFunction() {
    AppNavigation.navigateToRemovingAll(AppRouteName.MAIN_SCREEN_ROUTE,
        arguments: const MainScreenArguments(user: true));
  }

  void appleFunction() {
    AppNavigation.navigateToRemovingAll(AppRouteName.MAIN_SCREEN_ROUTE,
        arguments: const MainScreenArguments(user: true));
  }

  void signUpFUnction() {}
  void backFunction() {
    AppConstants.unfocus();
    if (widget.fromMenu ?? false) {
      AppNavigation.navigatorPop();
    } else {
      AppNavigation.navigateToRemovingAll(AppRouteName.MAIN_SCREEN_ROUTE);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: AppConstants.lightThemeStatusBar,
      child: Scaffold(
        backgroundColor: AppColors.SCAFFOLD_COLOR,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Column(
              children: [
                AppAppBars.titleWidget(
                    back: widget.fromMenu,
                    backFunction: backFunction,
                    title: "Welcome",
                    description: 'Sign into your account.'),
                25.verticalSpace,
                Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      emailField(),
                      10.verticalSpace,
                      passwordField(),
                      7.5.verticalSpace,
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 7.5.h),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text("Forgot Password?",
                              style: AppTextStyle.customtextStyle(
                                  fontSize: 16.sp,
                                  color: Colors.grey.shade500)),
                        ),
                      ),
                      7.5.verticalSpace,
                      CustomButton(
                        onTap: logInFunction,
                        text: "Login",
                      ),
                      15.verticalSpace,
                      signupWidget(),
                      15.verticalSpace,
                      Text("Or continue with",
                          style: AppTextStyle.customtextStyle(
                              fontSize: 16.sp, color: Colors.grey.shade500)),
                      15.verticalSpace,
                      CustomButton(
                          onTap: googleFunction,
                          prefix: Image.asset(AppAssets.google_icon,
                              width: 19.sp, fit: BoxFit.fitWidth),
                          text: "Sign In With Google",
                          bgColor: AppColors.WHITE_COLOR,
                          fontColor: AppColors.BLACK_COLOR,
                          border: Border.all(color: Colors.grey.shade500)),
                      10.verticalSpace,
                      CustomButton(
                          onTap: appleFunction,
                          prefix: Image.asset(AppAssets.apple_icon,
                              width: 19.sp, fit: BoxFit.fitWidth),
                          text: "Sign In With Apple",
                          bgColor: AppColors.WHITE_COLOR,
                          fontColor: AppColors.BLACK_COLOR,
                          border: Border.all(color: Colors.grey.shade500)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  RichText signupWidget() {
    return RichText(
        text: TextSpan(
            style: AppTextStyle.customtextStyle(
                fontSize: 16.sp, color: Colors.grey.shade500),
            children: [
          const TextSpan(text: "Don't have an account? "),
          TextSpan(
              recognizer: TapGestureRecognizer()..onTap = signUpFUnction,
              text: "Get Started",
              style: AppTextStyle.customtextStyle(
                  fontSize: 16.sp, color: AppColors.PRIMARY_COLOR))
        ]));
  }

  Widget passwordField() {
    return CustomInputField(
      // controller: passController,
      hint: 'Password',
      prefixIcon: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: Icon(Icons.lock_outline_rounded,
            color: AppColors.PRIMARY_COLOR, size: 25.w),
      ),
      obscureText: true,
      bgColor: const Color(0xFFF6F6F6),
      maxCharacters: 30,
      validator: (val) => val?.validateEmpty("Password"),
      onChanged: (val) {
        setState(() {});
      },
    );
  }

  Widget emailField() {
    return CustomInputField(
      // controller: emailController,
      hint: 'Email Address',
      prefixIcon: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: Icon(Icons.email_outlined,
            color: AppColors.PRIMARY_COLOR, size: 25.w),
      ),
      keyboardType: TextInputType.emailAddress,
      maxCharacters: 35,
      bgColor: const Color(0xFFF6F6F6),
      validator: (val) => val?.validateEmail,
      onChanged: (val) {
        setState(() {});
      },
    );
  }
}
