import 'package:flutter/material.dart';
import 'package:kps/services/models/cartModel.dart';
import 'package:kps/utils/app_appbar.dart';
import 'package:kps/utils/app_colors.dart';
import 'package:kps/widgets/cart_card.dart';
import 'package:kps/utils/app_constants.dart';
import 'package:kps/utils/app_navigation.dart';
import 'package:kps/utils/app_text_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kps/widgets/custom_button.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  void backFunction() {
    AppNavigation.navigatorPop();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: AppConstants.cart,
        builder: (context, value, child) {
          return Scaffold(
            backgroundColor: AppColors.SCAFFOLD_COLOR,
            appBar: AppBar(
              backgroundColor: AppColors.WHITE_COLOR,
              shadowColor: AppColors.TRANSPARENT_COLOR,
              leadingWidth: 66,
              toolbarHeight: 40,
              centerTitle: true,
              leading: AppAppBars.backButton(backFunction: backFunction),
              title: Text(
                "Cart",
                style: AppTextStyle.customtextStyle(
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.BLACK_COLOR,
                ),
              ),
            ),
            bottomNavigationBar: value.isEmpty
                ? null
                : Container(
                    width: 1.sw,
                    height: .165.sh,
                    padding: EdgeInsets.all(15.r),
                    decoration: BoxDecoration(
                        color: AppColors.WHITE_COLOR,
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(10.sp)),
                        boxShadow: [
                          BoxShadow(
                              color: AppColors.BLACK_COLOR.withOpacity(.1),
                              offset: const Offset(0, 0),
                              blurRadius: 4.sp)
                        ]),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text("Total:",
                                    style: TextStyle(
                                        fontSize: 16.sp,
                                        color: AppColors.BLACK_COLOR)),
                                Text("(Tax added)",
                                    style: TextStyle(
                                        fontSize: 8.sp,
                                        color: AppColors.BLACK_COLOR)),
                              ],
                            ),
                            Text(
                                "Rs:${total(value) > 900000 ? "${(total(value) / 100000).toStringAsFixed(0)}M" : "${(total(value) / 1000).toStringAsFixed(0)}K"}",
                                style: TextStyle(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.BLACK_COLOR)),
                          ],
                        ),
                        10.verticalSpace,
                        CustomButton(
                          onTap: () {},
                          text: "Review Information",
                        )
                      ],
                    ),
                  ),
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: Column(
                  children: [
                    10.verticalSpace,
                    if (value.isEmpty)
                      Center(
                        child: Column(
                          children: [
                            150.verticalSpace,
                            Icon(Icons.shopping_bag_outlined,
                                color: Colors.grey.shade100, size: 100.sp),
                            5.verticalSpace,
                            Text("Cart is Empty",
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    letterSpacing: 0.5,
                                    color: Colors.grey.shade300)),
                          ],
                        ),
                      )
                    else
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                              padding: EdgeInsets.symmetric(horizontal: 12.w),
                              child: progressWidget()),
                          2.verticalSpace,
                          progressLabel(),
                          20.verticalSpace,
                          for (int i = 0; i < value.length; i++)
                            CartCard(
                              index: i,
                              onChange: () => setState(() {}),
                            )
                        ],
                      )
                  ],
                ),
              ),
            ),
          );
        });
  }

  Widget progressLabel() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Add Items",
            textAlign: TextAlign.center,
            style: AppTextStyle.customtextStyle(
                color: AppColors.PRIMARY_COLOR,
                fontSize: 10.sp,
                fontWeight: FontWeight.w500)),
        Text("Finalize",
            textAlign: TextAlign.center,
            style: AppTextStyle.customtextStyle(
                color: AppColors.PRIMARY_COLOR,
                fontSize: 10.sp,
                fontWeight: FontWeight.w500)),
        Text("Check Out",
            textAlign: TextAlign.center,
            style: AppTextStyle.customtextStyle(
                color: Colors.grey.shade300,
                fontSize: 10.sp,
                fontWeight: FontWeight.w500)),
      ],
    );
  }

  Widget progressWidget() {
    return Row(
      children: [
        Container(
            padding: EdgeInsets.all(8.r),
            decoration: const BoxDecoration(
                color: AppColors.PRIMARY_COLOR, shape: BoxShape.circle),
            child: Text("1",
                style: AppTextStyle.customtextStyle(
                    color: AppColors.WHITE_COLOR,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w500))),
        Expanded(
            child: Divider(color: AppColors.PRIMARY_COLOR, thickness: 3.sp)),
        Container(
            padding: EdgeInsets.all(8.r),
            decoration: const BoxDecoration(
                color: AppColors.PRIMARY_COLOR, shape: BoxShape.circle),
            child: Text("2",
                style: AppTextStyle.customtextStyle(
                    color: AppColors.WHITE_COLOR,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w500))),
        Expanded(child: Divider(color: Colors.grey.shade300, thickness: 3.sp)),
        Container(
            padding: EdgeInsets.all(8.r),
            decoration: BoxDecoration(
                color: Colors.grey.shade300, shape: BoxShape.circle),
            child: Text("3",
                style: AppTextStyle.customtextStyle(
                    color: AppColors.WHITE_COLOR,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w500))),
      ],
    );
  }

  double total(List<CartModel> value) {
    double total = 0;
    for (var e in value) {
      total += ((e.product?.price ?? 0) * (e.quantity ?? 0));
    }
    return total;
  }
}
