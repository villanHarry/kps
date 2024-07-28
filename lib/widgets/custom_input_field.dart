import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kps/utils/app_assets.dart';
import 'package:kps/utils/app_colors.dart';
import 'package:kps/utils/app_text_style.dart';
import 'package:kps/utils/app_validators.dart';

class CustomInputField extends StatefulWidget {
  CustomInputField(
      {Key? key,
      this.prefixIcon,
      required this.hint,
      this.onTap,
      this.width,
      this.prefixText,
      this.suffixText,
      this.borderRadius,
      this.onChanged,
      this.suffixIcon,
      this.maxLines,
      this.keyboardType,
      this.inputFormatters,
      this.style,
      this.hintStyle,
      this.labelStyle,
      this.enable,
      this.readOnly,
      this.textInputAction,
      this.label,
      this.borderSide,
      this.validator,
      this.maxCharacters = 0,
      this.constraints,
      this.contentPadding,
      this.onEditingComplete,
      this.onFieldSubmitted,
      this.prefixIconConstraints,
      this.suffixIconConstraints,
      this.bgColor,
      this.focusNode,
      this.obscureText,
      TextEditingController? controller})
      : controller = controller ?? TextEditingController(),
        super(key: key);

  final double? width;
  final bool? obscureText;
  final FocusNode? focusNode;
  final int? maxCharacters;
  final bool? enable;
  final TextInputAction? textInputAction;
  final bool? readOnly;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final int? maxLines;
  final Function(String)? onChanged;
  final TextEditingController? controller;
  final TextStyle? style;
  final EdgeInsetsGeometry? contentPadding;
  final TextStyle? hintStyle;
  final TextStyle? labelStyle;
  final String hint;
  final String? prefixText;
  final String? suffixText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Color? bgColor;
  final String? Function(String?)? validator;
  final BorderRadius? borderRadius;
  final BorderSide? borderSide;
  final void Function()? onTap;
  final String? label;
  final BoxConstraints? constraints;
  final void Function()? onEditingComplete;
  final void Function(String)? onFieldSubmitted;
  final BoxConstraints? prefixIconConstraints;
  final BoxConstraints? suffixIconConstraints;

  @override
  State<CustomInputField> createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {
  bool passwordVisible = false;
  bool onShow = true;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width ?? .8974.sw,
      child: TextFormField(
        enabled: widget.enable,
        onTap: widget.onTap,
        key: widget.key,
        obscuringCharacter: '*',
        obscureText: (widget.obscureText ?? false) ? onShow : false,
        focusNode: widget.focusNode,
        maxLength: widget.maxCharacters == 0 ? null : widget.maxCharacters,
        textInputAction: widget.textInputAction,
        onEditingComplete: widget.onEditingComplete,
        onFieldSubmitted: widget.onFieldSubmitted,
        readOnly: widget.readOnly ?? false,
        inputFormatters: widget.inputFormatters,
        keyboardType: widget.keyboardType,
        maxLines: widget.maxLines == 0 ? null : widget.maxLines ?? 1,
        controller: widget.controller,
        onChanged: (value) {
          setState(() {});
          if (widget.onChanged != null) {
            widget.onChanged!(value);
          }
        },
        style: widget.style ??
            TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF7A7979)),
        cursorColor: Colors.black,
        decoration: InputDecoration(
            constraints: widget.constraints,
            counterText: "",
            errorMaxLines: 2,
            errorStyle: AppTextStyle.customtextStyle(
                color: AppColors.ERROR_COLOR,
                fontSize: 12.5.sp,
                fontWeight: FontWeight.w400),
            hintText: widget.hint,
            isCollapsed: true,
            contentPadding: widget.contentPadding ??
                EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
            hintStyle: widget.hintStyle ??
                AppTextStyle.customtextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF7A7979)),
            label: widget.label != null
                ? Theme(
                    data: Theme.of(context).copyWith(),
                    child: Column(
                      children: [
                        35.verticalSpace,
                        Text(widget.label ?? "",
                            style: widget.labelStyle ??
                                AppTextStyle.customtextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFF2E2E2E),
                                ))
                      ],
                    ),
                  )
                : null,
            prefixText: widget.prefixText,
            suffixText: widget.suffixText,
            suffixIcon: widget.suffixIcon ??
                ((widget.obscureText ?? false)
                    ? Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                            10.horizontalSpace,
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  onShow = !onShow;
                                });
                              },
                              child: Icon(
                                  onShow
                                      ? Icons.hide_source_rounded
                                      : Icons.panorama_fish_eye,
                                  color: const Color(0XFF2E2E2E),
                                  size: 19.sp),
                            ),
                            15.horizontalSpace,
                          ])
                    : const SizedBox.shrink()),
            suffixIconConstraints:
                widget.suffixIconConstraints ?? BoxConstraints(minWidth: 45.w),
            prefixIcon: widget.prefixIcon,
            prefixIconConstraints:
                widget.prefixIconConstraints ?? BoxConstraints(minWidth: 45.w),
            alignLabelWithHint: true,
            filled: true,
            fillColor: widget.bgColor ?? AppColors.WHITE_COLOR,
            focusColor: Colors.grey.shade200,
            enabledBorder: OutlineInputBorder(
                borderSide: widget.borderSide ?? BorderSide.none,
                borderRadius:
                    widget.borderRadius ?? BorderRadius.circular(100.sp)),
            focusedBorder: OutlineInputBorder(
                borderSide: widget.borderSide ?? BorderSide.none,
                borderRadius:
                    widget.borderRadius ?? BorderRadius.circular(100.sp)),
            disabledBorder: widget.borderSide == null
                ? null
                : OutlineInputBorder(
                    borderSide: widget.borderSide ?? BorderSide.none,
                    borderRadius:
                        widget.borderRadius ?? BorderRadius.circular(100.sp)),
            border: OutlineInputBorder(
                borderSide: widget.borderSide ?? BorderSide.none,
                borderRadius:
                    widget.borderRadius ?? BorderRadius.circular(100.sp))),
        validator: widget.validator ??
            (val) => val?.validateEmpty(widget.label ?? widget.hint),
      ),
    );
  }
}
