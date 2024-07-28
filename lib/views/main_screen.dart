import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kps/utils/app_appbar.dart';
import 'package:kps/utils/app_assets.dart';
import 'package:kps/utils/app_colors.dart';
import 'package:kps/utils/app_constants.dart';
import 'package:kps/utils/app_text_style.dart';
import 'package:kps/widgets/custom_drawer.dart';
import 'package:kps/widgets/custom_input_field.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Timer? timer;
  int banner = 0;
  final drawerController = AdvancedDrawerController();
  final pageController = PageController(initialPage: 0);

  void setBanner(int val) => setState(() => banner = val);
  // drawer opener
  void openDrawer() => drawerController..showDrawer();
  // notification function
  void notificationFunction() {}
  void bannerFunction() {
    timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (banner == (2)) {
        banner = 0;
      } else {
        banner++;
      }
      pageController.animateToPage(banner,
          duration: const Duration(milliseconds: 300),
          curve: Curves.fastOutSlowIn);
    });
  }

  @override
  void initState() {
    bannerFunction();
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    pageController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: AppConstants.lightThemeStatusBar,
      child: CustomDrawer(
        controller: drawerController,
        child: Scaffold(
          backgroundColor: AppColors.SCAFFOLD_COLOR,
          appBar: AppAppBars.appBarWithLeading(
              appbarColor: AppColors.SCAFFOLD_COLOR,
              showArrow: false,
              showDrawerIcon: true,
              showNotificationIcon: true,
              toolbarHeigth: .075.sh,
              titleText: "",
              onTapForNoti: notificationFunction,
              onTapForDrawer: openDrawer),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: CustomInputField(
                    hint: "Search",
                    width: 1.sw - 30.w,
                    borderRadius: BorderRadius.circular(10.sp),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
                    prefixIcon: const Icon(Icons.search, color: Colors.grey),
                    suffixIcon:
                        const Icon(Icons.filter_list, color: Colors.grey),
                    bgColor: const Color(0xFFF8F8F8),
                  ),
                ),
                20.verticalSpace,
                SizedBox(
                  width: 1.sw,
                  height: .25.sh,
                  child: PageView(
                    controller: pageController,
                    onPageChanged: (int index) => setBanner(index),
                    children: [
                      for (int i = 0; i < 3; i++)
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 15.w),
                          width: 1.sw,
                          height: .25.sh,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.sp),
                              image: DecorationImage(
                                  image: AssetImage(AppAssets.banner_image),
                                  fit: BoxFit.cover)),
                        ),
                    ],
                  ),
                ),
                20.verticalSpace,
                Center(
                  child: SizedBox(
                    width: 120.w,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        for (int i = 0; i < 3; i++)
                          Container(
                            width: 35.w,
                            height: 3.h,
                            color: banner == i
                                ? AppColors.PRIMARY_COLOR
                                : Colors.grey.shade300,
                          ),
                      ],
                    ),
                  ),
                ),
                20.verticalSpace,
                paddingWidget(
                  child: Wrap(
                    spacing: 15.w,
                    runSpacing: 15.w,
                    children: [
                      for (int i = 0; i < 6; i++)
                        Container(
                          width: .43.sw,
                          decoration: BoxDecoration(
                              color: AppColors.SCAFFOLD_COLOR,
                              borderRadius: BorderRadius.circular(10.sp),
                              boxShadow: [
                                BoxShadow(
                                    color:
                                        AppColors.BLACK_COLOR.withOpacity(.1),
                                    offset: const Offset(0, 0),
                                    blurRadius: 10.sp)
                              ]),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 100.h,
                                width: .43.sw,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.sp),
                                  image: const DecorationImage(
                                      image: AssetImage(
                                          AppAssets.solar_panel_image),
                                      fit: BoxFit.contain),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10.w, vertical: 10.h),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Panel Item - AB12345",
                                      maxLines: 2,
                                      style: AppTextStyle.customtextStyle(
                                          overflow: TextOverflow.visible,
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    5.verticalSpace,
                                    Text(
                                      "Rs.100K",
                                      style: AppTextStyle.customtextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    5.verticalSpace,
                                    // Text(
                                    //   "Lorem Ipsum sit amit diode em Ipsum sit amit diode em Ipsum sit amit diode",
                                    //   maxLines: 3,
                                    //   style: AppTextStyle.customtextStyle(
                                    //       overflow: TextOverflow.visible,
                                    //       fontSize: 9.sp,
                                    //       fontWeight: FontWeight.w300),
                                    // ),
                                    Row(
                                      children: [
                                        Image.asset(AppAssets.flash_icon,
                                            color: AppColors.PRIMARY_COLOR,
                                            width: 10.w,
                                            fit: BoxFit.fitWidth),
                                        5.horizontalSpace,
                                        Text(
                                          "3k - 5k Watt",
                                          style: AppTextStyle.customtextStyle(
                                              fontSize: 12.sp,
                                              color: AppColors.PRIMARY_COLOR,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                    5.verticalSpace,
                                    Row(
                                      children: [
                                        Icon(Icons.power,
                                            color: AppColors.PRIMARY_COLOR,
                                            size: 12.w),
                                        2.horizontalSpace,
                                        Text(
                                          "3000 volts",
                                          style: AppTextStyle.customtextStyle(
                                              fontSize: 12.sp,
                                              color: AppColors.PRIMARY_COLOR,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget paddingWidget({required Widget child}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: child,
    );
  }
}
