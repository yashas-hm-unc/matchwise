import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:matchwise/core/constants/app_colors.dart';
import 'package:matchwise/core/models/important_date.dart';
import 'package:matchwise/core/utilities/extensions.dart';
import 'package:matchwise/providers/date_provider.dart';
import 'package:resize/resize.dart';

class ImportantDatesPage extends StatelessWidget {
  const ImportantDatesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(30.sp),
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
                  final dates = ref.watch(dateProvider);

                  return ListView.builder(
                    itemCount: dates.length,
                    itemBuilder: (ctx, index) => DateItem(
                      date: dates[index],
                      ref: ref,
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DateItem extends StatelessWidget {
  const DateItem(
      {super.key, required this.date, required this.ref, this.admin = false});

  final ImportantDate date;

  final WidgetRef ref;

  final bool admin;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20.sp),
      padding: EdgeInsets.symmetric(
        vertical: 10.sp,
        horizontal: 15.sp,
      ),
      decoration: BoxDecoration(
        color: carolinaBlue.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15.sp),
        border: Border.all(
          color: Colors.black.withOpacity(0.5),
          width: 1.sp,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: context.width / 3.5,
            child: Text(
              date.title,
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Text(
            DateFormat('dd MMM yyyy hh:mm aa').format(date.date),
            textAlign: TextAlign.start,
            style: TextStyle(
              fontSize: 20.sp,
            ),
          ),
        ],
      ),
    );
  }
}
