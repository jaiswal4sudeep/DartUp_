import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task/utils/app_constant.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.onPressed,
    required this.title,
    this.bgColor = AppConstant.primaryColor,
    this.textColor = AppConstant.backgroundColor,
  }) : super(key: key);

  final void Function()? onPressed;
  final String title;
  final Color? bgColor;
  final Color? textColor;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        elevation: bgColor != AppConstant.primaryColor ? 0 : 1,
        backgroundColor: bgColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
          side: bgColor != AppConstant.primaryColor
              ? BorderSide(
                  color: AppConstant.primaryColor,
                  width: 2.sp,
                )
              : BorderSide.none,
        ),
      ),
      child: Text(
        title,
        style: Theme.of(context).textTheme.headline3!.copyWith(
              color: textColor,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.2,
            ),
      ),
    );
  }
}
