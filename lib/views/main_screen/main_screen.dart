import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kps/services/models/cartModel.dart';
import 'package:kps/utils/app_appbar.dart';
import 'package:kps/utils/app_assets.dart';
import 'package:kps/utils/app_colors.dart';
import 'package:kps/utils/app_constants.dart';
import 'package:kps/utils/app_navigation.dart';
import 'package:kps/utils/app_route_name.dart';
import 'package:kps/utils/app_text_style.dart';
import 'package:kps/views/main_screen/data/products.dart';
import 'package:kps/widgets/custom_drawer.dart';
import 'package:kps/widgets/custom_input_field.dart';
import 'package:kps/widgets/product_widget.dart';

class MainScreenArguments {
  const MainScreenArguments({this.user});

  final bool? user;
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key, this.user});

  final bool? user;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Timer? timer;
  List<CartModel> value = AppConstants.cart.value;
  int banner = 0;
  final drawerController = AdvancedDrawerController();
  final pageController = PageController(initialPage: 0);

  int valueQuantity(List<CartModel> val) {
    int quantity = 0;
    for (var element in val) {
      quantity += element.quantity ?? 1;
    }
    return quantity;
  }

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
        user: widget.user,
        child: Scaffold(
          backgroundColor: AppColors.SCAFFOLD_COLOR,
          appBar: appBar(),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                searchField(),
                20.verticalSpace,
                bannerWidget(),
                20.verticalSpace,
                bannerCounter(),
                20.verticalSpace,
                paddingWidget(
                  child: Wrap(
                    spacing: 15.w,
                    runSpacing: 15.w,
                    children: [
                      for (int i = 0; i < products.length; i++)
                        ProductWidget(
                          index: i,
                          cart: value,
                          onChange: (val) {
                            value = val;
                            setState(() {});
                          },
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

  AppBar appBar() {
    return AppAppBars.appBarWithLeading(
        appbarColor: AppColors.SCAFFOLD_COLOR,
        showArrow: false,
        showDrawerIcon: true,
        showNotificationIcon: true,
        toolbarHeigth: .075.sh,
        titleText: "",
        suffix: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.only(right: .01.sw),
              child: GestureDetector(
                onTap: () {
                  AppConstants.cart.value = value;
                  AppNavigation.navigateTo(AppRouteName.CART_SCREEN);
                },
                child: cartIcon(value),
              ),
            )
          ],
        ),
        onTapForNoti: notificationFunction,
        onTapForDrawer: openDrawer);
  }

  Widget cartIcon(List<CartModel> value) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 27.w,
          height: 27.h,
          padding: EdgeInsets.symmetric(vertical: 0.h, horizontal: 2.w),
          decoration: const BoxDecoration(
              shape: BoxShape.circle, color: AppColors.SCAFFOLD_COLOR),
          child: Icon(
              value.isNotEmpty
                  ? Icons.shopping_bag
                  : Icons.shopping_bag_outlined,
              color: AppColors.PRIMARY_COLOR,
              size: 28.sp),
        ),
        if (value.isNotEmpty)
          Positioned(
            top: 8.h,
            right: 5.w,
            child: Container(
                width: 15.w, height: 10.h, color: AppColors.PRIMARY_COLOR),
          ),
        if (value.isNotEmpty)
          Positioned(
            left: valueQuantity(value) < 10 ? 12.2.w : 10.5.w,
            top: valueQuantity(value) < 10 ? 9.h : 11.h,
            child: Text(
              valueQuantity(value).toString(),
              style: AppTextStyle.customtextStyle(
                  fontSize: valueQuantity(value) < 10 ? 13.sp : 10.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.WHITE_COLOR),
            ),
          )
      ],
    );
  }

  Widget bannerCounter() {
    return Center(
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
    );
  }

  Widget bannerWidget() {
    return SizedBox(
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
                  image: const DecorationImage(
                      image: AssetImage(AppAssets.banner_image),
                      fit: BoxFit.cover)),
            ),
        ],
      ),
    );
  }

  Widget searchField() {
    return Center(
      child: CustomInputField(
        hint: "Search",
        width: 1.sw - 30.w,
        borderRadius: BorderRadius.circular(10.sp),
        contentPadding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
        prefixIcon: const Icon(Icons.search, color: Colors.grey),
        suffixIcon: const Icon(Icons.filter_list, color: Colors.grey),
        bgColor: const Color(0xFFF8F8F8),
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
