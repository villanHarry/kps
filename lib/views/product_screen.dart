import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kps/services/models/cartModel.dart';
import 'package:kps/utils/app_appbar.dart';
import 'package:kps/utils/app_assets.dart';
import 'package:kps/utils/app_colors.dart';
import 'package:kps/utils/app_constants.dart';
import 'package:kps/utils/app_enums.dart';
import 'package:kps/utils/app_navigation.dart';
import 'package:kps/utils/app_text_style.dart';
import 'package:kps/views/main_screen/data/products.dart';
import 'package:kps/widgets/custom_button.dart';

class ProductScreenArguments {
  const ProductScreenArguments({required this.index});
  final int index;
}

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key, required this.index});
  final int index;

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  void backFunction() {
    AppNavigation.navigatorPop();
  }

  void additionFunction(List<CartModel> value) {
    int index = indexWhere(value);
    if (index != -1) {
      value[index].quantity = (value[index].quantity ?? 0) + 1;
    } else {
      value.add(CartModel(product: products[widget.index], quantity: 1));
    }
    setState(() {});
  }

  void subtractionFunction(List<CartModel> value) {
    int index = indexWhere(value);
    if (index != -1) {
      int quantity = (value[index].quantity ?? 1);
      if (quantity == 1) {
        value.removeAt(index);
      } else {
        value[index].quantity = (quantity - 1);
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.SCAFFOLD_COLOR,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: .4.sh,
            backgroundColor: AppColors.WHITE_COLOR,
            surfaceTintColor: AppColors.WHITE_COLOR,
            systemOverlayStyle: AppConstants.lightThemeStatusBar,
            leading: AppAppBars.backButton(backFunction: backFunction),
            flexibleSpace: FlexibleSpaceBar(
              background: imageWidget(),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate.fixed([
              Column(
                children: [
                  15.verticalSpace,
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        nameWidget(),
                        10.verticalSpace,
                        priceWidget(),
                        10.verticalSpace,
                        outputWidget(),
                        10.verticalSpace,
                        voltWidget(),
                        15.verticalSpace,
                        ValueListenableBuilder(
                            valueListenable: AppConstants.cart,
                            builder: (context, value, child) {
                              if (isEmpty(value)) {
                                return Center(
                                  child: Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 15.w),
                                    decoration: BoxDecoration(
                                        color: AppColors.PRIMARY_COLOR
                                            .withOpacity(.3),
                                        borderRadius:
                                            BorderRadius.circular(27.r)),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        GestureDetector(
                                          onTap: () =>
                                              subtractionFunction(value),
                                          child: SizedBox(
                                            width: 14.sp,
                                            height: 16.sp,
                                            child: Divider(
                                              thickness: 2.sp,
                                              color: AppColors.PRIMARY_COLOR,
                                            ),
                                          ),
                                        ),
                                        30.horizontalSpace,
                                        Container(
                                          padding: EdgeInsets.all(10.r),
                                          decoration: const BoxDecoration(
                                            color: AppColors.PRIMARY_COLOR,
                                            shape: BoxShape.circle,
                                          ),
                                          child: Text(
                                            quantity(value),
                                            style: AppTextStyle.customtextStyle(
                                                color: AppColors.WHITE_COLOR,
                                                fontSize: 18.sp,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        30.horizontalSpace,
                                        GestureDetector(
                                          onTap: () => additionFunction(value),
                                          child: Icon(Icons.add,
                                              color: AppColors.PRIMARY_COLOR,
                                              size: 25.sp),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              } else {
                                return CustomButton(
                                  onTap: () {},
                                  text: "Add To Cart",
                                );
                              }
                            }),
                        15.verticalSpace,
                        descriptionHeadingWidget(),
                        10.verticalSpace,
                        descriptionWidget()
                      ],
                    ),
                  )
                ],
              ),
            ]),
          ),
        ],
      ),
    );
  }

  Text descriptionWidget() {
    return Text(
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.\n\nIt is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like)",
        style: AppTextStyle.customtextStyle(
            overflow: TextOverflow.visible,
            fontSize: 15.5.sp,
            height: 1.2.sp,
            color: Colors.grey.shade600,
            fontWeight: FontWeight.w400));
  }

  Text descriptionHeadingWidget() {
    return Text("Description",
        style: AppTextStyle.customtextStyle(
            fontSize: 20.sp, fontWeight: FontWeight.w500));
  }

  Widget voltWidget() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.power, color: AppColors.PRIMARY_COLOR, size: 18.w),
        2.horizontalSpace,
        Text("${products[widget.index].volt?.toStringAsFixed(0)} volts",
            style: AppTextStyle.customtextStyle(
                fontSize: 18.sp,
                color: AppColors.PRIMARY_COLOR,
                fontWeight: FontWeight.w500)),
      ],
    );
  }

  Widget outputWidget() {
    return Row(
      children: [
        Image.asset(AppAssets.flash_icon,
            color: AppColors.PRIMARY_COLOR, width: 16.w, fit: BoxFit.fitWidth),
        5.horizontalSpace,
        Text(
            "${((products[widget.index].outputUpperLimit ?? 0) / 1000).toStringAsFixed(0)}k - ${((products[widget.index].outputLowerLimit ?? 0) / 1000).toStringAsFixed(0)}k Watt",
            style: AppTextStyle.customtextStyle(
                fontSize: 18.sp,
                color: AppColors.PRIMARY_COLOR,
                fontWeight: FontWeight.w500)),
      ],
    );
  }

  Widget priceWidget() {
    return Text(
        "Rs.${((products[widget.index].price ?? 0) / 1000).toStringAsFixed(0)}K",
        style: AppTextStyle.customtextStyle(
            fontSize: 20.sp, fontWeight: FontWeight.w500));
  }

  Widget nameWidget() {
    return Text(products[widget.index].name ?? "",
        maxLines: 2,
        style: AppTextStyle.customtextStyle(
            overflow: TextOverflow.visible,
            fontSize: 18.sp,
            fontWeight: FontWeight.w400));
  }

  Widget imageWidget() {
    switch (products[widget.index].type) {
      case imageType.asset:
        return Container(
            height: .4.sh,
            width: 1.sw,
            padding: EdgeInsets.all(6.r),
            decoration: BoxDecoration(
                border: Border.all(width: 1.5.sp, color: Colors.grey.shade500),
                borderRadius: BorderRadius.circular(27.sp),
                image: DecorationImage(
                    image: AssetImage(products[widget.index].image ?? ""),
                    fit: BoxFit.cover)));

      case imageType.network:
        return CachedNetworkImage(
            imageUrl: products[widget.index].image ?? "",
            imageBuilder: (context, imageProvider) => Container(
                height: .4.sh,
                width: 1.sw,
                padding: EdgeInsets.all(6.r),
                decoration: BoxDecoration(
                    border:
                        Border.all(width: 1.5.sp, color: Colors.grey.shade500),
                    borderRadius: BorderRadius.circular(10.sp),
                    image: DecorationImage(
                        image: imageProvider, fit: BoxFit.cover))),
            progressIndicatorBuilder: (context, url, progress) => Container(
                  height: .4.sh,
                  width: 1.sw,
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
                  height: .4.sh,
                  width: 1.sw,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.sp),
                      color: AppColors.SCAFFOLD_COLOR),
                  child: const Icon(Icons.error_outline,
                      color: AppColors.PRIMARY_COLOR),
                ));

      default:
        return SizedBox(height: .4.sh, width: 1.sw);
    }
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
      "1";

  bool isEmpty(List<CartModel> value) => value
      .where((element) => element.product?.id == products[widget.index].id)
      .toList()
      .isNotEmpty;
}
