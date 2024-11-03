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
  
  Future<void> addToList(FacultyUser user) async{
    //TODO: Add to firestore
    state.add(user);
    state.sort((ob1, ob2)=>ob1.firstName.compareTo(ob2.firstName));
    state = [...state];
  }
  
  Future<void> updateList(FacultyUser user) async {
    //TODO: Update on firestore
    state.removeWhere((obj)=>obj.id==user.id);
    state.add(user);
    state.sort((ob1, ob2)=>ob1.firstName.compareTo(ob2.firstName));
    state = [...state];
  }
  
  Future<void> removeFromList(FacultyUser user) async {
    state.removeWhere((obj)=>obj.id==user.id);
    state = [...state];
    //TODO: Remove from firestore
  }
}
