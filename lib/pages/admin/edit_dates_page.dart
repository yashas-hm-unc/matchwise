import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:matchwise/core/constants/app_colors.dart';
import 'package:matchwise/core/utilities/extensions.dart';
import 'package:matchwise/providers/faculty_provider.dart';
import 'package:resize/resize.dart';

class EditTimelinePage extends StatelessWidget {
  const EditTimelinePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      margin: EdgeInsets.all(15.sp),
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.all(15.sp),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Modify Important Dates',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 28.sp,
                  ),
                ),
                Gap(30.sp),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(30.sp),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.sp),
                      border: Border.all(
                        color: black.withOpacity(0.5),
                        width: 1.sp,
                      ),
                    ),
                    child: Consumer(
                      builder: (ctx, ref, _) {
                        final faculty = ref.watch(facultyProvider);

                        return ListView.builder(
                          itemCount: faculty.length,
                          itemBuilder: (ctx, index) => Container(),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Material(
              borderRadius: BorderRadius.circular(25.sp),
              color: carolinaBlue,
              child: InkWell(
                // onTap: () => addFacultyDialog(context),
                borderRadius: BorderRadius.circular(25.sp),
                child: Container(
                  height: 50.sp,
                  width: context.width / 8,
                  padding: EdgeInsets.symmetric(
                    horizontal: 8.sp,
                    vertical: 4.sp,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add,
                        size: 20.sp,
                        color: white,
                      ),
                      Gap(10.sp),
                      FittedBox(
                        child: Text(
                          'Add Date',
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                            color: white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
