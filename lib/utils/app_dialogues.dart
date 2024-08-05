// import 'package:another_flushbar/flushbar.dart';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kps/main.dart';
import 'package:kps/utils/app_assets.dart';
import 'package:kps/utils/app_colors.dart';
import 'package:kps/utils/app_navigation.dart';
import 'package:kps/utils/app_text_style.dart';
import 'package:kps/widgets/custom_button.dart';

// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:recovery_rtg_hybrid/utils/app_colors.dart';
// import 'package:recovery_rtg_hybrid/widgets/custom_text_widget.dart';

class AppDialogs {
  static void showToast({
    String? message,
    Toast? toastLength,
    int? timeInSecForIosWeb,
  }) {
    Fluttertoast.showToast(
        msg: message ?? "",
        toastLength: toastLength ?? Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: timeInSecForIosWeb ?? 1);
  }

// //Dialog Box With Single Button
//   Future<void> showDialogForSingleButton({
//     required BuildContext context,
//     required String assetPath,
//     required String buttonText,
//     required dynamic Function()? onTap,
//     String? titleText,
//   }) async {
//     return showDialog<void>(
//       // barrierColor: Colors.white.withOpacity(0.5),
//       context: context,
//       barrierDismissible: false,
//       builder: (BuildContext context) {
//         return BackdropFilter(
//           filter: CustomBlurFilter.getBlurFilter(),
//           child: Dialog(
//             backgroundColor: AppColors.WHITE_COLOR,
//             insetPadding:
//                 const EdgeInsets.symmetric(horizontal: 20, vertical: 10.0),
//             shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(20.r)),
//             elevation: 5,
//             child: SingleChildScrollView(
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   _dialogTitle(
//                       context, titleText ?? AppStrings.SUCESSFULL_TEXT),
//                   20.verticalSpace,
//                   _tickContainer(assetPath: assetPath, height: 130.h),
//                   _continueButton(
//                     context: context,
//                     buttonName: buttonText,
//                     onTap: onTap,
//                   ),
//                   10.verticalSpace,
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }

// //Dialog Box With Single Button With Content Text
  static Future<void> showDialogForSingleButtonWithContentText({
    String? assetPath,
    String? contentText,
    Widget? suffix,
    bool? backButton,
    Color? titleColor,
    double? imageHeight,
    required String buttonText,
    required dynamic Function()? onTap,
    dynamic Function()? onclose,
    String? titleText,
  }) async {
    return showDialog<void>(
      context: navigatorKey.currentContext!,
      barrierDismissible: false,
      barrierColor: AppColors.TRANSPARENT_COLOR,
      // barrierColor: AppColors.BLACK_COLOR.withOpacity(0.8),
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async {
            return backButton ?? true;
          },
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
            child: Dialog(
              backgroundColor: AppColors.WHITE_COLOR,
              surfaceTintColor: Colors.transparent,
              insetPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 10.0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.sp),
                  side: BorderSide(
                      width: 1.5.sp, color: AppColors.PRIMARY_COLOR)),
              elevation: 5,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _dialogTitle(context, titleText ?? 'successfully',
                        titleColor: titleColor, onTap: onclose),
                    25.verticalSpace,
                    if (assetPath != null)
                      _tickContainer(assetPath: assetPath, height: imageHeight),
                    if (contentText != null)
                      _description(contentText: contentText),
                    if (suffix != null) suffix,
                    15.verticalSpace,
                    _continueButton(
                      context: context,
                      buttonName: buttonText,
                      onTap: onTap,
                    ),
                    20.verticalSpace
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  //Will pop dialog
  static Future<void> willpopDialog({
    required BuildContext context,
  }) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      barrierColor: AppColors.BLACK_COLOR.withOpacity(0.8),
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: AppColors.WHITE_COLOR,
          insetPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 10.0),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
          elevation: 5,
          child: Container(
            height: 120.h,
            decoration: BoxDecoration(
                color: AppColors.TRANSPARENT_COLOR,
                borderRadius: BorderRadius.circular(5.sp)),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.sp),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Are you sure you want to close?",
                      style: AppTextStyle.customtextStyle(fontSize: 14.sp)),
                  10.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: CustomButton(
                          height: 40.h,
                          bgColor: AppColors.PRIMARY_COLOR,
                          onTap: () => SystemNavigator.pop(),
                          text: "Yes",
                        ),
                      ),
                      7.horizontalSpace,
                      Expanded(
                        child: CustomButton(
                          height: 40.h,
                          bgColor: AppColors.PRIMARY_COLOR,
                          onTap: () {
                            AppNavigation.navigatorPop();
                          },
                          text: "No",
                        ),
                      ),
                    ],
                  ),
                  10.verticalSpace,
                ],
              ),
            ),
          ),
        );
      },
    );
  }

