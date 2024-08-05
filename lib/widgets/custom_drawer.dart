import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kps/utils/app_assets.dart';
import 'package:kps/utils/app_colors.dart';
import 'package:kps/utils/app_constants.dart';
import 'package:kps/utils/app_dialogues.dart';
import 'package:kps/utils/app_enums.dart';
import 'package:kps/utils/app_navigation.dart';
import 'package:kps/utils/app_route_name.dart';
import 'package:kps/views/login_screen.dart';
import 'package:kps/widgets/custom_avatar.dart';
import 'package:kps/widgets/custom_button.dart';
import 'package:kps/widgets/custom_navgation_tile.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer(
      {Key? key, required this.child, required this.controller, this.user})
      : super(key: key);

  final Widget child;
  final bool? user;
  final AdvancedDrawerController controller;

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer>
    with SingleTickerProviderStateMixin {
  late final animationController = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 300));

  @override
  void initState() {
    animationController.addListener(() {
      if (animationController.status == AnimationStatus.dismissed) {
        widget.controller.hideDrawer();
      }
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: AppConstants.darkThemeStatusBar,
      child: AdvancedDrawer(
        backdropColor: AppColors.DRAWER_BACKGROUND,
        controller: widget.controller,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 100),
        animateChildDecoration: true,
        rtlOpening: false,
        openRatio: 0.75,
        animationController: animationController,
        disabledGestures: false,
        childDecoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        drawer: builddrawer(context),
        child: widget.child,
      ),
    );
  }

  Widget builddrawer(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        SizedBox(height: .06.sh),
        Padding(
            padding: const EdgeInsets.only(left: 18),
            child: InkWell(
                onTap: () => widget.controller.hideDrawer(),
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.close,
                        color: AppColors.PRIMARY_COLOR_1, size: 23.sp)))),
        if (widget.user ?? false) loggedInBody() else nonLoggedInBody()
      ],
    );
  }

  Widget nonLoggedInBody() {
    return Expanded(
      child: Center(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          const Spacer(),
          Icon(Icons.warning_amber_rounded,
              color: AppColors.PRIMARY_COLOR_1, size: 75.r),
          10.verticalSpace,
          Text("You're in Guest Mode",
              style: TextStyle(
                  fontSize: 16.sp,
                  letterSpacing: 0.5,
                  color: AppColors.PRIMARY_COLOR_1,
                  fontWeight: FontWeight.w400)),
          15.verticalSpace,
          CustomButton(
            onTap: () {
              AppNavigation.navigateTo(AppRouteName.LOGIN_SCREEN_ROUTE,
                  arguments: const LoginScreenArguments(fromMenu: true));
            },
            width: 225.w,
            text: "Login",
            bgColor: AppColors.PRIMARY_COLOR_1,
            fontColor: AppColors.DRAWER_BACKGROUND,
          ),
          const Spacer(flex: 3)
        ]),
      ),
    );
  }

  Widget loggedInBody() {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          10.verticalSpace,
          userDetailWidget(),
          15.verticalSpace,
          NavigaitonTile(
            onpress: () {},
            text: "About Us",
            icon: Icon(Icons.info_outline_rounded,
                color: AppColors.PRIMARY_COLOR_1, size: 20.sp),
          ),
          NavigaitonTile(
            onpress: () {},
            text: "Visit Head Office",
            icon: Icon(Icons.pin_drop_rounded,
                color: AppColors.PRIMARY_COLOR_1, size: 20.sp),
          ),
          NavigaitonTile(
            onpress: () {},
            last: true,
            text: "Contact View",
            icon:
                Icon(Icons.call, color: AppColors.PRIMARY_COLOR_1, size: 20.sp),
          ),
          const Spacer(),
          Align(
            alignment: Alignment.centerLeft,
            child: CustomButton(
              onTap: () {
                AppDialogs.showDialogForRowRowTwoButtons(
                  titleText: "Logout",
                  contentText: 'Are you sure, you want to logout?',
                  firstButtonColor: AppColors.DISABLED_BUTTON_COLOR,
                  firstButtonText: 'Yes',
                  secondButtonText: 'No',
                  // assetPath: AppAssets.success_icon,
                  tick: Container(
                      padding: EdgeInsets.all(30.r),
                      decoration: const BoxDecoration(
                          color: Color(0xFF50C878), shape: BoxShape.circle),
                      child: Icon(Icons.logout_rounded,
                          size: 40.r, color: AppColors.WHITE_COLOR)),
                  onTapFirstButton: () {},
                  onTapSecondButton: () {
                    AppNavigation.navigatorPop();
                  },
                );
              },
              alignedCenter: false,
              width: 219.w,
              padding: EdgeInsets.symmetric(vertical: 15.h),
              prefix: Padding(
                  padding: EdgeInsets.only(left: 30.w),
                  child: Icon(Icons.logout_rounded,
                      size: 20.sp, color: const Color(0XFF003D2E))),
              fontWeight: FontWeight.w500,
              bgColor: AppColors.PRIMARY_COLOR_1,
              fontColor: const Color(0XFF003D2E),
              text: "Logout",
              borderRadius:
                  BorderRadius.horizontal(right: Radius.circular(27.r)),
            ),
          ),
          45.verticalSpace
        ],
      ),
    );
  }

  Center userDetailWidget() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          UserAvatar(
            radius: 80.r,
            cameraIcon: false,
            borderWidth: 1.5.sp,
            imgType: imageType.asset,
            userImage: AppAssets.avatar_image_1,
            borderColor: AppColors.PRIMARY_COLOR_1,
          ),
          10.verticalSpace,
          Text("John Smith",
              style: TextStyle(
                  fontSize: 18.sp,
                  letterSpacing: 0.5,
                  color: AppColors.PRIMARY_COLOR_1,
                  fontWeight: FontWeight.w400)),
          Text("@johnsmith",
              style: TextStyle(
                  fontSize: 14.sp,
                  letterSpacing: 0.5,
                  color: AppColors.PRIMARY_COLOR_1,
                  fontWeight: FontWeight.w300)),
        ],
      ),
    );
  }
}
