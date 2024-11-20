import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:matchwise/core/constants/app_colors.dart';
import 'package:matchwise/core/utilities/extensions.dart';
import 'package:matchwise/core/utilities/firestore_utils.dart';
import 'package:matchwise/core/utilities/toast_utils.dart';
import 'package:matchwise/core/utilities/utils.dart';
import 'package:matchwise/screens/splash_screen.dart';
import 'package:resize/resize.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      margin: EdgeInsets.all(30.sp),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Dashboard',
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
            'Start Sorting',
          ),
          Gap(20.sp),
          optionButton(
            context,
            () {},
            'Start Matching',
          ),
          Gap(20.sp),
          optionButton(
            context,
            () => createSessionDialog(context),
            'Create new Matching Session',
          ),
        ],
      ),
    );
  }

  void createSessionDialog(BuildContext context) {
    bool loading = false;
    TextEditingController ctr = TextEditingController();
    String errorText = '';
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.sp),
        ),
        contentPadding: EdgeInsets.all(15.sp),
        content: StatefulBuilder(
          builder: (_, setState) {
            return Consumer(
              builder: (_, ref, __) => SizedBox(
                width: context.width / 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Create New Session',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 25.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: loading ? null : () => Navigator.pop(ctx),
                            child: Icon(
                              Icons.close_rounded,
                              color: black,
                              size: 30.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Gap(15.sp),
                    TextField(
                      controller: ctr,
                      decoration: InputDecoration(
                        labelText: 'Session Name (Snake Case)',
                        hintText: 'fall_24',
                        counterText: '',
                        errorText: errorText,
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
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                    ),
                    Gap(15.sp),
                    Material(
                      borderRadius: BorderRadius.circular(15.sp),
                      color: carolinaBlue,
                      child: InkWell(
                        onTap: loading
                            ? null
                            : () async {
                                setState(() => loading = true);

                                if (ctr.text != '') {
                                  final results =
                                      await createNewSession(ctr.text, ref);
                                  if (results.success) {
                                    if (ctx.mounted) Navigator.pop(ctx);
                                    if (context.mounted) {
                                      navigateOffAll(
                                        context,
                                        const SplashScreen(),
                                      );
                                    }
                                  } else {
                                    if (context.mounted) {
                                      errorToast(
                                        results.message,
                                        context,
                                      );
                                    }
                                  }
                                } else {
                                  setState(() =>
                                      errorText = 'Field cannot be empty.');
                                }

                                setState(() => loading = false);
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
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget optionButton(
    BuildContext ctx,
    VoidCallback onTap,
    String text,
  ) {
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
