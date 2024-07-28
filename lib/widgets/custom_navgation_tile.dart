import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kps/utils/app_colors.dart';

class NavigaitonTile extends StatefulWidget {
  const NavigaitonTile(
      {Key? key,
      required this.text,
      this.icon,
      this.suffix,
      this.onpress,
      this.primaryColor,
      this.padding,
      this.last = false})
      : super(key: key);

  final Widget? icon;
  final Widget? suffix;
  final String text;
  final Color? primaryColor;
  final void Function()? onpress;
  final EdgeInsetsGeometry? padding;
  final bool last;

  @override
  State<NavigaitonTile> createState() => _NavigaitonTileState();
}

class _NavigaitonTileState extends State<NavigaitonTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onpress,
      child: Container(
        padding: widget.padding ??
            EdgeInsets.symmetric(vertical: 25.h, horizontal: 24.w),
        decoration: BoxDecoration(
          border: widget.last
              ? null
              : const Border(
                  bottom:
                      BorderSide(width: 1, color: AppColors.PRIMARY_COLOR_1)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            widget.icon ?? const SizedBox.shrink(),
            Text((widget.icon != null ? "  " : "") + widget.text,
                style: TextStyle(
                    fontSize: 18.sp,
                    letterSpacing: 0.5,
                    color: AppColors.PRIMARY_COLOR_1,
                    fontWeight: FontWeight.w600)),
            widget.suffix ?? const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
