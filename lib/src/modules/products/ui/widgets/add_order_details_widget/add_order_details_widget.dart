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
      margin: EdgeInsets.only(
        bottom: Get.mediaQuery.viewInsets.bottom,
      ),
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
                  'إضافة مواصفات المنتج',
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
              title: 'الكمية',
              hintText: 'مثال: 5 قطع',
              keyboardType: TextInputType.name,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'الكمية مطلوبة';
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
              title: 'لون المنتج',
              hintText: 'مثال: الأسود',
              keyboardType: TextInputType.name,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'اللون مطلوب';
                }
                return null;
              },
              onSaved: (value) =>
                  _addOrderDetailsWidgetController.color = value,
            ),
            5.verticalSpace,
            CustomTextFieldWidget(
              initialValue: _addOrderDetailsWidgetController.orderDetails?.size,
              title: 'الحجم',
              hintText: 'مثال: xxl',
              keyboardType: TextInputType.name,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'الحجم مطلوب';
                }
                return null;
              },
              onSaved: (value) => _addOrderDetailsWidgetController.size = value,
            ),
            15.verticalSpace,
            CustomButtonWidget(
              title: 'حفظ',
              onTap: _addOrderDetailsWidgetController
                  .navigateOrderDetailsBackToCheckoutPage,
            ),
          ],
        ),
      ),
    );
  }
}
