import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:matchwise/core/constants/app_constants.dart';
import 'package:matchwise/core/models/matchwise_user.dart';

final StateNotifierProvider<UserNotifier, MatchWiseUser> userProvider =
    StateNotifierProvider(
  (ref) => UserNotifier(
    MatchWiseUser(
      id: kEmptyString,
      firstName: kEmptyString,
      lastName: kEmptyString,
      pid: kEmptyString,
      email: kEmptyString,
      type: UserType.admin,
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
}
