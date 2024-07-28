import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kps/utils/app_assets.dart';
import 'package:kps/utils/app_colors.dart';
import 'package:kps/utils/app_enums.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar(
      {super.key,
      required this.radius,
      required this.userImage,
      this.borderWidth,
      this.borderColor,
      this.cameraIcon = true,
      this.border = true,
      required this.imgType,
      this.cameraIconColor});
  final double radius;
  final String? userImage;
  final imageType imgType;
  final bool? cameraIcon;
  final Color? borderColor;
  final Color? cameraIconColor;
  final bool border;
  final double? borderWidth;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [buildImage(imgType)],
    );
  }

  Widget buildImage(imageType type) {
    switch (type) {
      case imageType.file:
      case imageType.asset:
        return Container(
          width: radius,
          height: radius,
          padding: null,
          //imgType == imageType.asset ? EdgeInsets.all(radius / 2.6) : null,
          decoration: BoxDecoration(
              color: cameraIconColor == AppColors.WHITE_COLOR
                  ? const Color(0XFF5F0672)
                  : AppColors.WHITE_COLOR,
              image: imgType == imageType.asset
                  ? userImage == null
                      ? null
                      : DecorationImage(
                          image:
                              AssetImage(userImage ?? AppAssets.place_holder),
                          fit: BoxFit.cover,
                          alignment: Alignment.topCenter,
                        )
                  : imgType == imageType.file
                      ? DecorationImage(
                          image: FileImage(File(userImage ?? "")),
                          fit: BoxFit.cover)
                      : null,
              shape: BoxShape.circle,
              border: border == false
                  ? null
                  : Border.all(
                      width: borderWidth ?? 5.0,
                      color: borderColor ?? const Color(0XFF5F0672))),
          child: imgType == imageType.asset &&
                  ((cameraIcon ?? false) || userImage == null)
              ? Container(
                  width: radius,
                  height: radius,
                  decoration: const BoxDecoration(shape: BoxShape.circle),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.camera_alt_rounded,
                        color: cameraIconColor ?? AppColors.PRIMARY_COLOR,
                        size: 25.w,
                      ),
                    ],
                  ),
                )
              : null,
        );
      case imageType.network:
        return (userImage ?? "").isEmpty
            ? Container(
                width: radius,
                height: radius,
                decoration: BoxDecoration(
                    color: AppColors.WHITE_COLOR,
                    image: const DecorationImage(
                        image: AssetImage(AppAssets.place_holder),
                        fit: BoxFit.contain),
                    shape: BoxShape.circle,
                    border: border == false
                        ? null
                        : Border.all(
                            width: borderWidth ?? 5.0,
                            color: borderColor ?? const Color(0XFF5F0672))),
              )
            : CachedNetworkImage(
                imageUrl: userImage ?? "" //"${API.url}$userImage"
                ,
                imageBuilder: (context, imageProvider) => Container(
                      width: radius,
                      height: radius,
                      decoration: BoxDecoration(
                          color: border == false ? null : AppColors.WHITE_COLOR,
                          image: DecorationImage(
                              image: imageProvider, fit: BoxFit.cover),
                          shape: BoxShape.circle,
                          border: border == false
                              ? null
                              : Border.all(
                                  width: borderWidth ?? 5.0,
                                  color:
                                      borderColor ?? const Color(0XFF5F0672))),
                    ),
                progressIndicatorBuilder: (context, url, progress) => Container(
                      width: radius + 2.r,
                      height: radius + 2.r,
                      decoration: const BoxDecoration(
                          color: AppColors.SCAFFOLD_COLOR,
                          shape: BoxShape.circle),
                      child: CircularProgressIndicator(
                          value: progress.progress,
                          color: AppColors.WHITE_COLOR,
                          strokeWidth: 2),
                    ),
                errorWidget: (context, url, error) => Container(
                      width: radius,
                      height: radius,
                      padding: EdgeInsets.all(radius / 2.2),
                      decoration: BoxDecoration(
                          color: AppColors.WHITE_COLOR,
                          shape: BoxShape.circle,
                          border: border == false
                              ? null
                              : Border.all(
                                  width: borderWidth ?? 5.0,
                                  color:
                                      borderColor ?? const Color(0XFF5F0672))),
                      child: const Icon(
                        Icons.error_outline,
                        color: AppColors.ERROR_COLOR,
                      ),
                    ));
      default:
        return Container();
    }
  }
}
