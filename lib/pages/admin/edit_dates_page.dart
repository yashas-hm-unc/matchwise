import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:matchwise/core/constants/app_colors.dart';
import 'package:matchwise/core/models/api_response.dart';
import 'package:matchwise/core/models/important_date.dart';
import 'package:matchwise/core/utilities/extensions.dart';
import 'package:matchwise/core/utilities/toast_utils.dart';
import 'package:matchwise/providers/date_provider.dart';
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
                        final dates = ref.watch(dateProvider);

                        return ListView.builder(
                          itemCount: dates.length,
                          itemBuilder: (ctx, index) => DateItem(
                            date: dates[index],
                            ref: ref,
                            admin: true,
                          ),
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
            child: Consumer(builder: (_, ref, __) {
              return Material(
                borderRadius: BorderRadius.circular(25.sp),
                color: carolinaBlue,
                child: InkWell(
                  onTap: () => dateDialog(context, ref),
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
              );
            }),
          ),
        ],
      ),
    );
  }
}

class DateItem extends StatelessWidget {
  const DateItem(
      {super.key, required this.date, required this.ref, bool admin = false});

  final ImportantDate date;

  final WidgetRef ref;

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
        mainAxisAlignment: MainAxisAlignment.start,
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
          Expanded(
            child: Text(
              DateFormat('dd MMM yyyy hh:mm aa').format(date.date),
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 20.sp,
              ),
            ),
          ),
          InkWell(
            onTap: () => dateDialog(
              context,
              ref,
              date: date,
            ),
            customBorder: const CircleBorder(),
            splashColor: carolinaBlue,
            child: Padding(
              padding: EdgeInsets.all(5.sp),
              child: Icon(
                Icons.edit,
                size: 30.sp,
                color: carolinaBlue,
              ),
            ),
          ),
          if (!date.requiredDate) Gap(15.sp),
          if (!date.requiredDate)
            InkWell(
              onTap: () => deleteDialog(context),
              customBorder: const CircleBorder(),
              splashColor: carolinaBlue,
              child: Padding(
                padding: EdgeInsets.all(5.sp),
                child: Icon(
                  Icons.delete_outline,
                  size: 30.sp,
                  color: Colors.redAccent,
                ),
              ),
            ),
        ],
      ),
    );
  }

  void deleteDialog(BuildContext context) {
    bool loading = false;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.sp),
        ),
        contentPadding: EdgeInsets.zero,
        content: StatefulBuilder(
          builder: (_, setState) => Container(
            constraints: BoxConstraints(
              maxWidth: context.width / 5,
              maxHeight: context.height / 4.5,
            ),
            padding: EdgeInsets.all(15.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.warning_amber_rounded,
                      size: 30.sp,
                      color: Colors.redAccent,
                    ),
                    Gap(15.sp),
                    Text(
                      'Confirm Deletion',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.sp,
                        color: Colors.redAccent,
                      ),
                    ),
                  ],
                ),
                Gap(15.sp),
                Expanded(
                  child: Text(
                    'Are you sure you want to delete this date?',
                    style: TextStyle(
                      fontSize: 20.sp,
                    ),
                  ),
                ),
                Gap(15.sp),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    InkWell(
                      borderRadius: BorderRadius.circular(15.sp),
                      onTap: () => Navigator.pop(ctx),
                      child: Padding(
                        padding: EdgeInsets.all(10.sp),
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                            fontSize: 20.sp,
                          ),
                        ),
                      ),
                    ),
                    Gap(15.sp),
                    InkWell(
                      onTap: () async {
                        setState(() => loading = true);
                        final result = await ref
                            .read(dateProvider.notifier)
                            .removeFromList(date);

                        if (!result.success && context.mounted) {
                          errorToast(result.message, context);
                        }
                        if (ctx.mounted) Navigator.pop(ctx);
                        setState(() => loading = false);
                      },
                      child: Padding(
                        padding: EdgeInsets.all(10.sp),
                        child: AnimatedSwitcher(
                          duration: 500.milliseconds,
                          child: loading
                              ? SizedBox(
                                  height: 30.sp,
                                  width: 30.sp,
                                  child: const CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation(
                                      carolinaBlue,
                                    ),
                                  ),
                                )
                              : Text(
                                  'Delete',
                                  style: TextStyle(
                                    fontSize: 20.sp,
                                    color: Colors.redAccent,
                                  ),
                                ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void dateDialog(
  BuildContext context,
  WidgetRef ref, {
  ImportantDate? date,
}) {
  bool loading = false;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController titleCtr = TextEditingController();
  TextEditingController dateCtr = TextEditingController();
  TextEditingController timeCtr = TextEditingController();

  if (date != null) {
    titleCtr.text = date.title;
    dateCtr.text = DateFormat('dd MMM yyyy').format(date.date);
    timeCtr.text = DateFormat('hh:mm aa').format(date.date);
  }

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (ctx) => AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.sp),
      ),
      contentPadding: EdgeInsets.zero,
      content: StatefulBuilder(
        builder: (_, setState) => Container(
          width: context.width / 2,
          padding: EdgeInsets.all(15.sp),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.sp),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      date != null ? 'Edit Date' : 'Add Date',
                      style: TextStyle(
                        fontSize: 23.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: loading ? null : () => Navigator.pop(ctx),
                    customBorder: const CircleBorder(),
                    splashColor: carolinaBlue,
                    child: Padding(
                      padding: EdgeInsets.all(10.sp),
                      child: Icon(
                        Icons.close,
                        color: black.withOpacity(0.6),
                        size: 30.sp,
                      ),
                    ),
                  ),
                ],
              ),
              Gap(50.sp),
              Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      validator: (value) {
                        if (value != null) {
                          if (value.isEmpty) {
                            return 'Title cannot be empty';
                          }
                        }
                        return null;
                      },
                      controller: titleCtr,
                      decoration: InputDecoration(
                        labelText: 'Title',
                        hintText: 'Admin form deadline',
                        counterText: '',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.sp),
                          borderSide: BorderSide(
                            color: black.withOpacity(0.6),
                            width: 1.sp,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.sp),
                          borderSide: BorderSide(
                            color: carolinaBlue.withOpacity(0.6),
                            width: 1.sp,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.sp),
                          borderSide: BorderSide(
                            color: Colors.redAccent.withOpacity(0.6),
                            width: 1.sp,
                          ),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    Gap(15.sp),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Flexible(
                          child: TextFormField(
                            controller: dateCtr,
                            readOnly: true,
                            onTap: () async {
                              final result = await showDatePicker(
                                context: ctx,
                                // initialDate: newDate,
                                firstDate: DateTime.now().subtract(
                                  const Duration(days: 30),
                                ),
                                lastDate: DateTime.now().add(
                                  const Duration(days: 120),
                                ),
                              );
                              if (result != null) {
                                dateCtr.text =
                                    DateFormat('dd MMM yyyy').format(result);
                              }
                            },
                            decoration: InputDecoration(
                              labelText: 'Date',
                              counterText: '',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.sp),
                                borderSide: BorderSide(
                                  color: black.withOpacity(0.6),
                                  width: 1.sp,
                                ),
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.sp),
                                borderSide: BorderSide(
                                  color: black.withOpacity(0.6),
                                  width: 1.sp,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.sp),
                                borderSide: BorderSide(
                                  color: carolinaBlue.withOpacity(0.6),
                                  width: 1.sp,
                                ),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.sp),
                                borderSide: BorderSide(
                                  color: Colors.redAccent.withOpacity(0.6),
                                  width: 1.sp,
                                ),
                              ),
                            ),
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        Gap(15.sp),
                        Flexible(
                          child: TextFormField(
                            readOnly: true,
                            controller: timeCtr,
                            onTap: () async {
                              final result = await showTimePicker(
                                context: ctx,
                                initialTime: TimeOfDay.now(),
                              );
                              if (result != null) {
                                timeCtr.text =
                                    DateFormat('hh:mm aa').format(DateTime(
                                  2024,
                                  1,
                                  1,
                                  result.hour,
                                  result.minute,
                                ));
                              }
                            },
                            decoration: InputDecoration(
                              labelText: 'Time',
                              counterText: '',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.sp),
                                borderSide: BorderSide(
                                  color: black.withOpacity(0.6),
                                  width: 1.sp,
                                ),
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.sp),
                                borderSide: BorderSide(
                                  color: black.withOpacity(0.6),
                                  width: 1.sp,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.sp),
                                borderSide: BorderSide(
                                  color: carolinaBlue.withOpacity(0.6),
                                  width: 1.sp,
                                ),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.sp),
                                borderSide: BorderSide(
                                  color: Colors.redAccent.withOpacity(0.6),
                                  width: 1.sp,
                                ),
                              ),
                            ),
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Material(
                    color: carolinaBlue,
                    borderRadius: BorderRadius.circular(15.sp),
                    child: InkWell(
                      onTap: () async {
                        final bool dataValid =
                            formKey.currentState?.validate() ?? false;
                        if (dataValid) {
                          setState(() {
                            loading = true;
                          });

                          final newDate = ImportantDate(
                            id: '',
                            title: titleCtr.text,
                            date: DateFormat('dd MMM yyyy hh:mm aa')
                                .parse('${dateCtr.text} ${timeCtr.text}'),
                          );
                          ApiResponse result;

                          if (date != null) {
                            result = await ref
                                .read(dateProvider.notifier)
                                .updateInList(newDate);
                          } else {
                            result = await ref
                                .read(dateProvider.notifier)
                                .addToList(newDate);
                          }

                          setState(() {
                            loading = false;
                          });

                          if (result.success) {
                            if (ctx.mounted) Navigator.pop(ctx);
                          } else {
                            if (ctx.mounted) {
                              errorToast(result.message, ctx);
                            }
                          }
                        }
                      },
                      borderRadius: BorderRadius.circular(15.sp),
                      child: Container(
                        width: 130.sp,
                        height: 60.sp,
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(15.sp),
                        child: AnimatedSwitcher(
                          duration: 500.milliseconds,
                          child: loading
                              ? SizedBox(
                                  width: 30.sp,
                                  height: 30.sp,
                                  child: const CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation(
                                      white,
                                    ),
                                  ),
                                )
                              : FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                    'Save',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: white,
                                      fontSize: 30.sp,
                                    ),
                                  ),
                                ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
