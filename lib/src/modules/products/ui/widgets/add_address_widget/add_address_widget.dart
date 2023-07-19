import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sezon/src/modules/_app/ui/widgets/custom_button_widget.dart';
import 'package:sezon/src/modules/_app/ui/widgets/custom_text_field_widget.dart';
import 'package:sezon/src/modules/products/ui/widgets/add_address_widget/add_address_widget_controller.dart';

class AddAddressWidget extends StatefulWidget {
  const AddAddressWidget({super.key});

  @override
  State<AddAddressWidget> createState() => _AddAddressWidgetState();
}

class _AddAddressWidgetState extends State<AddAddressWidget> {
  // controller.
  late final AddAddressWidgetController _addAddressWidgetController =
      Get.find<AddAddressWidgetController>();

  // dispose.
  @override
  void dispose() {
    // dispose and delete controller to not get a memory leak party :).
    _addAddressWidgetController.dispose();
    Get.delete<AddAddressWidgetController>();
    super.dispose();
  }

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
        key: _addAddressWidgetController.formKey,
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
                  'إضافة عنوان جديد',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            15.verticalSpace,
            CustomTextFieldWidget(
              initialValue: _addAddressWidgetController.orderAddress?.country,
              title: 'الدولة',
              hintText: 'ادخل الدولة',
              keyboardType: TextInputType.name,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'الدولة مطلوبة';
                }
                return null;
              },
              onSaved: (value) => _addAddressWidgetController.country = value,
            ),
            5.verticalSpace,
            CustomTextFieldWidget(
              initialValue: _addAddressWidgetController.orderAddress?.city,
              title: 'المدينة',
              hintText: 'ادخل المدينة',
              keyboardType: TextInputType.name,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'المدينة مطلوبة';
                }
                return null;
              },
              onSaved: (value) => _addAddressWidgetController.city = value,
            ),
            5.verticalSpace,
            CustomTextFieldWidget(
              initialValue: _addAddressWidgetController.orderAddress?.region,
              title: 'المنطقة',
              hintText: 'ادخل المنطقة',
              keyboardType: TextInputType.name,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'المنطقة مطلوبة';
                }
                return null;
              },
              onSaved: (value) => _addAddressWidgetController.region = value,
            ),
            5.verticalSpace,
            CustomTextFieldWidget(
              initialValue: _addAddressWidgetController.orderAddress?.street,
              title: 'الشارع',
              hintText: 'ادخل الشارع',
              keyboardType: TextInputType.name,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'الشارع مطلوب';
                }
                return null;
              },
              onSaved: (value) => _addAddressWidgetController.street = value,
            ),
            5.verticalSpace,
            CustomTextFieldWidget(
              initialValue: _addAddressWidgetController.orderAddress?.zipCode,
              title: 'الرمز البريدي',
              hintText: 'ادخل الرمز البريدي',
              keyboardType: TextInputType.name,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'الرمز البريدي مطلوب';
                }
                return null;
              },
              onSaved: (value) => _addAddressWidgetController.zipCode = value,
            ),
            15.verticalSpace,
            CustomButtonWidget(
              title: 'حفظ',
              onTap: _addAddressWidgetController
                  .navigateOrderAddressBackToCheckoutPage,
            ),
          ],
        ),
      ),
    );
  }
}
