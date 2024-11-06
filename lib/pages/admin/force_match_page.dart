import 'package:flutter/material.dart';
// import 'package:flutter_boardview/board_item.dart';
// import 'package:flutter_boardview/board_list.dart';
// import 'package:flutter_boardview/boardview.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:matchwise/core/constants/app_colors.dart';
import 'package:matchwise/core/error/fallback_objects.dart';
import 'package:matchwise/core/models/faculty_user.dart';
import 'package:matchwise/core/models/student_user.dart';
import 'package:matchwise/core/utilities/extensions.dart';
import 'package:matchwise/core/utilities/utils.dart';
import 'package:matchwise/providers/faculty_provider.dart';
import 'package:matchwise/providers/match_provider.dart';
import 'package:matchwise/widgets/board/board_item.dart';
import 'package:matchwise/widgets/board/board_list.dart';
import 'package:matchwise/widgets/board/boardview.dart';
import 'package:matchwise/widgets/board/boardview_controller.dart';
import 'package:matchwise/widgets/student_item.dart';
import 'package:resize/resize.dart';

class ForceMatchPage extends ConsumerStatefulWidget {
  const ForceMatchPage({super.key});

  @override
  ConsumerState<ForceMatchPage> createState() => _ForceMatchPageState();
}

class _ForceMatchPageState extends ConsumerState<ForceMatchPage> {
  FacultyUser? selectedFaculty1;
  FacultyUser? selectedFaculty2;
  List<StudentUser> faculty1Match = <StudentUser>[];
  List<StudentUser> faculty2Match = <StudentUser>[];
  BoardViewController boardViewController = BoardViewController();

