import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:matchwise/core/constants/app_constants.dart';
import 'package:matchwise/core/models/matchwise_user.dart';
import 'package:matchwise/core/models/student_user.dart';

final StateNotifierProvider<UserNotifier, MatchWiseUser> userProvider =
    StateNotifierProvider(
  (ref) => UserNotifier(
    StudentUser(
      firstName: kEmptyString,
      lastName: kEmptyString,
      onyen: kEmptyString,
      email: kEmptyString,
      type: UserType.student,
    ),
    ref,
  ),
);

class UserNotifier extends StateNotifier<MatchWiseUser> {
  UserNotifier(
    super.state,
    this.ref,
  );

  final Ref ref;

  void update(MatchWiseUser user) {
    // update on firestore
    state = user;
  }
}
