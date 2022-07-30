import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OptionWidget extends StatelessWidget {
  const OptionWidget({
    Key? key,
    required this.text,
    required this.isTrue,
    required this.isSelectedByUser,
  }) : super(key: key);

  final String text;
  final bool isTrue;
  final bool isSelectedByUser;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8.0,
        vertical: 4.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              text,
              style: Theme.of(context).textTheme.headline5!.copyWith(
                    fontSize: isTrue ? 13.sp : 12.sp,
                    fontWeight: isTrue ? FontWeight.w700 : FontWeight.w500,
                  ),
            ),
          ),
          Icon(
            isSelectedByUser
                ? (isTrue ? Icons.check_rounded : Icons.clear_rounded)
                : (isTrue ? Icons.check_rounded : null),
          ),
        ],
      ),
    );
  }
}
