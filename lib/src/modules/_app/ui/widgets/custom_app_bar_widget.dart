import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAppBarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  final String? title;
  final Widget? titleWidget;
  final List<Widget>? actions;
  final Widget? leading;
  final PreferredSize? bottom;
  final Color? backgroundColor;
  final Color? leadingIconColor;
  final double? titleFontSize;
  final double? leadingWidth;
  final double? elevation;
  final bool centerTitle;

  const CustomAppBarWidget({
    Key? key,
    this.title,
    this.titleWidget,
    this.actions,
    this.leading,
    this.bottom,
    this.backgroundColor,
    this.leadingIconColor,
    this.titleFontSize,
    this.leadingWidth,
    this.elevation,
    this.centerTitle = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor ?? Colors.white,
      iconTheme: IconThemeData(color: leadingIconColor ?? Colors.black),
      elevation: elevation ?? 1,
      centerTitle: centerTitle,
      title: titleWidget == null && title == null
          ? null
          : titleWidget ??
              Text(
                title!,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: titleFontSize?.sp ?? 18.sp,
                ),
              ),
      leadingWidth: leadingWidth,
      leading: leading ?? const BackButton(),
      actions: actions,
      bottom: bottom,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(
      kToolbarHeight + 10.h + (bottom?.preferredSize.height ?? 0));
}