// //Dialog Box With Two Buttons in a Row
  static Future<void> showDialogForRowRowTwoButtons({
    String? assetPath,
    String? contentText,
    Widget? tick,
    required String firstButtonText,
    Color? firstButtonColor,
    Color? secondButtonColor,
    Color? titleColor,
    required String secondButtonText,
    required dynamic Function()? onTapFirstButton,
    required dynamic Function()? onTapSecondButton,
    double? imageHeight,
    Widget? suffix,
    String? titleText,
  }) async {
    return showDialog<void>(
      context: navigatorKey.currentContext!,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: AppColors.WHITE_COLOR,
          surfaceTintColor: Colors.transparent,
          insetPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 10.0),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.sp)),
          elevation: 5,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _dialogTitle(context, titleText ?? 'successfully',
                    titleColor: titleColor),
                20.verticalSpace,
                if (assetPath != null)
                  _tickContainer(assetPath: assetPath, height: imageHeight),
                if (tick != null) tick,
                20.verticalSpace,
                if (contentText != null) _description(contentText: contentText),
                if (suffix != null) suffix,
                15.verticalSpace,
                Column(
                  children: [
                    _continueButton(
                      context: context,
                      buttonColor: firstButtonColor ?? AppColors.BUTTON_COLOR,
                      buttonName: firstButtonText,
                      onTap: onTapFirstButton,
                    ),
                    10.verticalSpace,
                    _continueButton(
                      context: context,
                      buttonColor: secondButtonColor ?? AppColors.BUTTON_COLOR,
                      buttonName: secondButtonText,
                      onTap: onTapSecondButton,
                    ),
                  ],
                ),
                10.verticalSpace,
              ],
            ),
          ),
        );
      },
    );
  }

// //Dialog Box With Two Buttons in a Column Second button has no border and Description textfield
//   Future<void> showDialogForColumnTwoButtonsSecondButtonHasBorderWithTextfield({
//     required BuildContext context,
//     required String assetPath,
//     required String firstButtonText,
//     required String secondButtonText,
//     required dynamic Function()? onTapFirstButton,
//     required dynamic Function()? onTapSecondButton,
//     TextEditingController? descriptionTextController,
//     String? validatorString,
//     String? titleText,
//     BoxBorder? border,
//   }) async {
//     return showDialog<void>(
//       context: context,
//       barrierDismissible: false,
//       builder: (BuildContext context) {
//         return BackdropFilter(
//           filter: CustomBlurFilter.getBlurFilter(),
//           child: Dialog(
//             backgroundColor: AppColors.WHITE_COLOR,
//             insetPadding:
//                 const EdgeInsets.symmetric(horizontal: 20, vertical: 10.0),
//             shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(20.r)),
//             elevation: 5,
//             child: SingleChildScrollView(
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   _dialogTitle(
//                       context, titleText ?? AppStrings.SUCESSFULL_TEXT),
//                   20.verticalSpace,
//                   _tickContainer(assetPath: assetPath),
//                   15.verticalSpace,
//                   _descriptionField(
//                     descriptionTextController: descriptionTextController,
//                     validatorString: validatorString,
//                     textInputFormattors: [
//                       LengthLimitingTextInputFormatter(
//                         Constants.DESCRIPTION_MAX_LENGTH,
//                       ),
//                     ],
//                   ),
//                   Column(
//                     children: [
//                       _continueButton(
//                         context: context,
//                         buttonName: firstButtonText,
//                         onTap: onTapFirstButton,
//                       ),
//                       GestureDetector(
//                         onTap: onTapSecondButton,
//                         child: Container(
//                           height: 60.h,
//                           margin: const EdgeInsets.symmetric(horizontal: 24.0),
//                           decoration: BoxDecoration(
//                             border: border ??
//                                 Border.all(
//                                   color: AppColors.PINK_TEXT_COLOR,
//                                 ),
//                             borderRadius: BorderRadius.circular(10.r),
//                           ),
//                           child: CustomText(
//                             text: secondButtonText,
//                             isLeftAlign: false,
//                             fontsize: 18.sp,
//                             fontFamily: AppFonts.poppinsSemiBold,
//                             color: AppColors.PINK_TEXT_COLOR,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   20.verticalSpace,
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }

