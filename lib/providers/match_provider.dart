import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:matchwise/core/models/api_response.dart';
import 'package:matchwise/core/models/faculty_user.dart';
import 'package:matchwise/core/models/student_user.dart';
import 'package:matchwise/core/utilities/firestore_utils.dart';

final StateNotifierProvider<MatchedNotifier,
        Map<FacultyUser, List<StudentUser>>> matchedProvider =
    StateNotifierProvider(
  (ref) => MatchedNotifier(
    {},
    ref,
  ),
);

final StateNotifierProvider<SortedNotifier, Map<String, List<StudentUser>>>
    sortedProvider = StateNotifierProvider(
  (ref) => SortedNotifier(
    {},
    ref,
  ),
);

class MatchedNotifier
    extends StateNotifier<Map<FacultyUser, List<StudentUser>>> {
  MatchedNotifier(
    super.state,
    this.ref,
  );

  final Ref ref;

  Future<ApiResponse> updateList(
    FacultyUser faculty,
    int oldIndex,
    int newIndex,
  ) async {
    final list = [...state[faculty]!];
    list.insert(
      newIndex,
      list.removeAt(oldIndex),
    );

    final results = await updateMatchedData(
      ref,
      {
        faculty.onyen: list.map((e) => e.onyen).toList(),
      },
    );

    if (results.success) {
      state[faculty]!.insert(
        newIndex,
        state[faculty]!.removeAt(oldIndex),
      );
    }
    state = {...state};
    return results;
  }

  Future<ApiResponse> addToNewList(
    FacultyUser oldFaculty,
    FacultyUser newFaculty,
    int oldPosition,
    int newPosition,
  ) async {
    final oldFac = [...state[oldFaculty]!];
    final newFac = [...state[newFaculty]!];
    final student = oldFac.removeAt(oldPosition);
    newFac.insert(newPosition, student);

    final results = await updateMatchedData(
      ref,
      {
        oldFaculty.onyen: oldFac.map((e) => e.onyen).toList(),
        newFaculty.onyen: newFac.map((e) => e.onyen).toList(),
      },
    );

    if (results.success) {
      state[oldFaculty]!.remove(student);
      state[newFaculty]!.insert(newPosition, student);
    }

    state = {...state};
    return results;
  }

  Map<String, List<String>> get downloadableData => state
      .map((k, v) => MapEntry(k.fullName, v.map((e) => e.fullName).toList()));

  set map(Map<FacultyUser, List<StudentUser>> matched) => state = matched;

  Map<FacultyUser, List<StudentUser>> get map => state;
}

class SortedNotifier extends StateNotifier<Map<String, List<StudentUser>>> {
  SortedNotifier(
    super.state,
    this.ref,
  );

  final Ref ref;

  void updateList(
    String key,
    int oldIndex,
    int newIndex,
  ) {
    state[key]!.insert(
      newIndex,
      state[key]!.removeAt(oldIndex),
    );
    state = {...state};
  }

  void addToNewList(
    String oldKey,
    String newKey,
    int oldPosition,
    int newPosition,
  ) {
    final student = state[oldKey]!.removeAt(oldPosition);
    state[newKey]!.insert(newPosition, student);
    state = {...state};
  }

  Future<ApiResponse> saveList() async {
    final results = await updateSortedData(state, ref);
    return results;
  }

  set map(Map<String, List<StudentUser>> sorted) => state = sorted;

  Map<String, List<StudentUser>> get map => state;
}
