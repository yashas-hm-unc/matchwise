import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:matchwise/core/error/fallback_objects.dart';
import 'package:matchwise/core/models/important_date.dart';

final StateNotifierProvider<DateNotifier, List<ImportantDate>> dateProvider =
    StateNotifierProvider(
  (ref) => DateNotifier(
    // TODO: Replace with empty list
    importantDatesFallback,
  ),
);

class DateNotifier extends StateNotifier<List<ImportantDate>> {
  DateNotifier(super.state);
  Future<void> addToList(ImportantDate user) async{
    //TODO: Add to firestore
    state.add(user);
    state.sort((ob1, ob2)=>ob1.date.compareTo(ob2.date));
    state = [...state];
  }

  Future<void> updateList(ImportantDate user) async {
    //TODO: Update on firestore
    state.removeWhere((obj)=>obj.id==user.id);
    state.add(user);
    state.sort((ob1, ob2)=>ob1.date.compareTo(ob2.date));
    state = [...state];
  }

  Future<void> removeFromList(ImportantDate user) async {
    state.removeWhere((obj)=>obj.id==user.id);
    state = [...state];
    //TODO: Remove from firestore
  }
  
}
