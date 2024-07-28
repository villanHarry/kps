import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kps/utils/app_assets.dart';
import 'package:kps/utils/app_colors.dart';
import 'package:kps/utils/app_constants.dart';
import 'package:kps/utils/app_enums.dart';
import 'package:kps/widgets/custom_avatar.dart';
import 'package:kps/widgets/custom_navgation_tile.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({Key? key, required this.child, required this.controller})
      : super(key: key);

  final Widget child;
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
        backdropColor: const Color(0XFF003D2E),
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
                child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child:
                        Icon(Icons.close, color: AppColors.PRIMARY_COLOR_1)))),
        15.verticalSpace,
        Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              UserAvatar(
                radius: 120.r,
                cameraIcon: false,
                borderWidth: 1.5.sp,
                imgType: imageType.asset,
                userImage: AppAssets.avatar_image_1,
                borderColor: AppColors.PRIMARY_COLOR_1,
              ),
              15.verticalSpace,
              Text("John Smith",
                  style: TextStyle(
                      fontSize: 24.sp,
                      letterSpacing: 0.5,
                      color: AppColors.PRIMARY_COLOR_1,
                      fontWeight: FontWeight.w400)),
              Text("@johnsmith",
                  style: TextStyle(
                      fontSize: 16.sp,
                      letterSpacing: 0.5,
                      color: AppColors.PRIMARY_COLOR_1,
                      fontWeight: FontWeight.w300)),
            ],
          ),
        ),
        15.verticalSpace,
        NavigaitonTile(
          onpress: () {},
          text: "About Us",
          icon: Icon(Icons.info_outline_rounded,
              color: AppColors.PRIMARY_COLOR_1, size: 24.sp),
        ),
        NavigaitonTile(
          onpress: () {},
          text: "Visit Head Office",
          icon: Icon(Icons.pin_drop_rounded,
              color: AppColors.PRIMARY_COLOR_1, size: 24.sp),
        ),
        NavigaitonTile(
          onpress: () {},
          last: true,
          text: "Contact View",
          icon: Icon(Icons.call, color: AppColors.PRIMARY_COLOR_1, size: 24.sp),
        ),
        const Spacer(),
      ],
    );
  }
}
