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
}
