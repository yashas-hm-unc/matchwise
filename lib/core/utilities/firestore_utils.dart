import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:matchwise/core/constants/app_constants.dart';
import 'package:matchwise/core/models/api_response.dart';
import 'package:matchwise/core/models/faculty_user.dart';
import 'package:matchwise/core/models/important_date.dart';
import 'package:matchwise/core/models/matchwise_user.dart';
import 'package:matchwise/core/models/student_user.dart';
import 'package:matchwise/core/utilities/utils.dart';
import 'package:matchwise/providers/common_providers.dart';
import 'package:matchwise/providers/date_provider.dart';
import 'package:matchwise/providers/faculty_provider.dart';
import 'package:matchwise/providers/match_provider.dart';
import 'package:matchwise/providers/student_provider.dart';
import 'package:matchwise/providers/user_provider.dart';

Future<void> getMatchingCollection(Ref ref) async {
  dynamic firestore = FirebaseFirestore.instance;
  final result = await firestore
      .collection(metadataFirestore)
      .doc(metadataFirestore)
      .get();

  ref.read(matchingCollectionProvider.notifier).update(
        (_) => (result.data()!['current_matching'] as String),
      );
}

Future<void> getFaculty(Ref ref) async {
  dynamic firestore = FirebaseFirestore.instance;
  if (kDebugMode) {
    firestore = firestore.collection('dev').doc('dev');
  }

  final result = await firestore
      .collection(userCollection)
      .where(
        'active',
        isEqualTo: true,
      )
      .where(
        'type',
        isEqualTo: UserType.faculty.toString(),
      )
      .get();

  final List<FacultyUser> facultyUsers = [];
  for (var snapshot in result.docs) {
    facultyUsers.add(
      FacultyUser.fromJson(
        snapshot.data(),
      ),
    );
  }
  ref.read(facultyProvider.notifier).list = facultyUsers;
}

Future<void> getStudents(Ref ref) async {
  dynamic firestore = FirebaseFirestore.instance;
  if (kDebugMode) {
    firestore = firestore.collection('dev').doc('dev');
  }

  final result = await firestore
      .collection(userCollection)
      .where(
        'active',
        isEqualTo: true,
      )
      .where(
        'type',
        isEqualTo: UserType.student.toString(),
      )
      .get();

  final List<StudentUser> studentUsers = [];
  for (var snapshot in result.docs) {
    studentUsers.add(
      StudentUser.fromJson(
        snapshot.data(),
      ),
    );
  }
  ref.read(studentProvider.notifier).list = studentUsers;
}

Future<void> getSortedData(Ref ref) async {
  dynamic firestore = FirebaseFirestore.instance;
  if (kDebugMode) {
    firestore = firestore.collection('dev').doc('dev');
  }
  final matchDocument = ref.read(matchingCollectionProvider);
  final FacultyUser user = ref.read(userProvider) as FacultyUser;
  final results = await firestore
      .collection(matchCollection)
      .doc(matchDocument)
      .collection(sortedCollection)
      .doc(user.onyen)
      .get();
  final students = ref.read(studentProvider);
  final sorted = <String, List<StudentUser>>{};
  for (String key in keys) {
    final List<String> onyens =
        (results.data()?[key] as List?)?.map((e) => e.toString()).toList() ??
            <String>[];
    sorted[key] = onyens
        .map((onyen) => students.firstWhere((e) => e.onyen == onyen))
        .toList();
  }
  ref.read(sortedProvider.notifier).map = sorted;
}

