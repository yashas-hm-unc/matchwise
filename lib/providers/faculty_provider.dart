import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:matchwise/core/error/fallback_objects.dart';
import 'package:matchwise/core/models/api_response.dart';
import 'package:matchwise/core/models/faculty_user.dart';
import 'package:matchwise/core/utilities/firestore_utils.dart';

final StateNotifierProvider<FacultyNotifier, List<FacultyUser>>
    facultyProvider = StateNotifierProvider(
  (_) => FacultyNotifier(
    // TODO: Replace with empty array
    facultyFallback,
  ),
);

class FacultyNotifier extends StateNotifier<List<FacultyUser>> {
  FacultyNotifier(super.state);

  Future<ApiResponse> addToList(FacultyUser user) async {
    final result = await updateFaculty(user);

    if (result.success) {
      state.add(user);
      state.sort((ob1, ob2) => ob1.firstName.compareTo(ob2.firstName));
      state = [...state];
    }

    return result;
  }

  Future<ApiResponse> updateList(FacultyUser user) async {
    final result = await updateFaculty(user);

    if (result.success) {
      state.removeWhere((obj) => obj.onyen == user.onyen);
      state.add(user);
      state.sort((ob1, ob2) => ob1.firstName.compareTo(ob2.firstName));
      state = [...state];
    }

    return result;
  }

  Future<ApiResponse> removeFromList(FacultyUser user) async {
    final results = await deleteFaculty(user);

    if (results.success) {
      state.removeWhere((obj) => obj.onyen == user.onyen);
      state = [...state];
    }

    return results;
  }

  List<String> getResearchInterests() {
    final list = <String>[];
    for (var i in state) {
      list.addAll(i.researchInterests.where((ele) => !list.contains(ele)));
    }
    return list;
  }

  List<String> getCourses() {
    final list = <String>[];
    for (var i in state) {
      list.addAll(i.courses.where((ele) => !list.contains(ele)));
    }
    return list;
  }

  List<String> getProfessors() {
    final list = <String>[];
    for (var i in state) {
      list.add('${i.firstName} ${i.lastName}');
    }
    return list;
  }

  List<Map<String, String>> getProfessorsMap() {
    final list = <Map<String, String>>[];
    for (var i in state) {
      list.add({
        'name': '${i.firstName} ${i.lastName}',
        'onyen': i.onyen,
      });
    }
    return list;
  }

  List<Map<String, String>> getProfMapFromOnyens(List<String> onyens) {
    return state
        .where((ele) => onyens.contains(ele.onyen))
        .map((ele) => {
              'name': '${ele.firstName} ${ele.lastName}',
              'onyen': ele.onyen,
            })
        .toList();
  }

  set list(List<FacultyUser> users) => state = users;

  List<FacultyUser> get list => state;
}
