import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:matchwise/core/constants/app_colors.dart';
import 'package:matchwise/core/utilities/extensions.dart';
import 'package:resize/resize.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      margin: EdgeInsets.all(50.sp),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'DashBoard',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 28.sp,
            ),
          ),
          Gap(context.height / 7),
          optionButton(
            context,
            () {},
            'Download Sorted Excel',
          ),
          Gap(20.sp),
          optionButton(
            context,
            () {},
            'Download Matched Excel',
          ),
          Gap(20.sp),
          optionButton(
            context,
            () {},
            'Close Faculty Form',
          ),
          Gap(20.sp),
          optionButton(
            context,
            () {},
            'Close Student Form',
          ),
          Gap(20.sp),
          optionButton(
            context,
            () {},
            'Start Sorting',
          ),
          Gap(20.sp),
          optionButton(
            context,
            () {},
            'Start Matching',
          ),
        ],
      ),
    );
  }

  Widget optionButton(BuildContext ctx, VoidCallback onTap, String text) {
    return Material(
      borderRadius: BorderRadius.circular(15.sp),
      color: carolinaBlue.withOpacity(0.1),
      child: InkWell(
        onTap: onTap,
        splashColor: carolinaBlue,
        borderRadius: BorderRadius.circular(15.sp),
        child: Container(
          height: ctx.height / 18,
          width: ctx.width / 3,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.sp),
            border: Border.all(
              color: black.withOpacity(0.4),
              width: 1.sp,
            ),
            color: Colors.transparent,
          ),
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(
            vertical: 5.sp,
            horizontal: 10.sp,
          ),
          child: Text(
            text,
            style: TextStyle(
              fontSize: 20.sp,
            ),
          ),
        ),
      ),
    );
  }
}
