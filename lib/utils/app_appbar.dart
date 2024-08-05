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
                  child: Icon(Icons.menu,
                      color: AppColors.BLACK_COLOR, size: 28.sp),
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
                    child: Icon(Icons.notifications,
                        color: AppColors.PRIMARY_COLOR, size: 28.sp),
                  ),
                ),
              )
            : const SizedBox.shrink(),
      ],
    );
  }

  static Widget backButton(
      {void Function()? backFunction, Color? color, Color? bgColor}) {
    return GestureDetector(
      onTap: backFunction,
      child: Container(
          width: 42.w,
          height: 42.h,
          padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 13.w),
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: bgColor ?? AppColors.TRANSPARENT_COLOR),
          child: Icon(Icons.arrow_back_outlined,
              color: color ?? AppColors.BLACK_COLOR)),
    );
  }

  static Widget titleWidget(
      {String? title,
      String? description,
      bool? back,
      void Function()? backFunction}) {
    return Column(
      children: [
        SizedBox(height: .097.sh),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (back ?? false)
              GestureDetector(
                onTap: backFunction,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(.02.sw, .02.sw, .02.sw, 0.03),
                  child: Icon(Icons.arrow_back,
                      color: AppColors.BLACK_COLOR, size: .068.sw),
                ),
              )
            else
              GestureDetector(
                onTap: backFunction,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(.02.sw, .02.sw, .02.sw, 0.03),
                  child: Icon(Icons.close,
                      color: AppColors.BLACK_COLOR, size: .068.sw),
                ),
              ),
            const Spacer(),
            Text(title ?? "",
                style: AppTextStyle.customtextStyle(
                    fontSize: 30.sp, fontWeight: FontWeight.w500)),
            const Spacer(),
            SizedBox(width: .088.sw),
          ],
        ),
        10.verticalSpace,
        Text(description ?? "",
            style: AppTextStyle.customtextStyle(
                fontSize: 15.sp, color: Colors.grey.shade500)),
      ],
    );
  }
}
