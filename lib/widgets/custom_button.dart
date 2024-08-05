import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kps/utils/app_colors.dart';
import 'package:kps/utils/app_text_style.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {Key? key,
      this.text,
      this.prefix,
      this.fontWeight,
      this.width,
      this.alignedCenter,
      this.height,
      this.shape,
      this.border,
      this.padding,
      this.boxShadow,
      this.onTap,
      this.fontSize,
      this.borderRadius,
      this.bgColor,
      this.textAlign,
      this.opacity,
      this.fontColor})
      : super(key: key);

  final Color? bgColor;
  final double? width;
  final double? opacity;
  final BoxBorder? border;
  final Color? fontColor;
  final double? fontSize;
  final bool? alignedCenter;
  final EdgeInsetsGeometry? padding;
  final Function()? onTap;
  final BoxShape? shape;
  final List<BoxShadow>? boxShadow;
  final FontWeight? fontWeight;
  final Widget? prefix;
  final String? text;
  final double? height;
  final BorderRadius? borderRadius;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Opacity(
        opacity: opacity ?? 1,
        child: Container(
          height: height,
          width: width ?? .8974.sw,
          padding:
              padding ?? EdgeInsets.symmetric(vertical: 15.h, horizontal: 0),
          decoration: BoxDecoration(
              border: border,
              boxShadow: boxShadow,
              shape: shape ?? BoxShape.rectangle,
              color: bgColor ?? AppColors.BUTTON_COLOR,
              borderRadius: shape == BoxShape.circle
                  ? null
                  : borderRadius ?? BorderRadius.circular(10.sp)),
          child: Row(
            mainAxisAlignment: (alignedCenter ?? true)
                ? MainAxisAlignment.center
                : MainAxisAlignment.start,
            children: [
              if (prefix != null)
                Padding(
                    padding: EdgeInsets.only(right: text == null ? 0 : 8.w),
                    child: prefix),
              if (text != null)
                Text(text ?? "",
                    textAlign: textAlign,
                    style: AppTextStyle.customtextStyle(
                        color: fontColor ?? AppColors.WHITE_COLOR,
                        fontSize: fontSize ?? 16.sp,
                        fontWeight: fontWeight ?? FontWeight.w400))
            ],
          ),
        ),
      ),
    );
  }
}
