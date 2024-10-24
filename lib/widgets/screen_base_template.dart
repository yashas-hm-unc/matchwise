import 'package:flutter/material.dart';
import 'package:matchwise/core/constants/app_colors.dart';
import 'package:matchwise/core/utilities/extensions.dart';
import 'package:matchwise/widgets/nav_column.dart';
import 'package:resize/resize.dart';

class ScreenBaseTemplate extends StatelessWidget {
  const ScreenBaseTemplate({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: context.height,
            width: context.width,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const NavigationColumn(),
                child,
              ],
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Container(
              height: context.width / 30,
              width: context.width / 30,
              margin: EdgeInsets.all(15.sp),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: carolinaBlue,
              ),
            ),
          )
        ],
      ),
    );
  }
}