Future<void> getMatchedData(Ref ref) async {
  dynamic firestore = FirebaseFirestore.instance;
  if (kDebugMode) {
    firestore = firestore.collection('dev').doc('dev');
  }
  final matchDocument = ref.read(matchingCollectionProvider);
  final results = await firestore
      .collection(matchCollection)
      .doc(matchDocument)
      .collection(matchesCollection)
      .get();
  final faculty = ref.read(facultyProvider);
  final students = ref.read(studentProvider);

  final matches = <FacultyUser, List<StudentUser>>{};

  for (var document in results.docs) {
    final facultyUser = faculty.firstWhere((e) => e.onyen == document.id);
    final List<String> studentOnyens = (document.data()['matches'] as List?)
            ?.map((e) => e.toString())
            .toList() ??
        <String>[];
    final studentData = studentOnyens
        .map((onyen) => students.firstWhere((e) => e.onyen == onyen))
        .toList();

    matches[facultyUser] = studentData;
  }

  ref.read(matchedProvider.notifier).map = matches;
}

Future<MatchWiseUser?> getUserData(
  Ref ref,
  String onyen,
) async {
  dynamic firestore = FirebaseFirestore.instance;
  if (kDebugMode) {
    firestore = firestore.collection('dev').doc('dev');
  }
  final results = await firestore.collection(userCollection).doc(onyen).get();
  if (results.exists && results.data() != null) {
    MatchWiseUser user;
    switch (UserType.fromString(results.data()?['type'])) {
      case UserType.admin:
        user = MatchWiseUser.fromJson(results.data()!);
        break;
      case UserType.student:
        user = StudentUser.fromJson(results.data()!);
        break;
      case UserType.faculty:
        user = FacultyUser.fromJson(results.data()!);
        break;
    }
    ref.read(userProvider.notifier).user = user;
    return user;
  } else {
    final results = await autofillData(onyen);
    if (results.success) {
      final user =
          StudentUser.fromParent(results.args!['data'] as MatchWiseUser);
      await firestore.collection(userCollection).doc(onyen).set(user.toJson());
      ref.read(userProvider.notifier).user = user;
      return user;
    }
  }
  return null;
}

Future<void> getImportantDates(Ref ref) async {
  dynamic firestore = FirebaseFirestore.instance;
  if (kDebugMode) {
    firestore = firestore.collection('dev').doc('dev');
  }
  final match = ref.read(matchingCollectionProvider);
  final results = await firestore
      .collection(matchCollection)
      .doc(match)
      .collection(impDatesCollection)
      .get();
  final impDates = <ImportantDate>[];
  for (var doc in results.docs) {
    impDates.add(ImportantDate.fromJson(doc.data()));
  }
  impDates.sort((a, b) => a.date.compareTo(b.date));
  ref.read(dateProvider.notifier).dates = impDates;
}

Future<ApiResponse> updateProfile(
  MatchWiseUser user,
) async {
  try {
    dynamic firestore = FirebaseFirestore.instance;

    if (kDebugMode) {
      firestore = firestore.collection('dev').doc('dev');
    }

    await firestore
        .collection(userCollection)
        .doc(user.onyen)
        .set(user.toJson());
    return const ApiResponse(success: true);
  } catch (e, s) {
    log(
      'Error @ Update Faculty Pref',
      error: e,
      stackTrace: s,
    );
  }

  return const ApiResponse();
}

Future<ApiResponse> updateSortedData(
  Map<String, List<StudentUser>> map,
  Ref ref,
) async {
  try {
    dynamic firestore = FirebaseFirestore.instance;

    if (kDebugMode) {
      firestore = firestore.collection('dev').doc('dev');
    }
    final matchField = ref.read(matchingCollectionProvider);
    final onyen = ref.read(userProvider).onyen;

    Map<String, List<String>> sortedMap = {};

    for (var key in map.keys) {
      sortedMap[key] = map[key]!.map((e) => e.onyen).toList();
    }

    await firestore
        .collection(matchCollection)
        .doc(matchField)
        .collection(sortedCollection)
        .doc(onyen)
        .set(sortedMap);

    return const ApiResponse(success: true);
  } catch (e, s) {
    log(
      'Error @ Updating sorted list',
      error: e,
      stackTrace: s,
    );
  }
  return const ApiResponse();
}
