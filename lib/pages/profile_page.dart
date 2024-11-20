import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:matchwise/core/constants/app_colors.dart';
import 'package:matchwise/core/models/faculty_user.dart';
import 'package:matchwise/core/models/matchwise_user.dart';
import 'package:matchwise/core/models/student_user.dart';
import 'package:matchwise/core/utilities/extensions.dart';
import 'package:matchwise/core/utilities/toast_utils.dart';
import 'package:matchwise/providers/user_provider.dart';
import 'package:resize/resize.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key});

  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool loading = false;
  TextEditingController fnCtr = TextEditingController();
  TextEditingController lnCtr = TextEditingController();

  @override
  void initState() {
    final user = ref.read(userProvider);
    fnCtr.text = user.firstName;
    lnCtr.text = user.lastName;
    super.initState();
  }

  @override
  void dispose() {
    fnCtr.dispose();
    lnCtr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(30.sp),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Edit Profile',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 28.sp,
                  ),
                ),
                Gap(30.sp),
                Expanded(
                  child: Container(
                    width: context.width / 2,
                    padding: EdgeInsets.all(30.sp),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.sp),
                      border: Border.all(
                        color: black.withOpacity(0.5),
                        width: 1.sp,
                      ),
                    ),
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            width: context.width / 4,
                            child: TextFormField(
                              initialValue: ref.read(userProvider).onyen,
                              readOnly: true,
                              decoration: InputDecoration(
                                labelText: 'onyen',
                                hintText: 'onyen',
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
                              textInputAction: TextInputAction.done,
                            ),
                          ),
                          Gap(15.sp),
                          TextFormField(
                            controller: fnCtr,
                            validator: (value) {
                              if (value != null) {
                                if (value.isEmpty) {
                                  return 'First name cannot be empty.';
                                }
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              labelText: 'First Name',
                              hintText: 'John',
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
                            keyboardType: TextInputType.name,
                            textInputAction: TextInputAction.next,
                          ),
                          Gap(15.sp),
                          TextFormField(
                            controller: lnCtr,
                            validator: (value) {
                              if (value != null) {
                                if (value.isEmpty) {
                                  return 'Last name cannot be empty.';
                                }
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              labelText: 'Last Name',
                              hintText: 'Doe',
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
                            keyboardType: TextInputType.name,
                            textInputAction: TextInputAction.next,
                          ),
                          Gap(15.sp),
                          TextFormField(
                            initialValue: ref.read(userProvider).email,
                            readOnly: true,
                            decoration: InputDecoration(
                              labelText: 'Email',
                              hintText: 'onyen@cs.unc.edu',
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
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                          ),
                          Expanded(
                            child: Align(
                              alignment: Alignment.bottomRight,
                              child: Align(
                                alignment: Alignment.bottomRight,
                                child: Material(
                                  borderRadius: BorderRadius.circular(15.sp),
                                  color: carolinaBlue,
                                  child: InkWell(
                                    onTap: () async {
                                      setState(() => loading = true);
                                      if (formKey.currentState?.validate() ??
                                          false) {
                                        final type =
                                            ref.read(userProvider).type;
                                        MatchWiseUser user =
                                            ref.read(userProvider);
                                        switch (type) {
                                          case UserType.admin:
                                            user = user;
                                            break;
                                          case UserType.student:
                                            user = user as StudentUser;
                                            break;
                                          case UserType.faculty:
                                            user = user as FacultyUser;
                                            break;
                                        }

                                        user.lastName = lnCtr.text;
                                        user.firstName = fnCtr.text;

                                        final results = await ref
                                            .read(userProvider.notifier)
                                            .update(user);
                                        if (context.mounted) {
                                          if (results.success) {
                                            successToast(
                                                'Profile updated Successfully',
                                                context);
                                          } else {
                                            errorToast(
                                                results.message, context);
                                          }
                                        }
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
                                                child:
                                                    const CircularProgressIndicator(
                                                  valueColor:
                                                      AlwaysStoppedAnimation(
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
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
