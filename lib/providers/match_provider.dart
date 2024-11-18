import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:matchwise/core/models/api_response.dart';
import 'package:matchwise/core/models/faculty_user.dart';
import 'package:matchwise/core/models/student_user.dart';
import 'package:matchwise/core/utilities/firestore_utils.dart';

final StateNotifierProvider<MatchedNotifier,
        Map<FacultyUser, List<StudentUser>>> matchedProvider =
    StateNotifierProvider(
  (_) => MatchedNotifier(
    {},
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
  MatchedNotifier(super.state);

  void updateList(
    FacultyUser faculty,
    int oldIndex,
    int newIndex,
  ) {
    state[faculty]!.insert(
      newIndex,
      state[faculty]!.removeAt(oldIndex),
    );
    state = {...state};
  }

  void addToNewList(
    FacultyUser oldFaculty,
    FacultyUser newFaculty,
    int oldPosition,
    int newPosition,
  ) {
    final student = state[oldFaculty]!.removeAt(oldPosition);
    state[newFaculty]!.insert(newPosition, student);
    state = {...state};
  }

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
