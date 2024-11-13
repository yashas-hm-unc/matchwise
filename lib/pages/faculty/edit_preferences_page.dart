import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:matchwise/core/constants/app_colors.dart';
import 'package:matchwise/core/models/faculty_user.dart';
import 'package:matchwise/core/utilities/extensions.dart';
import 'package:matchwise/providers/faculty_provider.dart';
import 'package:matchwise/providers/user_provider.dart';
import 'package:resize/resize.dart';

class EditPreferencesPage extends ConsumerStatefulWidget {
  const EditPreferencesPage({super.key});

  @override
  ConsumerState<EditPreferencesPage> createState() =>
      _EditPreferencesPageState();
}

class _EditPreferencesPageState extends ConsumerState<EditPreferencesPage> {
  bool loading = false;
  TextEditingController posCtr = TextEditingController();
  TextEditingController resIntCtr = TextEditingController();
  List<String> researchInterests = [];
  late FacultyUser user;

  @override
  void initState() {
    user = ref.read(userProvider) as FacultyUser;
    researchInterests = user.researchInterests;
    posCtr.text = user.positionsOpen.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.height,
      width: context.width,
      margin: EdgeInsets.all(15.sp),
      padding: EdgeInsets.all(15.sp),
      child: Stack(
        children: [
          SizedBox(
            width: context.width / 2,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Edit Interests',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 28.sp,
                  ),
                ),
                Gap(30.sp),
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.start,
                  alignment: WrapAlignment.start,
                  spacing: 5.sp,
                  runSpacing: 5.sp,
                  children: buildChips(setState),
                ),
                Gap(15.sp),
                Autocomplete(
                  fieldViewBuilder: (_, ctr, node, submit) {
                    resIntCtr = ctr;
                    return TextField(
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
                      onSubmitted: (val) {
                        if (val != '') {
                          setState(
                            () {
                              if(!researchInterests.contains(val)){
                                researchInterests.add(val);
                              }
                            },
                          );
                        } else {
                          submit();
                        }
                        ctr.clear();
                      },
                    );
                  },
                  optionsBuilder: (val) => ref
                      .read(facultyProvider.notifier)
                      .getResearchInterests()
                      .where(
                        (ele) => ele.startsWith(val.text),
                      ),
                  onSelected: (val) {
                    setState(
                      () {
                        if(!researchInterests.contains(val)){
                          researchInterests.add(val);
                        }
                      },
                    );
                    resIntCtr.clear();
                  },
                ),
                Gap(15.sp),
                TextFormField(
                  controller: posCtr,
                  decoration: InputDecoration(
                    labelText: 'Positions Open',
                    hintText: '2',
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
                  onFieldSubmitted: (_) => submitForm(),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Material(
              borderRadius: BorderRadius.circular(15.sp),
              color: carolinaBlue,
              child: InkWell(
                onTap: submitForm,
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

  void submitForm() {
    try{
      int.parse(posCtr.text);
    }catch(_){
      return;
    }

    setState(() => loading = true);
    final oldUser = ref.read(userProvider) as FacultyUser;
    if (oldUser.researchInterests != researchInterests ||
        oldUser.positionsOpen != user.positionsOpen) {
      user.researchInterests = researchInterests;
      user.positionsOpen = int.parse(posCtr.text);
      ref.read(userProvider.notifier).update(user);
    }
    setState(() => loading = false);
  }

  List<Chip> buildChips(setState) {
    final list = <Chip>[];

    list.clear();
    for (String i in researchInterests) {
      list.add(
        Chip(
          onDeleted: () => setState(() => researchInterests =
              researchInterests.where((ele) => ele != i).toList()),
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
