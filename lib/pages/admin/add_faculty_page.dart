import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:matchwise/core/constants/app_colors.dart';
import 'package:matchwise/core/models/faculty_user.dart';
import 'package:matchwise/core/utilities/extensions.dart';
import 'package:matchwise/providers/faculty_provider.dart';
import 'package:resize/resize.dart';

class AddFacultyPage extends StatelessWidget {
  const AddFacultyPage({super.key});

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
                  'Modify Faculty Users',
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
                          itemBuilder: (ctx, index) => FacultyItem(
                            facultyUser: faculty[index],
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
            child: Material(
              borderRadius: BorderRadius.circular(25.sp),
              color: carolinaBlue,
              child: InkWell(
                onTap: () => addFacultyDialog(context),
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
                          'Add Faculty',
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

  void addFacultyDialog(
    BuildContext context, {
    FacultyUser? faculty,
  }) {
    bool loading = false;
    bool firstNameError = false;
    bool lastNameError = false;
    bool emailError = false;
    bool pidError = false;

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.sp),
        ),
        contentPadding: EdgeInsets.zero,
        content: StatefulBuilder(
          builder: (_, setState) => Container(
            width: context.width / 2,
            height: context.height / 0.8,
            padding: EdgeInsets.all(15.sp),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.sp),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Add Faculty',
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
                SizedBox(
                  width: context.width / 4,
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'PID',
                      hintText: '123456789',
                      counterText: '',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.sp),
                        borderSide: BorderSide(
                          color: black.withOpacity(0.6),
                          width: 1.sp,
                        ),
                      ),
                      errorText: pidError
                          ? 'PID should be at least 9 characters.'
                          : null,
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
                TextField(
                  decoration: InputDecoration(
                    labelText: 'First Name',
                    hintText: 'John',
                    counterText: '',
                    errorText:
                        firstNameError ? 'First name cannot be empty.' : null,
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
                  keyboardType: TextInputType.name,
                ),
                Gap(15.sp),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Last Name',
                    hintText: 'Doe',
                    counterText: '',
                    errorText:
                        lastNameError ? 'Last name cannot be empty.' : null,
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
                  keyboardType: TextInputType.name,
                ),
                Gap(15.sp),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Email',
                    hintText: 'onyen@cs.unc.edu',
                    counterText: '',
                    errorText: emailError ? 'Invalid Email' : null,
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
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Material(
                      color: carolinaBlue,
                      borderRadius: BorderRadius.circular(15.sp),
                      child: InkWell(
                        onTap: () async {
                          setState(() {
                            loading = true;
                            pidError = true;
                            lastNameError = true;
                            firstNameError = true;
                            emailError = true;
                          });

                          await Future.delayed(2000.milliseconds, () {});

                          setState(() {
                            loading = false;
                            pidError = false;
                            lastNameError = false;
                            firstNameError = false;
                            emailError = false;
                          });
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
}

class FacultyItem extends StatelessWidget {
  const FacultyItem({
    super.key,
    required this.facultyUser,
  });

  final FacultyUser facultyUser;

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
          Text(
            '${facultyUser.firstName} ${facultyUser.lastName}',
            textAlign: TextAlign.start,
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: Text(
              facultyUser.email,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20.sp,
              ),
            ),
          ),
          InkWell(
            onTap: () {},
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
          Gap(15.sp),
          InkWell(
            onTap: () {},
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
}
