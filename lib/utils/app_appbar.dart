import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kps/utils/app_colors.dart';
import 'package:kps/utils/app_text_style.dart';

class AppAppBars {
  static AppBar appBarSimple(
      {required String title,
      required Function()? onTapForBack,
      Widget? trailing,
      Color backgroundColor = Colors.white}) {
    return AppBar(
      backgroundColor: backgroundColor,
      shadowColor: AppColors.TRANSPARENT_COLOR,
      leadingWidth: 66,
      toolbarHeight: 40,
      centerTitle: true,
      leading: GestureDetector(
        onTap: onTapForBack,
        child: Icon(
          Icons.arrow_back,
          color: AppColors.BLACK_COLOR,
          size: 30.w,
        ),
      ),
      title: Text(
        title,
        style: AppTextStyle.customtextStyle(
          fontSize: 17.sp,
          color: AppColors.BLACK_COLOR,
        ),
      ),
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 22),
          child: trailing ?? SizedBox.shrink(),
        )
      ],
    );
  }

  static AppBar appBarWithLeading({
    required String titleText,
    Function()? onTapForBack,
    required bool showArrow,
    Function()? onTapForDrawer,
    Function()? onTapForNoti,
    required bool showNotificationIcon,
    required bool showDrawerIcon,
    Widget? suffix,
    double? titleFontSize,
    double? toolbarHeigth,
    Color? appbarColor,
  }) {
    return AppBar(
      backgroundColor: appbarColor ?? AppColors.SCAFFOLD_COLOR,
      elevation: 0,
      surfaceTintColor: AppColors.TRANSPARENT_COLOR,
      toolbarHeight: toolbarHeigth ?? 70.0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(27.sp))),
      centerTitle: true,
      leadingWidth: (.05.sw + 42.w),
      leading: showDrawerIcon
          ? Padding(
              padding: EdgeInsets.only(left: .013.sw, right: .013.sw),
              child: GestureDetector(
                onTap: onTapForDrawer,
                child: Container(
                  width: 27.w,
                  height: 27.h,
                  padding:
                      EdgeInsets.symmetric(vertical: 14.h, horizontal: 13.w),
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.fromRGBO(255, 255, 255, 1)),
                  child: const Icon(Icons.menu, color: AppColors.BLACK_COLOR),
                ),
              ),
            )
          : showArrow
              ? Padding(
                  padding: EdgeInsets.only(left: .05.sw),
                  child: GestureDetector(
                    onTap: onTapForBack,
                    child: Container(
                      width: 42.w,
                      height: 42.h,
                      padding: EdgeInsets.symmetric(
                          vertical: 14.h, horizontal: 13.w),
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.SCAFFOLD_COLOR),
                      child: const Icon(Icons.arrow_back_outlined,
                          color: AppColors.BLACK_COLOR),
                    ),
                  ),
                )
              : const SizedBox.shrink(),
      title: Text(
        titleText,
        style: AppTextStyle.customtextStyle(
            fontSize: titleFontSize ?? 20.sp,
            color: AppColors.BLACK_COLOR,
            fontWeight: FontWeight.w600),
      ),
      titleSpacing: 0.0,
      actions: [
        suffix ?? const SizedBox.shrink(),
        showNotificationIcon
            ? Padding(
                padding: EdgeInsets.only(right: .05.sw),
                child: GestureDetector(
                  onTap: onTapForNoti,
                  child: Container(
                    width: 27.w,
                    height: 27.h,
                    padding:
                        EdgeInsets.symmetric(vertical: 0.h, horizontal: 2.w),
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.SCAFFOLD_COLOR),
                    child: const Icon(Icons.notifications,
                        color: AppColors.PRIMARY_COLOR),
                  ),
                ),
              )
            : const SizedBox.shrink(),
      ],
    );
  }

  static Widget backButton({void Function()? backFunction, Color? color}) {
    return GestureDetector(
      onTap: backFunction,
      child: Container(
          width: 42.w,
          height: 42.h,
          padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 13.w),
          decoration: const BoxDecoration(
              shape: BoxShape.circle, color: AppColors.TRANSPARENT_COLOR),
          child: Icon(Icons.arrow_back_outlined,
              color: color ?? AppColors.BLACK_COLOR)),
    );
  }
}