// //Dialog Box With Two Button in a Column Second button has border
//   Future<void> showDialogForColumnTwoButtonSecondButtonHasBorder({
//     required BuildContext context,
//     required String assetPath,
//     required String contentText,
//     required String firstButtonText,
//     required String secondButtonText,
//     required dynamic Function()? onTapFirstButton,
//     required dynamic Function()? onTapSecondButton,
//     String? titleText,
//   }) async {
//     return showDialog<void>(
//       // barrierColor: Colors.redAccent.withOpacity(0.2),
//       context: context,
//       barrierDismissible: false,
//       builder: (BuildContext context) {
//         return BackdropFilter(
//           filter: CustomBlurFilter.getBlurFilter(),
//           child: Dialog(
//             backgroundColor: AppColors.WHITE_COLOR,
//             insetPadding:
//                 const EdgeInsets.symmetric(horizontal: 20, vertical: 20.0),
//             shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(20.r)),
//             elevation: 5,
//             child: SingleChildScrollView(
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   _dialogTitle(
//                       context, titleText ?? AppStrings.SUCESSFULL_TEXT),
//                   20.verticalSpace,
//                   _tickContainer(assetPath: assetPath),
//                   20.verticalSpace,
//                   _description(contentText: contentText),
//                   Column(
//                     children: [
//                       _continueButton(
//                         context: context,
//                         buttonName: firstButtonText,
//                         onTap: onTapFirstButton,
//                       ),
//                       GestureDetector(
//                         onTap: onTapSecondButton,
//                         child: Container(
//                           height: 60.h,
//                           margin: const EdgeInsets.symmetric(horizontal: 24.0),
//                           decoration: BoxDecoration(
//                             border: Border.all(
//                               color: AppColors.PINK_TEXT_COLOR,
//                             ),
//                             borderRadius: BorderRadius.circular(10.r),
//                           ),
//                           child: CustomText(
//                             text: secondButtonText,
//                             isLeftAlign: false,
//                             fontsize: 18.sp,
//                             fontFamily: AppFonts.poppinsSemiBold,
//                             color: AppColors.PINK_TEXT_COLOR,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   20.verticalSpace,
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }

// //Dialog Box With Multiple Radio Buttons and textfield also 1 button
//   Future showDisputeDialog(
//       {required BuildContext context, required String title}) {
//     return showDialog(
//       barrierDismissible: false,
//       context: context,
//       // barrierColor: AppColors.APP_GREY_COLOR.withOpacity(0.8),
//       builder: (context) {
//         return DisputeDialog(title: title);
//       },
//     );
//   }

// //Dialog Box With 5 rating stars and one button
//   Future showDisputeDialogWithStarRating(context) {
//     return showDialog(
//       barrierDismissible: false,
//       context: context,
//       // barrierColor: AppColors.APP_GREY_COLOR.withOpacity(0.8),
//       builder: (context) {
//         return StarRatingDialog();
//       },
//     );
//   }

//   //Dialog Box With 5 rating stars and one button
//   Future showDisputeDialogForInivitingInlfuencer(context) {
//     return showDialog(
//       barrierDismissible: false,
//       context: context,
//       // barrierColor: AppColors.APP_GREY_COLOR.withOpacity(0.8),
//       builder: (context) {
//         return InviteInfluencerDialog();
//       },
//     );
//   }

