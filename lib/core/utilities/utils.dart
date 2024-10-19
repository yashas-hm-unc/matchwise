import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:matchwise/core/utilities/extensions.dart';
import 'package:matchwise/firebase_options.dart';

Future<void> initApp(Ref ref, BuildContext context) async {
  await initFirebase();
}

Future<void> initFirebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

PageRouteBuilder pageRouteBuilder(
  Widget page,
) =>
    PageRouteBuilder(
      pageBuilder: (_, __, ___) => page,
      transitionsBuilder: (_, animation, __, child) => FadeTransition(
        opacity:
            animation.drive(Tween<double>(begin: 0, end: 1).chain(CurveTween(
          curve: Curves.easeInOut,
        ))),
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

bool checkEmail(String? email){
  final RegExp regex = RegExp(r'^[a-z0-9.+]*@cs\.unc\.edu$');  
  return regex.hasMatch(email??'');
}
