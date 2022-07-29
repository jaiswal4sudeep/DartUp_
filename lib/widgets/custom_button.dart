import 'package:flutter/material.dart';
import 'package:task/utils/app_constant.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,

    required this.onPressed,
    required this.title,
  }) : super(key: key);


  final void Function() onPressed;
  final String title;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppConstant.primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
      child: Text(
        title,
        style: Theme.of(context).textTheme.headline3!.copyWith(
              color: AppConstant.backgroundColor,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.2,
            ),
      ),
    );
  }
}
