import 'package:kps/utils/app_navigation.dart';
import 'package:kps/utils/app_route_name.dart';
import 'package:kps/views/product_screen.dart';

import '../utils/app_enums.dart';
import 'package:flutter/material.dart';
import 'package:kps/utils/app_colors.dart';
import 'package:kps/utils/app_assets.dart';
import 'package:kps/utils/app_constants.dart';
import 'package:kps/utils/app_text_style.dart';
import 'package:kps/services/models/cartModel.dart';
import 'package:kps/views/main_screen/data/products.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ProductWidget extends StatefulWidget {
  final int index;
  final void Function(List<CartModel>)? onChange;
  final List<CartModel> cart;
  const ProductWidget(
      {super.key, required this.index, required this.cart, this.onChange});

  @override
  State<ProductWidget> createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  void additionFunction() {
    final value = widget.cart;
    int index = indexWhere(value);
    if (index != -1) {
      value[index].quantity = (value[index].quantity ?? 0) + 1;
    } else {
      value.add(CartModel(product: products[widget.index], quantity: 1));
    }
    widget.onChange?.call(value);
  }

  void subtractionFunction() {
    final value = widget.cart;
    int index = indexWhere(value);
    if (index != -1) {
      int quantity = (value[index].quantity ?? 1);
      if (quantity == 1) {
        value.removeAt(index);
      } else {
        value[index].quantity = (quantity - 1);
      }
    }
    widget.onChange?.call(value);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AppConstants.cart.value = widget.cart;
        AppNavigation.navigateTo(AppRouteName.PRODUCT_SCREEN_ROUTE,
            arguments: ProductScreenArguments(index: widget.index));
      },
      child: Container(
        width: .43.sw,
        decoration: BoxDecoration(
            color: AppColors.SCAFFOLD_COLOR,
            borderRadius: BorderRadius.circular(10.sp),
            boxShadow: [
              BoxShadow(
                  color: AppColors.BLACK_COLOR.withOpacity(.1),
                  offset: const Offset(0, 0),
                  blurRadius: 10.sp)
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            imageWidget(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  nameWidget(),
                  5.verticalSpace,
                  priceWidget(),
                  5.verticalSpace,
                  outputWidget(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      voltWidget(),
                      ValueListenableBuilder(
                          valueListenable: AppConstants.cart,
                          builder: (context, value, child) {
                            return Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                subtractWidget(value),
                                5.horizontalSpace,
                                additionWidget(value)
                              ],
                            );
                          }),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget imageWidget() {
    switch (products[widget.index].type) {
      case imageType.asset:
        return Container(
            height: 100.h,
            width: .43.sw,
            padding: EdgeInsets.all(6.r),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.sp),
                image: DecorationImage(
                    image: AssetImage(products[widget.index].image ?? ""),
                    fit: BoxFit.cover)));

      case imageType.network:
        return CachedNetworkImage(
            imageUrl: products[widget.index].image ?? "",
            imageBuilder: (context, imageProvider) => Container(
                height: 100.h,
                width: .43.sw,
                padding: EdgeInsets.all(6.r),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.sp),
                    image: DecorationImage(
                        image: imageProvider, fit: BoxFit.cover))),
            progressIndicatorBuilder: (context, url, progress) => Container(
                  height: 100.h,
                  width: .43.sw,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.sp),
                      color: AppColors.SCAFFOLD_COLOR),
                  child: Center(
                    child: CircularProgressIndicator(
                        value: progress.progress,
                        color: AppColors.WHITE_COLOR,
                        strokeWidth: 2),
                  ),
                ),
            errorWidget: (context, url, error) => Container(
                  height: 100.h,
                  width: .43.sw,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.sp),
                      color: AppColors.SCAFFOLD_COLOR),
                  child: const Icon(Icons.error_outline,
                      color: AppColors.PRIMARY_COLOR),
                ));

      default:
        return SizedBox(height: 100.h, width: .43.sw);
    }
  }

  Widget additionWidget(List<CartModel> value) {
    return GestureDetector(
        onTap: () => additionFunction(),
        child: isEmpty(value)
            ? Container(
                padding: EdgeInsets.all(6.r),
                decoration: const BoxDecoration(
                    color: AppColors.PRIMARY_COLOR, shape: BoxShape.circle),
                child: Text(quantity(value),
                    style: AppTextStyle.customtextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 12.sp,
                        color: AppColors.WHITE_COLOR)))
            : Container(
                padding: EdgeInsets.all(3.5.r),
                decoration: const BoxDecoration(
                    color: AppColors.PRIMARY_COLOR, shape: BoxShape.circle),
                child: Icon(Icons.add,
                    color: AppColors.WHITE_COLOR, size: 12.sp)));
  }

  Widget subtractWidget(List<CartModel> value) {
    return GestureDetector(
        onTap: () => subtractionFunction(),
        child: isEmpty(value)
            ? Container(
                height: 18.5.sp,
                width: 18.5.sp,
                alignment: Alignment.center,
                padding: EdgeInsets.all(6.5.r),
                decoration: const BoxDecoration(
                    color: AppColors.PRIMARY_COLOR, shape: BoxShape.circle),
                child: Divider(color: AppColors.WHITE_COLOR, thickness: 1.5.sp))
            : const SizedBox());
  }

  Widget voltWidget() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.power, color: AppColors.PRIMARY_COLOR, size: 12.w),
        2.horizontalSpace,
        Text("${products[widget.index].volt?.toStringAsFixed(0)} volts",
            style: AppTextStyle.customtextStyle(
                fontSize: 12.sp,
                color: AppColors.PRIMARY_COLOR,
                fontWeight: FontWeight.w500)),
      ],
    );
  }

  Widget outputWidget() {
    return Row(
      children: [
        Image.asset(AppAssets.flash_icon,
            color: AppColors.PRIMARY_COLOR, width: 10.w, fit: BoxFit.fitWidth),
        5.horizontalSpace,
        Text(
            "${((products[widget.index].outputUpperLimit ?? 0) / 1000).toStringAsFixed(0)}k - ${((products[widget.index].outputLowerLimit ?? 0) / 1000).toStringAsFixed(0)}k Watt",
            style: AppTextStyle.customtextStyle(
                fontSize: 12.sp,
                color: AppColors.PRIMARY_COLOR,
                fontWeight: FontWeight.w500)),
      ],
    );
  }

  Widget priceWidget() {
    return Text(
        "Rs.${((products[widget.index].price ?? 0) / 1000).toStringAsFixed(0)}K",
        style: AppTextStyle.customtextStyle(
            fontSize: 14.sp, fontWeight: FontWeight.w500));
  }

  Widget nameWidget() {
    return Text(products[widget.index].name ?? "",
        maxLines: 2,
        style: AppTextStyle.customtextStyle(
            overflow: TextOverflow.visible,
            fontSize: 12.sp,
            fontWeight: FontWeight.w400));
  }

  int indexWhere(List<CartModel> value) => value.indexWhere(
      (element) => element.product?.id == products[widget.index].id);

  String quantity(List<CartModel> value) =>
      value
          .where((element) => element.product?.id == products[widget.index].id)
          .toList()
          .firstOrNull
          ?.quantity
          .toString() ??
      "0";

  bool isEmpty(List<CartModel> value) => value
      .where((element) => element.product?.id == products[widget.index].id)
      .toList()
      .isNotEmpty;
}
