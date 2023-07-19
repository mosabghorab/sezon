import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sezon/src/config/constants.dart';

class CustomTextFieldWidget extends StatefulWidget {
  final String? title;
  final String hintText;
  final TextInputType? keyboardType;
  final int? maxLines;
  final int? maxLength;
  final bool isPassword;
  final bool isMobile;
  final bool isCapitalized;
  final bool isRequired;
  final String? countryPickerInitialSelection;
  final void Function(String? value)? onSaved;
  final void Function(String? value)? onChanged;
  final void Function(String? value)? onFieldSubmitted;
  final String? Function(String? value)? validator;
  final FocusNode? focusNode;
  final String? initialValue;
  final String? prefixIconName;
  final Widget? suffix;
  final Widget? prefix;
  final void Function()? onTap;
  final TextEditingController? controller;
  final List<TextInputFormatter>? inputFormatters;

  const CustomTextFieldWidget({
    Key? key,
    required this.hintText,
    this.title,
    this.maxLines,
    this.maxLength,
    this.keyboardType,
    this.isPassword = false,
    this.isMobile = false,
    this.isCapitalized = false,
    this.isRequired = true,
    this.countryPickerInitialSelection,
    this.onSaved,
    this.onChanged,
    this.onFieldSubmitted,
    this.validator,
    this.focusNode,
    this.initialValue,
    this.prefixIconName,
    this.suffix,
    this.prefix,
    this.onTap,
    this.controller,
    this.inputFormatters,
  }) : super(key: key);

  @override
  State<CustomTextFieldWidget> createState() => _CustomTextFieldWidgetState();
}

class _CustomTextFieldWidgetState extends State<CustomTextFieldWidget> {
  // vars.
  late bool _isPassword = widget.isPassword;
  late String _mobilePrefix = widget.countryPickerInitialSelection ?? '+970';
  late final OutlineInputBorder _outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(4.r),
    borderSide: BorderSide(
      color: Colors.grey.shade200,
      width: 1,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: widget.onTap != null,
      onTap: widget.onTap,
      initialValue: widget.initialValue,
      controller: widget.controller,
      maxLines: widget.maxLines ?? 1,
      obscureText: _isPassword,
      decoration: InputDecoration(
        labelText: widget.title,
        enabledBorder: _outlineInputBorder,
        focusedBorder: _outlineInputBorder,
        errorBorder: _outlineInputBorder,
        border: _outlineInputBorder,
        contentPadding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 20.w),
        hintText: widget.hintText,
        hintStyle: TextStyle(
          fontSize: 12.sp,
        ),
        prefixIcon: widget.prefix ??
            (widget.isMobile
                ? Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: 15.w,
                      ),
                      CountryCodePicker(
                        initialSelection: _mobilePrefix,
                        countryFilter: [_mobilePrefix],
                        padding: EdgeInsets.symmetric(
                            horizontal: 0.w, vertical: 4.h),
                        flagWidth: 25.w,
                        textStyle: TextStyle(
                          fontSize: 11.sp,
                          color: Colors.black,
                        ),
                        onChanged: (countryCode) {
                          _mobilePrefix = countryCode.dialCode ?? '';
                        },
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                    ],
                  )
                : widget.prefixIconName == null
                    ? null
                    : Padding(
                        padding: EdgeInsets.all(12.h),
                        child: SvgPicture.asset(
                          '${Constants.assetsVectorsPath}${widget.prefixIconName}.svg',
                          width: 15.h,
                          height: 15.h,
                        ),
                      )),
        suffixIcon: () {
          if (widget.isPassword) {
            return InkWell(
              onTap: () {
                setState(() {
                  _isPassword = !_isPassword;
                });
              },
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: Icon(
                  _isPassword ? Icons.visibility_off : Icons.visibility,
                  color: Colors.black,
                  key: UniqueKey(),
                ),
              ),
            );
          } else {
            return widget.suffix;
          }
        }(),
      ),
      textCapitalization: widget.isCapitalized
          ? TextCapitalization.characters
          : TextCapitalization.none,
      inputFormatters: widget.inputFormatters,
      maxLength: widget.maxLength,
      keyboardType: widget.keyboardType,
      focusNode: widget.focusNode,
      validator: widget.validator,
      onChanged: widget.onChanged,
      onSaved: widget.isMobile
          ? (value) {
              if (widget.onSaved == null || value == null) return;
              widget.onSaved!(_mobilePrefix + value);
            }
          : widget.onSaved,
      onFieldSubmitted: widget.onFieldSubmitted,
    );
  }
}