  @override
  Widget build(BuildContext context) {
    final matched = ref.watch(matchedProvider);
    if (selectedFaculty1 != null) {
      faculty1Match = matched[selectedFaculty1]!;
    }
    if (selectedFaculty2 != null) {
      faculty2Match = matched[selectedFaculty2]!;
    }

    return Container(
      margin: EdgeInsets.all(15.sp),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Force Match',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 28.sp,
            ),
          ),
          Gap(30.sp),
          Expanded(
            child: BoardView(
              width: context.width / 3,
              boardViewController: BoardViewController(),
              lists: [
                BoardList(
                  // onStartDragList: (listIndex) {},
                  // onTapList: (listIndex) async {},
                  // onDropList: (listIndex, oldListIndex) {},
                  draggable: false,
                  header: [
                    DropdownMenu<FacultyUser>(
                      width: context.width / 5,
                      inputDecorationTheme: InputDecorationTheme(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.sp),
                        ),
                      ),
                      menuHeight: context.height / 1.5,
                      menuStyle: MenuStyle(
                        padding: const WidgetStatePropertyAll(EdgeInsets.zero),
                        backgroundColor: const WidgetStatePropertyAll(white),
                        shape: WidgetStatePropertyAll(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              15.sp,
                            ),
                          ),
                        ),
                      ),
                      onSelected: (value) {
                        if (value != null) {
                          setState(() => selectedFaculty1 = value);
                        }
                      },
                      label: const Text('Faculty 1'),
                      trailingIcon: null,
                      enableFilter: true,
                      enableSearch: false,
                      filterCallback: fuzzySearch,
                      dropdownMenuEntries: ref
                          .read(facultyProvider)
                          .map(
                            (ele) => DropdownMenuEntry(
                              value: facultyFallback.first,
                              label: '${ele.lastName}, ${ele.firstName}',
                            ),
                          )
                          .toList(),
                    ),
                    Gap(15.sp),
                  ],
                  items: faculty1Match
                      .map(
                        (e) => BoardItem(
                          draggable: true,
                          // onStartDragItem: (listIndex, itemIndex, state) {},
                          // onDropItem: (listIndex, itemIndex, oldListIndex,
                          //     oldItemIndex, state) {},
                          // onTapItem: (listIndex, itemIndex, state) async {},
                          item: StudentItem(
                            user: e,
                            facultyOnyen: selectedFaculty1!.onyen,
                          ),
                        ),
                      )
                      .toList(),
                  listContainer: (Widget child) => Container(
                    height: double.infinity,
                    width: double.infinity,
                    padding: EdgeInsets.all(15.sp),
                    margin: EdgeInsets.only(right: 15.sp),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: black.withOpacity(0.6),
                      ),
                      borderRadius: BorderRadius.circular(15.sp),
                    ),
                    child: child,
                  ),
                ),
                BoardList(
                  draggable: false,
                  header: [
                    DropdownMenu<FacultyUser>(
                      width: context.width / 5,
                      inputDecorationTheme: InputDecorationTheme(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.sp),
                        ),
                      ),
                      menuHeight: context.height / 1.5,
                      menuStyle: MenuStyle(
                        padding: const WidgetStatePropertyAll(EdgeInsets.zero),
                        backgroundColor: const WidgetStatePropertyAll(white),
                        shape: WidgetStatePropertyAll(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              15.sp,
                            ),
                          ),
                        ),
                      ),
                      onSelected: (value) {
                        if (value != null) {
                          setState(() => selectedFaculty2 = value);
                        }
                      },
                      label: const Text('Faculty 2'),
                      trailingIcon: null,
                      enableFilter: true,
                      enableSearch: false,
                      filterCallback: fuzzySearch,
                      dropdownMenuEntries: ref
                          .read(facultyProvider)
                          .map(
                            (ele) => DropdownMenuEntry(
                              value: facultyFallback.first,
                              label: '${ele.lastName}, ${ele.firstName}',
                            ),
                          )
                          .toList(),
                    ),
                    Gap(15.sp),
                  ],
                  items: faculty2Match
                      .map(
                        (e) => BoardItem(
                          draggable: true,
                          item: StudentItem(
                            user: e,
                            facultyOnyen: selectedFaculty1!.onyen,
                          ),
                        ),
                      )
                      .toList(),
                  listContainer: (Widget child) => Container(
                    height: double.infinity,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: black.withOpacity(0.6),
                      ),
                      borderRadius: BorderRadius.circular(15.sp),
                    ),
                    padding: EdgeInsets.all(15.sp),
                    child: child,
                  ),
                )
              ],
            ),
          ),
          // Expanded(
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.start,
          //     crossAxisAlignment: CrossAxisAlignment.center,
          //     mainAxisSize: MainAxisSize.max,
          //     children: [
          //       Expanded(
          //         child: Column(
          //           mainAxisSize: MainAxisSize.max,
          //           mainAxisAlignment: MainAxisAlignment.start,
          //           crossAxisAlignment: CrossAxisAlignment.start,
          //           children: [
          //             DropdownMenu<FacultyUser>(
          //               width: context.width / 5,
          //               inputDecorationTheme: InputDecorationTheme(
          //                 border: OutlineInputBorder(
          //                   borderRadius: BorderRadius.circular(15.sp),
          //                 ),
          //               ),
          //               menuHeight: context.height / 1.5,
          //               menuStyle: MenuStyle(
          //                 padding:
          //                     const WidgetStatePropertyAll(EdgeInsets.zero),
          //                 backgroundColor: const WidgetStatePropertyAll(white),
          //                 shape: WidgetStatePropertyAll(
          //                   RoundedRectangleBorder(
          //                     borderRadius: BorderRadius.circular(
          //                       15.sp,
          //                     ),
          //                   ),
          //                 ),
          //               ),
          //               onSelected: (value) {
          //                 if (value != null) {
          //                   selectedFaculty1 = value;
          //                 }
          //               },
          //               label: const Text('Faculty 1'),
          //               trailingIcon: null,
          //               enableFilter: true,
          //               enableSearch: false,
          //               filterCallback: fuzzySearch,
          //               dropdownMenuEntries: ref
          //                   .read(facultyProvider)
          //                   .map(
          //                     (ele) => DropdownMenuEntry(
          //                       value: facultyFallback.first,
          //                       label: '${ele.lastName}, ${ele.firstName}',
          //                     ),
          //                   )
          //                   .toList(),
          //             ),
          //             Gap(15.sp),
          //             Expanded(
          //               child: Container(
          //                 padding: EdgeInsets.all(15.sp),
          //                 decoration: BoxDecoration(
          //                   borderRadius: BorderRadius.circular(15.sp),
          //                   border: Border.all(
          //                     color: Colors.black.withOpacity(0.6),
          //                   ),
          //                 ),
          //               ),
          //             ),
          //           ],
          //         ),
          //       ),
          //       Gap(15.sp),
          //       Expanded(
          //         child: Column(
          //           mainAxisSize: MainAxisSize.max,
          //           mainAxisAlignment: MainAxisAlignment.start,
          //           crossAxisAlignment: CrossAxisAlignment.start,
          //           children: [
          //             DropdownMenu<FacultyUser>(
          //               width: context.width / 5,
          //               inputDecorationTheme: InputDecorationTheme(
          //                 border: OutlineInputBorder(
          //                   borderRadius: BorderRadius.circular(15.sp),
          //                 ),
          //               ),
          //               menuHeight: context.height / 1.5,
          //               menuStyle: MenuStyle(
          //                 padding:
          //                     const WidgetStatePropertyAll(EdgeInsets.zero),
          //                 backgroundColor: const WidgetStatePropertyAll(white),
          //                 shape: WidgetStatePropertyAll(
          //                   RoundedRectangleBorder(
          //                     borderRadius: BorderRadius.circular(
          //                       15.sp,
          //                     ),
          //                   ),
          //                 ),
          //               ),
          //               onSelected: (value) {
          //                 if (value != null) {
          //                   selectedFaculty2 = value;
          //                 }
          //               },
          //               label: const Text('Faculty 2'),
          //               trailingIcon: null,
          //               enableFilter: true,
          //               enableSearch: false,
          //               filterCallback: fuzzySearch,
          //               dropdownMenuEntries: ref
          //                   .read(facultyProvider)
          //                   .map(
          //                     (ele) => DropdownMenuEntry(
          //                       value: facultyFallback.first,
          //                       label: '${ele.lastName}, ${ele.firstName}',
          //                     ),
          //                   )
          //                   .toList(),
          //             ),
          //             Gap(15.sp),
          //             Expanded(
          //               child: Container(
          //                 padding: EdgeInsets.all(15.sp),
          //                 decoration: BoxDecoration(
          //                   borderRadius: BorderRadius.circular(15.sp),
          //                   border: Border.all(
          //                     color: Colors.black.withOpacity(0.6),
          //                   ),
          //                 ),
          //               ),
          //             ),
          //           ],
          //         ),
          //       )
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}
