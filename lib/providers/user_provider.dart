import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:matchwise/core/constants/app_constants.dart';
import 'package:matchwise/core/models/api_response.dart';
import 'package:matchwise/core/models/matchwise_user.dart';
import 'package:matchwise/core/models/student_user.dart';
import 'package:matchwise/core/utilities/firestore_utils.dart';

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

  Future<ApiResponse> update(MatchWiseUser user) async {
    try {
      state = user;
      await updateProfile(user);
      return const ApiResponse(success: true);
    } catch (e, s) {
      log(
        'Error @ update profile',
        error: e,
        stackTrace: s,
      );
    }

    return const ApiResponse();
  }

  MatchWiseUser get user => state;

  set user(MatchWiseUser user) => state = user;
}
