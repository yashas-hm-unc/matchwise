import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:matchwise/core/constants/app_colors.dart';
import 'package:matchwise/core/models/student_user.dart';
import 'package:resize/resize.dart';

class StudentItem extends StatelessWidget {
  const StudentItem({
    super.key,
    required this.user,
    required this.facultyOnyen,
  });

  final StudentUser user;
  final String facultyOnyen;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        bottom: 15.sp,
      ),
      decoration: BoxDecoration(
        color: carolinaBlue.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15.sp),
        border: Border.all(
          color: carolinaBlue,
        ),
      ),
      padding: EdgeInsets.all(15.sp),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${user.firstName} ${user.lastName}',
                  style: TextStyle(
                    fontSize: 20.sp,
                  ),
                ),
                Gap(10.sp),
                getChips(),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.sp),
              color: carolinaBlue,
            ),
            padding: EdgeInsets.symmetric(
              horizontal: 5.sp,
              vertical: 2.sp,
            ),
            child: Text(
              '#${priority()}',
              style: const TextStyle(
                color: white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  int priority() {
    int priority = 0;

    for (int i = 0; i < user.prefProfessors.length; i++) {
      if (user.prefProfessors[i] == facultyOnyen) {
        priority = i + 1;
      }
    }

    return priority;
  }

  Widget getChips() {
    final chips = <Chip>[];

    for (int i = 0; i < user.researchInterests.length; i++) {
      chips.add(
        Chip(
          backgroundColor: white,
          label: Text(
            user.researchInterests[i],
          ),
          padding: EdgeInsets.symmetric(
            vertical: 3.sp,
            horizontal: 8.sp,
          ),
        ),
      );
    }

    return Wrap(
      runSpacing: 8.sp,
      spacing: 8.sp,
      children: chips,
    );
  }
}

void getStudentDetails(
  BuildContext context,
  StudentUser student,
) {}
