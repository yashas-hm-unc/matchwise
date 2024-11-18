import 'package:flutter/material.dart';

extension NumUtils on num {
  num remap(num minExtent, num maxExtent, num minRange, num maxRange) {
    return (this - minExtent) /
            (maxExtent - minExtent) *
            (maxRange - minRange) +
        minRange;
  }

  Duration get milliseconds => Duration(microseconds: (this * 1000).round());

  Duration get seconds => Duration(milliseconds: (this * 1000).round());
}

extension StringUtils on String {
  bool get isEmail => RegExp(r'^[a-z0-9.+]*@cs\.unc\.edu$').hasMatch(this);

  String get onyen => replaceAll('@cs.unc.edu', '');
}

extension ContextUtils on BuildContext {
  bool get isMobile => height > width;

  double get height => MediaQuery.of(this).size.height;

  double get width => MediaQuery.of(this).size.width;

  Size get screenSize => MediaQuery.of(this).size;
}
