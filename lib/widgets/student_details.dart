import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:matchwise/core/constants/app_colors.dart';
import 'package:matchwise/core/models/student_user.dart';
import 'package:matchwise/core/utilities/extensions.dart';
import 'package:resize/resize.dart';
import 'package:url_launcher/url_launcher_string.dart';

void showStudentDetails(
  BuildContext context,
  StudentUser student,
) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (_) => StudentDetails(
      student: student,
    ),
  );
}

class StudentDetails extends StatelessWidget {
  const StudentDetails({
    super.key,
    required this.student,
  });

  final StudentUser student;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          15.sp,
        ),
      ),
      clipBehavior: Clip.hardEdge,
      content: Container(
        padding: EdgeInsets.all(15.sp),
        width: context.width / 1.8,
        height: context.height / 1.2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              children: [
                Text(
                  '${student.firstName} ${student.lastName}',
                  style: TextStyle(
                    fontSize: 25.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Icon(
                          Icons.close_rounded,
                          color: black,
                          size: 30.sp,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            Gap(5.sp),
            SelectableText(
              student.email,
              style: TextStyle(
                fontSize: 16.sp,
              ),
            ),
            Gap(15.sp),
            Text(
              'Description',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            Gap(5.sp),
            Text(
              student.description,
              style: TextStyle(
                fontSize: 16.sp,
              ),
            ),
            Gap(15.sp),
            if (student.resumeLink != '' || student.videoLink != '')
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (student.resumeLink != '')
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: () async =>
                            await launchUrlString(student.resumeLink),
                        child: Text(
                          'Resume',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  if (student.resumeLink != '') Gap(15.sp),
                  if (student.videoLink != '')
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: () async =>
                            await launchUrlString(student.videoLink),
                        child: Text(
                          'Video',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            Gap(15.sp),
            Text(
              'Research Interests',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            Gap(5.sp),
            buildChips(student.researchInterests),
            Gap(15.sp),
            Text(
              'Professor Preference',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            Gap(5.sp),
            buildChips(student.prefProfessors),
            Gap(15.sp),
            Text(
              'Course Preference',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            Gap(5.sp),
            buildChips(student.courseTAPref),
          ],
        ),
      ),
    );
  }

  Widget buildChips(List<String> data) {
    final chips = <Chip>[];

    for (int i = 0; i < data.length; i++) {
      chips.add(
        Chip(
          backgroundColor: carolinaBlue,
          label: Text(
            data[i],
            style: TextStyle(
              fontSize: 16.sp,
              color: white,
            ),
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
