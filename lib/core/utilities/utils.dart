import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:matchwise/core/models/matchwise_user.dart';
import 'package:matchwise/core/utilities/extensions.dart';
import 'package:matchwise/firebase_options.dart';
import 'package:matchwise/pages/admin/add_faculty_page.dart';
import 'package:matchwise/pages/admin/dashboard_page.dart';
import 'package:matchwise/pages/admin/edit_dates_page.dart';
import 'package:matchwise/pages/admin/force_match_page.dart';
import 'package:matchwise/pages/faculty/add_question_page.dart';
import 'package:matchwise/pages/faculty/dashboard_page.dart';
import 'package:matchwise/pages/faculty/edit_preferences_page.dart';
import 'package:matchwise/pages/faculty/important_dates_page.dart';
import 'package:matchwise/pages/student/dashboard_page.dart';
import 'package:matchwise/pages/student/form_page.dart';
import 'package:matchwise/pages/student/important_dates_page.dart';
import 'package:matchwise/providers/common_providers.dart';
import 'package:package_info_plus/package_info_plus.dart';

Future<void> initApp(Ref ref, BuildContext context) async {
  await initFirebase();
  await setAppVersion(ref);
}

Future<void> setAppVersion(Ref ref) async {
  final platform = await PackageInfo.fromPlatform();
  ref.read(versionProvider.notifier).update((_) => 'v${platform.version}');
}

Future<void> initFirebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

Widget buildScreen(int index, MatchWiseUser user) {
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
        case 0:
          return const StudentDashboard();
        case 1:
          return const StudentImportantDatesPage();
        case 2:
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

bool checkEmail(String? email) {
  final RegExp regex = RegExp(r'^[a-z0-9.+]*@cs\.unc\.edu$');
  return regex.hasMatch(email ?? '');
}
