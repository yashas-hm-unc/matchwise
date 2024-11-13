import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:matchwise/core/constants/app_colors.dart';
import 'package:matchwise/core/models/student_user.dart';
import 'package:matchwise/core/utilities/extensions.dart';
import 'package:matchwise/providers/faculty_provider.dart';
import 'package:matchwise/providers/user_provider.dart';
import 'package:resize/resize.dart';

class StudentFormPage extends ConsumerStatefulWidget {
  const StudentFormPage({super.key});

  @override
  ConsumerState<StudentFormPage> createState() => _StudentFormPageState();
}

class _StudentFormPageState extends ConsumerState<StudentFormPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController descriptionCtr = TextEditingController();
  final TextEditingController videoLinkCtr = TextEditingController();
  final TextEditingController resumeLinkCtr = TextEditingController();

  late TextEditingController researchInterestsCtr;
  late TextEditingController taCtr;
  late TextEditingController profPrefCtr;
  
  bool loading = false;
  List<String> researchInterests = [];
  List<String> taPref = [];
  List<String> profPref = [];

  @override
  void initState() {
    final user = ref.read(userProvider) as StudentUser;

    researchInterests = user.researchInterests;
    taPref = user.courseTAPref;
    profPref = user.prefProfessors;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      margin: EdgeInsets.all(30.sp),
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Matching Form',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 28.sp,
                ),
              ),
              Gap(30.sp),
              Expanded(
                child: Form(
                  key: formKey,
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics(),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        TextFormField(
                          controller: descriptionCtr,
                          validator: (val) {
                            if (val?.isEmpty ?? false) {
                              return 'Please enter description';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: 'Description',
                            hintText: 'Write a short description about yourself',
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
                        Gap(15.sp),
                        TextFormField(
                          controller: resumeLinkCtr,
                          decoration: InputDecoration(
                            labelText: 'Resume Link',
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
                        Gap(15.sp),
                        TextFormField(
                          controller: videoLinkCtr,
                          decoration: InputDecoration(
                            labelText: 'Video Link',
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
                        Gap(15.sp),
                        Wrap(
                          crossAxisAlignment: WrapCrossAlignment.start,
                          alignment: WrapAlignment.start,
                          spacing: 5.sp,
                          runSpacing: 5.sp,
                          children: buildChips(
                            researchInterests,
                            (i) => setState(
                              () => researchInterests = researchInterests
                                  .where((ele) => ele != i)
                                  .toList(),
                            ),
                          ),
                        ),
                        Gap(15.sp),
                        Autocomplete(
                          fieldViewBuilder: (_, ctr, node, __) {
                            researchInterestsCtr = ctr;
                            return TextField(
                              enabled: researchInterests.length < 5,
                              controller: ctr,
                              focusNode: node,
                              decoration: InputDecoration(
                                labelText: 'Research Interests',
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
                            );
                          },
                          optionsBuilder: (val) => ref
                              .read(facultyProvider.notifier)
                              .getResearchInterests()
                              .where(
                                (ele) => ele.startsWith(val.text),
                              ),
                          onSelected: (val) {
                            setState(() => researchInterests.add(val));
                            researchInterestsCtr.clear();
                          },
                        ),
                        Gap(15.sp),
                        Wrap(
                          crossAxisAlignment: WrapCrossAlignment.start,
                          alignment: WrapAlignment.start,
                          spacing: 5.sp,
                          runSpacing: 5.sp,
                          children: buildChips(
                            taPref,
                            (i) => setState(() =>
                                taPref = taPref.where((ele) => ele != i).toList()),
                          ),
                        ),
                        Gap(15.sp),
                        Autocomplete(
                          fieldViewBuilder: (_, ctr, node, __) {
                            taCtr = ctr;
                            return TextField(
                              enabled: taPref.length < 5,
                              controller: ctr,
                              focusNode: node,
                              decoration: InputDecoration(
                                labelText: 'Course TA Preferences',
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
                            );
                          },
                          optionsBuilder: (val) =>
                              ref.read(facultyProvider.notifier).getCourses().where(
                                    (ele) => ele.startsWith(val.text),
                                  ),
                          onSelected: (val) {
                            setState(() => taPref.add(val));
                            taCtr.clear();
                          },
                        ),
                        Gap(15.sp),
                        Wrap(
                          crossAxisAlignment: WrapCrossAlignment.start,
                          alignment: WrapAlignment.start,
                          spacing: 5.sp,
                          runSpacing: 5.sp,
                          children: buildChips(
                            profPref,
                            (i) => setState(() => profPref =
                                profPref.where((ele) => ele != i).toList()),
                          ),
                        ),
                        Gap(15.sp),
                        Autocomplete(
                          fieldViewBuilder: (_, ctr, node, __) {
                            profPrefCtr = ctr;
                            return TextField(
                              enabled: profPref.length < 5,
                              controller: ctr,
                              focusNode: node,
                              decoration: InputDecoration(
                                labelText: 'Professor Preference',
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
                            );
                          },
                          optionsBuilder: (val) => ref
                              .read(facultyProvider.notifier)
                              .getProfessors()
                              .where(
                                (ele) => ele.startsWith(val.text),
                              ),
                          onSelected: (val) {
                            setState(() => profPref.add(val));
                            profPrefCtr.clear();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),

          Align(
            alignment: Alignment.bottomRight,
            child: Material(
              borderRadius: BorderRadius.circular(15.sp),
              color: carolinaBlue,
              child: InkWell(
                onTap: (){},
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
        ],
      ),
    );
  }

  List<Chip> buildChips(
    List<String> value,
    Function(String) onDelete,
  ) {
    final list = <Chip>[];

    list.clear();
    for (String i in value) {
      list.add(
        Chip(
          onDeleted: () => onDelete(i),
          deleteIconColor: white,
          backgroundColor: carolinaBlue,
          label: Text(
            i,
            style: const TextStyle(
              color: white,
            ),
          ),
          padding: EdgeInsets.symmetric(
            vertical: 5.sp,
            horizontal: 8.sp,
          ),
        ),
      );
    }

    return list;
  }
}
