import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:matchwise/core/constants/app_colors.dart';
import 'package:matchwise/core/constants/app_constants.dart';
import 'package:matchwise/core/utilities/extensions.dart';
import 'package:matchwise/core/utilities/toast_utils.dart';
import 'package:matchwise/providers/match_provider.dart';
import 'package:matchwise/providers/ui_provider.dart';
import 'package:matchwise/providers/user_provider.dart';
import 'package:matchwise/widgets/board/board_item.dart';
import 'package:matchwise/widgets/board/board_list.dart';
import 'package:matchwise/widgets/board/boardview.dart';
import 'package:matchwise/widgets/board/boardview_controller.dart';
import 'package:matchwise/widgets/student_details.dart';
import 'package:matchwise/widgets/student_item.dart';
import 'package:resize/resize.dart';

class FacultyDashboardPage extends ConsumerStatefulWidget {
  const FacultyDashboardPage({super.key});

  @override
  ConsumerState<FacultyDashboardPage> createState() =>
      _FacultyDashboardPageState();
}

class _FacultyDashboardPageState extends ConsumerState<FacultyDashboardPage> {
  bool loading = false;
  BoardViewController boardController = BoardViewController();

  @override
  Widget build(BuildContext context) {
    final collapsed = ref.watch(collapsedProvider);
    final width =
        (context.width - (collapsed ? context.width / 20 : context.width / 5)) /
            3.3;
    final map = ref.watch(sortedProvider);

    return Container(
      height: context.height,
      width: context.width,
      margin: EdgeInsets.all(15.sp),
      padding: EdgeInsets.all(15.sp),
      child: Stack(
        children: [
          Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Dashboard',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 28.sp,
                ),
              ),
              Gap(30.sp),
              Expanded(
                child: BoardView(
                  width: width,
                  boardViewController: boardController,
                  lists: [
                    BoardList(
                      items: (map[keys[0]] ?? [])
                          .map(
                            (e) => BoardItem(
                              onTapItem: onTapItem,
                              onDropItem: onDropItem,
                              draggable: true,
                              item: StudentItem(
                                user: e,
                                facultyOnyen: ref.read(userProvider).onyen,
                              ),
                            ),
                          )
                          .toList(),
                      header: [
                        Text(
                          'Students',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 23.sp,
                          ),
                        ),
                        Gap(15.sp),
                      ],
                      listContainer: (Widget child) => Container(
                        height: double.infinity,
                        width: double.infinity,
                        margin: EdgeInsets.only(right: 15.sp),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: black.withOpacity(0.6),
                          ),
                          borderRadius: BorderRadius.circular(15.sp),
                        ),
                        padding: EdgeInsets.all(15.sp),
                        child: child,
                      ),
                    ),
                    BoardList(
                      items: (map[keys[1]] ?? [])
                          .map(
                            (e) => BoardItem(
                              onTapItem: onTapItem,
                              onDropItem: onDropItem,
                              draggable: true,
                              item: StudentItem(
                                user: e,
                                facultyOnyen: ref.read(userProvider).onyen,
                              ),
                            ),
                          )
                          .toList(),
                      header: [
                        Text(
                          'Interviewing',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 23.sp,
                          ),
                        ),
                        Gap(15.sp),
                      ],
                      listContainer: (Widget child) => Container(
                        height: double.infinity,
                        width: double.infinity,
                        margin: EdgeInsets.only(right: 15.sp),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: black.withOpacity(0.6),
                          ),
                          borderRadius: BorderRadius.circular(15.sp),
                        ),
                        padding: EdgeInsets.all(15.sp),
                        child: child,
                      ),
                    ),
                    BoardList(
                      items: (map[keys[2]] ?? [])
                          .map(
                            (e) => BoardItem(
                              onTapItem: onTapItem,
                              onDropItem: onDropItem,
                              draggable: true,
                              item: StudentItem(
                                user: e,
                                facultyOnyen: ref.read(userProvider).onyen,
                              ),
                            ),
                          )
                          .toList(),
                      header: [
                        Text(
                          'Final Selection',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 23.sp,
                          ),
                        ),
                        Gap(15.sp),
                      ],
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
                    ),
                  ],
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
                onTap: () async {
                  setState(() => loading = true);
                  final results =
                      await ref.read(sortedProvider.notifier).saveList();
                  if (context.mounted) {
                    if (results.success) {
                      successToast('Selection saved successfully', context);
                    } else {
                      errorToast(results.message, context);
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

  void onDropItem(
    int? newListIndex,
    int? newIndex,
    int? oldListIndex,
    int? oldIndex,
    BoardItemState state,
  ) {
    final notifier = ref.read(sortedProvider.notifier);
    if (newListIndex != oldListIndex) {
      notifier.addToNewList(
        keys[oldListIndex!],
        keys[newListIndex!],
        oldIndex!,
        newIndex!,
      );
    } else {
      notifier.updateList(
        keys[newListIndex!],
        oldIndex!,
        newIndex!,
      );
    }
  }

  void onTapItem(
    int? list,
    int? index,
    BoardItemState state,
  ) {
    if (list != null && index != null) {
      final map = ref.read(sortedProvider);
      showStudentDetails(
        context,
        map[keys[list]]![index],
      );
    }
  }
}
