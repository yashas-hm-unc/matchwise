import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:matchwise/core/constants/app_colors.dart';
import 'package:matchwise/core/models/faculty_user.dart';
import 'package:matchwise/core/utilities/extensions.dart';
import 'package:matchwise/core/utilities/utils.dart';
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
                            ref: ref,
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
                  onTap: () => facultyDialog(context, ref),
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
              );
            }),
          ),
        ],
      ),
    );
  }
}

class FacultyItem extends StatelessWidget {
  const FacultyItem({
    super.key,
    required this.facultyUser,
    required this.ref,
  });

  final WidgetRef ref;

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
          SizedBox(
            width: context.width / 3.5,
            child: Text(
              '${facultyUser.firstName} ${facultyUser.lastName}',
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Text(
              facultyUser.email,
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 20.sp,
              ),
            ),
          ),
          InkWell(
            onTap: () => facultyDialog(
              context,
              ref,
              faculty: facultyUser,
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
          Gap(15.sp),
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
                    'Are you sure you want to delete this faculty?',
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
                        await ref
                            .read(facultyProvider.notifier)
                            .removeFromList(facultyUser);
                        setState(() => loading = false);
                        if (ctx.mounted) Navigator.pop(ctx);
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

void facultyDialog(
  BuildContext context,
  WidgetRef ref, {
  FacultyUser? faculty,
}) {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool loading = false;
  bool loadingAutofill = false;
  bool search = faculty == null;
  TextEditingController onyenCtr = TextEditingController();
  TextEditingController fnCtr = TextEditingController();
  TextEditingController lnCtr = TextEditingController();
  TextEditingController emailCtr = TextEditingController();

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
                      faculty != null ? 'Edit Faculty' : 'Add Faculty',
                      style: TextStyle(
                        fontSize: 23.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: loading || loadingAutofill
                        ? null
                        : () => Navigator.pop(ctx),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        SizedBox(
                          width: context.width / 4,
                          child: TextFormField(
                            controller: onyenCtr,
                            validator: (value) {
                              if (value != null) {
                                if (value.isEmpty) {
                                  return 'Onyen cannot be empty';
                                }
                              }
                              return null;
                            },
                            initialValue: faculty?.onyen,
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
                          ),
                        ),
                        if (search)
                          Material(
                            borderRadius: BorderRadius.circular(15.sp),
                            color: carolinaBlue,
                            child: InkWell(
                              onTap: () async {
                                setState(() => loadingAutofill = true);
                                if (formKey.currentState?.validate() ?? false) {
                                  final response =
                                      await autofillFacultyForm(onyenCtr.text);
                                  if (response.success) {
                                    setState(() {
                                      search = false;
                                      loadingAutofill = false;
                                      final newFaculty = response
                                          .args!['faculty'] as FacultyUser;
                                      fnCtr.text = newFaculty.firstName;
                                      lnCtr.text = newFaculty.lastName;
                                      emailCtr.text = newFaculty.email;
                                    });
                                  }
                                }
                                setState(() => loadingAutofill = false);
                              },
                              borderRadius: BorderRadius.circular(15.sp),
                              child: Container(
                                padding: EdgeInsets.all(10.sp),
                                child: Text(
                                  'Autofill',
                                  style: TextStyle(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.bold,
                                    color: white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                    Gap(15.sp),
                    TextFormField(
                      controller: fnCtr,
                      validator: (value) {
                        if (search) {
                          return null;
                        }

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
                    ),
                    Gap(15.sp),
                    TextFormField(
                      controller: lnCtr,
                      validator: (value) {
                        if (search) {
                          return null;
                        }

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
                    ),
                    Gap(15.sp),
                    TextFormField(
                      controller: emailCtr,
                      validator: (value) {
                        if (search) {
                          return null;
                        }

                        if (value != null) {
                          if (value.isEmpty || !value.isEmail) {
                            return 'Invalid email.';
                          }
                        }
                        return null;
                      },
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
                      onTap: loadingAutofill
                          ? null
                          : () async {
                              final bool dataValid =
                                  formKey.currentState?.validate() ?? false;
                              if (dataValid) {
                                setState(() {
                                  loading = true;
                                });

                                final newFaculty = FacultyUser(
                                  firstName: fnCtr.text,
                                  lastName: lnCtr.text,
                                  onyen: onyenCtr.text,
                                  email: emailCtr.text,
                                );

                                if (faculty != null) {
                                  await ref
                                      .read(facultyProvider.notifier)
                                      .updateList(newFaculty);
                                } else {
                                  await ref
                                      .read(facultyProvider.notifier)
                                      .addToList(newFaculty);
                                }

                                setState(() {
                                  loading = false;
                                });
                                if (ctx.mounted) Navigator.pop(ctx);
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
