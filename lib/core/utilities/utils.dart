import 'dart:developer';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fuzzy/fuzzy.dart';
import 'package:matchwise/core/models/api_response.dart';
import 'package:matchwise/core/models/faculty_user.dart';
import 'package:matchwise/core/models/matchwise_user.dart';
import 'package:matchwise/core/utilities/extensions.dart';
import 'package:matchwise/core/utilities/firestore_utils.dart';
import 'package:matchwise/firebase_options.dart';
import 'package:matchwise/pages/admin/add_faculty_page.dart';
import 'package:matchwise/pages/admin/dashboard_page.dart';
import 'package:matchwise/pages/admin/edit_dates_page.dart';
import 'package:matchwise/pages/admin/force_match_page.dart';
import 'package:matchwise/pages/faculty/add_question_page.dart';
import 'package:matchwise/pages/faculty/dashboard_page.dart';
import 'package:matchwise/pages/faculty/edit_preferences_page.dart';
import 'package:matchwise/pages/important_dates_page.dart';
import 'package:matchwise/pages/profile_page.dart';
import 'package:matchwise/pages/student/form_page.dart';
import 'package:matchwise/providers/common_providers.dart';
import 'package:matchwise/screens/home_screen.dart';
import 'package:matchwise/screens/login_screen.dart';
import 'package:package_info_plus/package_info_plus.dart';

Future<Widget> initApp(Ref ref, BuildContext context) async {
  await initFirebase();
  await setAppVersion(ref);
  await getMatchingCollection(ref);
  final fireUser = FirebaseAuth.instance.currentUser;
  if (fireUser != null) {
    await initData(ref);
    return const HomeScreen();
  } else {
    return const LoginScreen();
  }
}

Future<void> initData(Ref ref) async {
  final fireUser = FirebaseAuth.instance.currentUser!;
  final user = (await getUserData(ref, fireUser.email!.onyen))!;
  switch (user.type) {
    case UserType.admin:
      await getFaculty(ref, admin: true);
      await getStudents(ref);
      await getMatchedData(ref);
    case UserType.student:
      await getFaculty(ref);
    case UserType.faculty:
      await getStudents(ref);
      await getSortedData(ref);
  }
  await getImportantDates(ref);
}

Future<void> setAppVersion(Ref ref) async {
  final platform = await PackageInfo.fromPlatform();
  ref.read(versionProvider.notifier).update((_) => 'v${platform.version}');
}

Future<void> initFirebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // await FirebaseAuth.instance.signOut();
}

Future<ApiResponse> autofillFacultyForm(String onyen) async {
  try {
    final response =
        await FirebaseFunctions.instance.httpsCallable('proxy_cors').call({
      "url": "https://dir.unc.edu/api/search/$onyen",
    });
    if ((response.data as List).isEmpty) {
      return const ApiResponse();
    }
    final data = response.data[0];
    return ApiResponse(
      success: true,
      args: {
        'faculty': FacultyUser(
          onyen: onyen,
          firstName: data['givenNameIterator'][0] ?? '',
          lastName: data['snIterator'][0] ?? '',
          email: data['mailIterator'][0]?.replaceAll(
                'unc.edu',
                'cs.unc.edu',
              ) ??
              '',
        )
      },
    );
  } catch (e) {
    log('Error @ Auto Fetch $e');
  }

  return const ApiResponse();
}

Future<ApiResponse> autofillData(
  String onyen,
) async {
  try {
    final response =
        await FirebaseFunctions.instance.httpsCallable('proxy_cors').call({
          "url": "https://dir.unc.edu/api/search/$onyen",
        });
    if ((response.data as List).isEmpty) {
      return const ApiResponse();
    }
    final data = response.data[0];
    return ApiResponse(
      success: true,
      args: {
        'data': MatchWiseUser(
          onyen: onyen,
          firstName: data['givenNameIterator'][0] ?? '',
          lastName: data['snIterator'][0] ?? '',
          email: data['mailIterator'][0]?.replaceAll(
                'unc.edu',
                'cs.unc.edu',
              ) ??
              '',
          type: UserType.student,
          active: true,
        ),
      },
    );
  } catch (e) {
    log('Error @ Auto Fetch $e');
  }

  return const ApiResponse();
}

Widget buildScreen(int index, MatchWiseUser user) {
  if (index == 10) {
    return const ProfilePage();
  }
  switch (user.type) {
    case UserType.admin:
      switch (index) {
        case 0:
          return const AdminDashboard();
        case 1:
          return const ForceMatchPage();
        case 2:
          return const AddFacultyPage();
        case 3:
          return const EditTimelinePage();
      }
      break;
    case UserType.student:
      switch (index) {
        // case 0:
        //   return const StudentDashboard();
        case 0:
          return const ImportantDatesPage();
        case 1:
          return const StudentFormPage();
      }
      break;
    case UserType.faculty:
      switch (index) {
        case 0:
          return const FacultyDashboardPage();
        case 1:
          return const ImportantDatesPage();
        case 2:
          return const EditPreferencesPage();
        case 3:
          return const AddQuestionPage();
      }
      break;
  }

  return const FacultyDashboardPage();
}

PageRouteBuilder pageRouteBuilder(
  Widget page,
) =>
    PageRouteBuilder(
      pageBuilder: (_, __, ___) => page,
      transitionsBuilder: (_, animation, __, child) => FadeTransition(
        opacity: animation.drive(
          Tween<double>(begin: 0, end: 1).chain(
            CurveTween(
              curve: Curves.easeInOut,
            ),
          ),
        ),
        child: child,
      ),
      transitionDuration: 600.milliseconds,
      reverseTransitionDuration: 600.milliseconds,
    );

void navigateTo(
  BuildContext context,
  Widget page,
) =>
    Navigator.push(
      context,
      pageRouteBuilder(page),
    );

void navigateOffAll(
  BuildContext context,
  Widget page,
) =>
    Navigator.pushAndRemoveUntil(
      context,
      pageRouteBuilder(page),
      (_) => false,
    );

void navigateOff(
  BuildContext context,
  Widget page,
) =>
    Navigator.pushReplacement(
      context,
      pageRouteBuilder(page),
    );

List<DropdownMenuEntry<T>> fuzzySearchDropDown<T>(
  List<DropdownMenuEntry<T>> list,
  String query,
) {
  final search = Fuzzy(list.map((ele) => ele.label).toList())
      .search(query)
      .map((ele) => ele.item)
      .toList();
  return list.where((ele) => search.contains(ele.label)).toList();
}

List<String> fuzzySearch(
  List<String> list,
  String query,
) {
  return Fuzzy(list).search(query).map((e) => e.item).toList();
}
