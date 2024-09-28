
import 'package:flutter/material.dart';
import 'package:matchwise/core/utilities/extensions.dart';
import 'package:matchwise/pages/home.dart';

PageRouteBuilder pageRouteBuilder(
    Widget page,
    RouteSettings settings,
    ) =>
    PageRouteBuilder(
      settings: settings,
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


Route<dynamic> routeBuilder(RouteSettings settings) {
  switch (settings.name) {
    default:
      return pageRouteBuilder(const Home(), settings);   
  }
}
