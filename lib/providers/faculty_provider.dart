import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:matchwise/core/error/fallback_objects.dart';
import 'package:matchwise/core/models/faculty_user.dart';

final StateNotifierProvider<FacultyNotifier, List<FacultyUser>>
    facultyProvider = StateNotifierProvider(
  (_) => FacultyNotifier(
    // TODO: Replace with empty array
    facultyFallback,
  ),
);

class FacultyNotifier extends StateNotifier<List<FacultyUser>> {
  FacultyNotifier(super.state);

  Future<void> addToList(FacultyUser user) async {
    //TODO: Add to firestore
    state.add(user);
    state.sort((ob1, ob2) => ob1.firstName.compareTo(ob2.firstName));
    state = [...state];
  }

  Future<void> updateList(FacultyUser user) async {
    //TODO: Update on firestore
    state.removeWhere((obj) => obj.onyen == user.onyen);
    state.add(user);
    state.sort((ob1, ob2) => ob1.firstName.compareTo(ob2.firstName));
    state = [...state];
  }

  Future<void> removeFromList(FacultyUser user) async {
    state.removeWhere((obj) => obj.onyen == user.onyen);
    state = [...state];
    //TODO: Remove from firestore
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
  
  set list(List<FacultyUser> users) => state = users;
  
  List<FacultyUser> get list => state;
}
