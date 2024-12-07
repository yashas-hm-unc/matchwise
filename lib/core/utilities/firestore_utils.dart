import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
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
  final firestore = FirebaseFirestore.instance;
  final result = await firestore
      .collection(metadataFirestore)
      .doc(metadataFirestore)
      .get();

  ref.read(currMatchProvider.notifier).update(
        (_) => (result.data()!['current_matching'] as String),
      );
  ref.read(prevMatchProvider.notifier).update(
        (_) => (result.data()!['previous_matching'] as List)
            .map((e) => e.toString())
            .toList(),
      );
}

//INFO: Faculty
Future<void> getFaculty(
  Ref ref, {
  bool admin = false,
}) async {
  final firestore = FirebaseFirestore.instance;

  QuerySnapshot<Map<String, dynamic>> result;

  if (admin) {
    result = await firestore
        .collection(userCollection)
        .where(
          'type',
          isEqualTo: UserType.faculty.toString(),
        )
        .get();
  } else {
    result = await firestore
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
  }

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

Future<ApiResponse> updateFaculty(FacultyUser user) async {
  try {
    final firestore = FirebaseFirestore.instance;

    await firestore
        .collection(userCollection)
        .doc(user.onyen)
        .set(user.toJson());

    return const ApiResponse(success: true);
  } catch (e, s) {
    log(
      'Error @ Updating Faculty',
      error: e,
      stackTrace: s,
    );
  }

  return const ApiResponse();
}

Future<ApiResponse> deleteFaculty(FacultyUser user) async {
  try {
    final firestore = FirebaseFirestore.instance;
    await firestore.collection(userCollection).doc(user.onyen).delete();

    return const ApiResponse(success: true);
  } catch (e, s) {
    log(
      'Error @ Updating Faculty',
      error: e,
      stackTrace: s,
    );
  }

  return const ApiResponse();
}

// INFO: Students
Future<void> getStudents(Ref ref) async {
  final firestore = FirebaseFirestore.instance;

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

// INFO: Match
Future<void> getMatchedData(Ref ref) async {
  final firestore = FirebaseFirestore.instance;
  final matchDocument = ref.read(currMatchProvider);
  final results =
      await firestore.collection(matchCollection).doc(matchDocument).get();
  final faculty = ref.read(facultyProvider);
  final students = ref.read(studentProvider);
  final matches = <FacultyUser, List<StudentUser>>{};
  final data = results.data();

  for (String key in results.data()?.keys ?? []) {
    final facultyUser = faculty.firstWhere((e) => e.onyen == key);
    final List<String> studentOnyens =
        (data![key] as List?)?.map((e) => e.toString()).toList() ?? <String>[];
    final studentData = studentOnyens
        .map((onyen) => students.firstWhere((e) => e.onyen == onyen))
        .toList();

    matches[facultyUser] = studentData;
  }
  ref.read(matchedProvider.notifier).map = matches;
}

Future<ApiResponse> updateMatchedData(
  Ref ref,
  Map<String, List<String>> updateMap,
) async {
  try {
    final firestore = FirebaseFirestore.instance;
    final matchDocument = ref.read(currMatchProvider);
    await firestore
        .collection(matchCollection)
        .doc(matchDocument)
        .update(updateMap);

    return const ApiResponse(
      success: true,
    );
  } catch (e, s) {
    log(
      'Error @ Force Match Update',
      error: e,
      stackTrace: s,
    );
  }

  return const ApiResponse();
}

// INFO: Important Dates
Future<void> getImportantDates(Ref ref) async {
  final firestore = FirebaseFirestore.instance;
  final match = ref.read(currMatchProvider);
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

Future<ApiResponse> updateDate(
  ImportantDate date,
  Ref ref,
) async {
  try {
    final firestore = FirebaseFirestore.instance;
    final matchField = ref.read(currMatchProvider);
    await firestore
        .collection(matchCollection)
        .doc(matchField)
        .collection(impDatesCollection)
        .doc(date.id)
        .set(date.toJson());

    return const ApiResponse(success: true);
  } catch (e, s) {
    log(
      'Error @ Updating Important Dates',
      error: e,
      stackTrace: s,
    );
  }
  return const ApiResponse();
}

Future<ApiResponse> deleteDate(
  ImportantDate date,
  Ref ref,
) async {
  try {
    final firestore = FirebaseFirestore.instance;
    final matchField = ref.read(currMatchProvider);
    await firestore
        .collection(matchCollection)
        .doc(matchField)
        .collection(impDatesCollection)
        .doc(date.id)
        .delete();

    return const ApiResponse(success: true);
  } catch (e, s) {
    log(
      'Error @ Deleting Important Dates',
      error: e,
      stackTrace: s,
    );
  }
  return const ApiResponse();
}

// INFO: User Related
Future<MatchWiseUser?> getUserData(
  Ref ref,
  String onyen,
) async {
  final firestore = FirebaseFirestore.instance;
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

Future<ApiResponse> updateProfile(
  MatchWiseUser user,
) async {
  try {
    final firestore = FirebaseFirestore.instance;

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

// INFO: Sorted data
Future<ApiResponse> updateSortedData(
  Map<String, List<StudentUser>> map,
  Ref ref,
) async {
  try {
    final firestore = FirebaseFirestore.instance;
    final matchField = ref.read(currMatchProvider);
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

Future<ApiResponse> getAllSortedData(WidgetRef ref) async {
  try {
    final firestore = FirebaseFirestore.instance;
    final matchDoc = ref.read(currMatchProvider);
    final data = await firestore
        .collection(matchCollection)
        .doc(matchDoc)
        .collection(sortedCollection)
        .get();
    if (data.docs.isNotEmpty) {
      String profByOnyen(String onyen) {
        return ref
            .read(facultyProvider)
            .firstWhere((e) => e.onyen == onyen)
            .fullName;
      }

      String studentByOnyen(String onyen) {
        return ref
            .read(studentProvider)
            .firstWhere((e) => e.onyen == onyen)
            .fullName;
      }

      Map<String, List<String>> sortedData = {};
      for (var doc in data.docs) {
        sortedData[profByOnyen(doc.id)] = (doc.data()['shortlisted'] as List)
            .map((e) => studentByOnyen(e.toString())).toList();
      }
      
      return ApiResponse(
        success: true,
        args: {
          'data': sortedData,
        },
      );
    } else {
      return const ApiResponse(
          success: false, message: 'No sorting data available');
    }
  } catch (e, s) {
    log(
      'Error @ Get all sorted data',
      error: e,
      stackTrace: s,
    );
  }

  return const ApiResponse();
}

Future<void> getSortedData(Ref ref) async {
  final firestore = FirebaseFirestore.instance;
  final matchDocument = ref.read(currMatchProvider);
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

Future<ApiResponse> createNewSession(
  String newMatching,
  WidgetRef ref,
) async {
  try {
    newMatching = newMatching.replaceAll(' ', '_').toLowerCase();
    final firestore = FirebaseFirestore.instance;
    final matchDoc = ref.read(currMatchProvider);
    final users = await firestore
        .collection(userCollection)
        .where('active', isEqualTo: true)
        .get();
    final batch = firestore.batch();

    for (var doc in users.docs) {
      batch.update(firestore.collection(userCollection).doc(doc.id), {
        'active': false,
      });
    }

    batch.update(
        firestore.collection(metadataFirestore).doc(metadataFirestore), {
      'current_matching': newMatching,
      'previous_matching': FieldValue.arrayUnion([matchDoc]),
    });

    await batch.commit();
    return const ApiResponse(success: true);
  } catch (e, s) {
    log(
      'Error @ Create new session',
      error: e,
      stackTrace: s,
    );
  }

  return const ApiResponse();
}
