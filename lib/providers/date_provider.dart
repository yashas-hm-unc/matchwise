import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:matchwise/core/models/api_response.dart';
import 'package:matchwise/core/models/important_date.dart';
import 'package:matchwise/core/utilities/firestore_utils.dart';

final StateNotifierProvider<DateNotifier, List<ImportantDate>> dateProvider =
    StateNotifierProvider(
  (ref) => DateNotifier(
    [],
    ref,
  ),
);

class DateNotifier extends StateNotifier<List<ImportantDate>> {
  DateNotifier(
    super.state,
    this.ref,
  );

  final Ref ref;

  Future<ApiResponse> addToList(ImportantDate date) async {
    final result = await updateDate(date, ref);
    if (result.success) {
      state.add(date);
      state.sort((ob1, ob2) => ob1.date.compareTo(ob2.date));
      state = [...state];
    }
    return result;
  }

  Future<ApiResponse> updateInList(ImportantDate date) async {
    final result = await updateDate(date, ref);

    if (result.success) {
      state.removeWhere((obj) => obj.id == date.id);
      state.add(date);
      state.sort((ob1, ob2) => ob1.date.compareTo(ob2.date));
      state = [...state];
    }

    return result;
  }

  Future<ApiResponse> removeFromList(ImportantDate date) async {
    final result = await deleteDate(date, ref);

    if (result.success) {
      state.removeWhere((obj) => obj.id == date.id);
      state = [...state];
    }

    return result;
  }

  List<ImportantDate> get dates => state;

  set dates(List<ImportantDate> list) => state = list;
}
