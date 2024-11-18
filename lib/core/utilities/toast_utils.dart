import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:matchwise/core/utilities/extensions.dart';
import 'package:oktoast/oktoast.dart';
import 'package:resize/resize.dart';

void successToast(
  String msg,
  BuildContext context,
) =>
    showToastWidget(
      Container(
        width: context.width / 2,
        height: 60.sp,
        padding: EdgeInsets.symmetric(horizontal: 15.sp),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.sp),
          border: Border.all(
            color: Colors.green,
            width: 1.sp,
          ),
          color: Colors.white,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.check_rounded,
              color: Colors.green,
              size: 30.sp,
            ),
            Gap(15.sp),
            Text(
              msg,
              style: TextStyle(
                fontSize: 20.sp,
              ),
            ),
          ],
        ),
      ),
      position: ToastPosition.top,
      duration: 1.5.seconds,
    );

void errorToast(
  String msg,
  BuildContext context,
) =>
    showToastWidget(
      Container(
        width: context.width / 2,
        height: 60.sp,
        padding: EdgeInsets.symmetric(horizontal: 15.sp),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.sp),
          border: Border.all(
            color: Colors.redAccent,
            width: 1.sp,
          ),
          color: Colors.white,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.clear_rounded,
              color: Colors.redAccent,
              size: 30.sp,
            ),
            Gap(15.sp),
            Text(
              msg,
              style: TextStyle(
                fontSize: 20.sp,
              ),
            ),
          ],
        ),
      ),
      position: ToastPosition.top,
      duration: 1.5.seconds,
    );