//Widgets For Dialog
  static Widget _dialogTitle(context, String titleText,
      {dynamic Function()? onTap, Color? titleColor}) {
    return Container(
      height: .08.sh,
      decoration: BoxDecoration(
          color: titleColor ?? AppColors.PRIMARY_COLOR,
          // gradient: LinearGradient(
          //     begin: Alignment.topCenter,
          //     end: Alignment.bottomCenter,
          //     colors: [AppColors.COAL_COLOR, AppColors.RED_COLOR]),
          borderRadius: BorderRadius.vertical(top: Radius.circular(10.sp))),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 12.h),
        child: Row(
          children: [
            SizedBox(width: 20.w),
            Expanded(
              child: Text(
                titleText,
                textAlign: TextAlign.center,
                style: AppTextStyle.customtextStyle(
                    overflow: TextOverflow.visible,
                    color: AppColors.WHITE_COLOR,
                    fontSize: 19.sp,
                    fontWeight: FontWeight.w500),
              ),
            ),
            GestureDetector(
              onTap: onTap ??
                  () {
                    AppNavigation.navigatorPop();
                  },
              child: Icon(Icons.close_rounded,
                  size: 25.sp, color: AppColors.WHITE_COLOR),
            )
          ],
        ),
      ),
    );
  }

  static Widget _continueButton(
      {required BuildContext context,
      required String buttonName,
      required dynamic Function()? onTap,
      Color? buttonColor}) {
    return CustomButton(
      width: .8.sw,
      bgColor: buttonColor == AppColors.DISABLED_BUTTON_COLOR
          ? AppColors.TRANSPARENT_COLOR
          : buttonColor ?? AppColors.BUTTON_COLOR,
      onTap: onTap,
      border: buttonColor == AppColors.DISABLED_BUTTON_COLOR
          ? Border.all(width: 1.5, color: AppColors.BUTTON_COLOR)
          : null,
      text: buttonName,
      fontColor: buttonColor == AppColors.DISABLED_BUTTON_COLOR
          ? AppColors.BUTTON_COLOR
          : AppColors.WHITE_COLOR,
      fontWeight: FontWeight.w400,
      // fontSize: 18.sp,
    );
  }

  static Widget _tickContainer({required String assetPath, double? height}) {
    return Center(
      child: Image.asset(
        assetPath,
        height: height ?? 90.h,
      ),
    );
  }

  static Widget _description({required String contentText}) {
    return SizedBox(
      width: .7136.sw,
      child: Text(
        contentText,
        maxLines: 3,
        textAlign: TextAlign.center,
        style: AppTextStyle.customtextStyle(
            color: AppColors.BLACK_COLOR,
            fontSize: 16.sp,
            height: 1.1.sp,
            fontWeight: FontWeight.w400),
      ),
    );
  }

  // Widget _descriptionField(
  //     {String? validatorString,
  //     TextEditingController? descriptionTextController,
  //     List<TextInputFormatter>? textInputFormattors}) {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(horizontal: 20.0),
  //     child: CustomTextField(
  //       // helpertext: AppStrings.DESCRIPTION,
  //       hintText: AppStrings.DELETE_DIALOG_DESCRIPTION_HINT_TEXT,
  //       hintTextColor: AppColors.BLACK_COLOR,
  //       fontSize: 16.sp,
  //       filled: true,
  //       filledColor: AppColors.DESCRIPTION_COLOR_DELETE_ACCOUNT,
  //       borderColor: AppColors.DESCRIPTION_COLOR_DELETE_ACCOUNT,
  //       focusedColor: AppColors.DESCRIPTION_COLOR_DELETE_ACCOUNT,
  //       enabledBorderColor: AppColors.DESCRIPTION_COLOR_DELETE_ACCOUNT,
  //       // textInputFormattors: [
  //       //   LengthLimitingTextInputFormatter(Constants.DESCRIPTION_MAX_LENGTH)
  //       // ],
  //       textInputFormattors: textInputFormattors,
  //       // textEditingController: controller.descriptionTextController,
  //       // validator: (value) => value?.validateDescription,
  //       textEditingController: descriptionTextController,
  //       validator: (value) => validatorString,
  //       keyboardType: TextInputType.text,
  //       isMultiLine: true,
  //       maxLines: 3,
  //       onChanged: (value) {},
  //     ),
  //   );
  // }
}
