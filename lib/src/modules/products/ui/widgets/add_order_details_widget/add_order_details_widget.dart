import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sezon/src/modules/_app/ui/widgets/custom_button_widget.dart';
import 'package:sezon/src/modules/_app/ui/widgets/custom_text_field_widget.dart';
import 'package:sezon/src/modules/products/ui/widgets/add_order_details_widget/add_order_details_widget_controller.dart';

class AddOrderDetailsWidget extends StatefulWidget {
  const AddOrderDetailsWidget({super.key});

  @override
  State<AddOrderDetailsWidget> createState() => _AddOrderDetailsWidgetState();
}

class _AddOrderDetailsWidgetState extends State<AddOrderDetailsWidget> {
  // controller.
  late final AddOrderDetailsWidgetController _addOrderDetailsWidgetController =
      Get.find<AddOrderDetailsWidgetController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(12.r),
        ),
      ),
      child: Form(
        key: _addOrderDetailsWidgetController.formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 20.h,
                  width: 4.w,
                  decoration: BoxDecoration(
                    color: Get.theme.primaryColor,
                    borderRadius: BorderRadius.circular(5.r),
                  ),
                ),
                15.horizontalSpace,
                Text(
                  'Add Product Specifications'.tr,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            15.verticalSpace,
            CustomTextFieldWidget(
              initialValue:
                  _addOrderDetailsWidgetController.orderDetails?.quantity,
              title: 'Quantity'.tr,
              hintText: 'ex: 5 pieces'.tr,
              keyboardType: TextInputType.name,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Quantity is required'.tr;
                }
                return null;
              },
              onSaved: (value) =>
                  _addOrderDetailsWidgetController.quantity = value,
            ),
            5.verticalSpace,
            CustomTextFieldWidget(
              initialValue:
                  _addOrderDetailsWidgetController.orderDetails?.color,
              title: 'Product Color'.tr,
              hintText: 'ex: black'.tr,
              keyboardType: TextInputType.name,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Color is required'.tr;
                }
                return null;
              },
              onSaved: (value) =>
                  _addOrderDetailsWidgetController.color = value,
            ),
            5.verticalSpace,
            CustomTextFieldWidget(
              initialValue: _addOrderDetailsWidgetController.orderDetails?.size,
              title: 'Size'.tr,
              hintText: 'ex: xxl'.tr,
              keyboardType: TextInputType.name,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Size is required'.tr;
                }
                return null;
              },
              onSaved: (value) => _addOrderDetailsWidgetController.size = value,
            ),
            15.verticalSpace,
            CustomButtonWidget(
              title: 'Save'.tr,
              onTap: _addOrderDetailsWidgetController
                  .navigateOrderDetailsBackToCheckoutPage,
            ),
          ],
        ),
      ),
    );
  }
}
