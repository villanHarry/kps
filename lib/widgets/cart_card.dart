import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kps/services/models/cartModel.dart';
import 'package:kps/utils/app_colors.dart';
import 'package:kps/utils/app_constants.dart';
import 'package:kps/utils/app_enums.dart';
import 'package:kps/utils/app_text_style.dart';

class CartCard extends StatefulWidget {
  const CartCard({super.key, required this.index, this.onChange});

  final int index;
  final void Function()? onChange;

  @override
  State<CartCard> createState() => _CartCardState();
}

class _CartCardState extends State<CartCard> {
  late final product = AppConstants.cart.value[widget.index].product;

  void additionFunction(List<CartModel> value) {
    value[widget.index].quantity =
        (value[widget.index].quantity ?? 1).toInt() + 1;
    widget.onChange?.call();
  }

  void subtractionFunction(List<CartModel> value) {
    if (value[widget.index].quantity == 1) {
      value.removeAt(widget.index);
    } else {
      value[widget.index].quantity =
          (value[widget.index].quantity ?? 1).toInt() - 1;
    }
    widget.onChange?.call();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      margin: EdgeInsets.only(bottom: 10.h),
      padding: EdgeInsets.all(8.r),
      decoration: BoxDecoration(
          color: AppColors.WHITE_COLOR,
          borderRadius: BorderRadius.circular(10.sp),
          boxShadow: [
            BoxShadow(
                color: AppColors.BLACK_COLOR.withOpacity(.1),
                offset: const Offset(0, 0),
                blurRadius: 4.sp)
          ]),
      child: ValueListenableBuilder(
          valueListenable: AppConstants.cart,
          builder: (context, value, child) {
            return Row(
              children: [
                imageWidget(),
                10.horizontalSpace,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    nameWidget(),
                    5.verticalSpace,
                    priceWidget(),
                  ],
                ),
                const Spacer(),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                        onTap: () => subtractionFunction(value),
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 15.h),
                          child: Icon(Icons.minimize_rounded,
                              color: AppColors.PRIMARY_COLOR, size: 25.sp),
                        )),
                    15.horizontalSpace,
                    Container(
                      padding: EdgeInsets.all(10.r),
                      decoration: const BoxDecoration(
                        color: AppColors.PRIMARY_COLOR,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        (value[widget.index].quantity ?? 0).toString(),
                        style: AppTextStyle.customtextStyle(
                            color: AppColors.WHITE_COLOR,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    15.horizontalSpace,
                    GestureDetector(
                      onTap: () => additionFunction(value),
                      child: Icon(Icons.add,
                          color: AppColors.PRIMARY_COLOR, size: 25.sp),
                    ),
                  ],
                ),
              ],
            );
          }),
    );
  }

  Widget priceWidget() {
    return Text("Rs.${((product?.price ?? 0) / 1000).toStringAsFixed(0)}K",
        style: AppTextStyle.customtextStyle(
            fontSize: 14.sp, fontWeight: FontWeight.w500));
  }

  Widget nameWidget() {
    return Text(product?.name ?? "",
        maxLines: 2,
        style: AppTextStyle.customtextStyle(
            overflow: TextOverflow.visible,
            fontSize: 12.sp,
            fontWeight: FontWeight.w400));
  }

  Widget imageWidget() {
    switch (product?.type) {
      case imageType.asset:
        return Container(
            height: 50.r,
            width: 50.r,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.sp),
                border: Border.all(color: Colors.grey.shade300),
                image: DecorationImage(
                    image: AssetImage(product?.image ?? ""),
                    fit: BoxFit.cover)));

      case imageType.network:
        return CachedNetworkImage(
            imageUrl: product?.image ?? "",
            imageBuilder: (context, imageProvider) => Container(
                height: 50.r,
                width: 50.r,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.sp),
                    border: Border.all(color: Colors.grey.shade300),
                    image: DecorationImage(
                        image: imageProvider, fit: BoxFit.cover))),
            progressIndicatorBuilder: (context, url, progress) => Container(
                  height: 50.r,
                  width: 50.r,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.sp),
                      border: Border.all(color: Colors.grey.shade300),
                      color: AppColors.SCAFFOLD_COLOR),
                  child: Center(
                    child: CircularProgressIndicator(
                        value: progress.progress,
                        color: AppColors.WHITE_COLOR,
                        strokeWidth: 2),
                  ),
                ),
            errorWidget: (context, url, error) => Container(
                  height: 50.r,
                  width: 50.r,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.sp),
                      border: Border.all(color: Colors.grey.shade300),
                      color: AppColors.SCAFFOLD_COLOR),
                  child: const Icon(Icons.error_outline,
                      color: AppColors.PRIMARY_COLOR),
                ));

      default:
        return SizedBox(height: 50.r, width: 50.r);
    }
  }
}
