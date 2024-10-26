import 'package:flutter/material.dart';
import 'package:matchwise/core/utilities/extensions.dart';
import 'package:matchwise/widgets/nav_column.dart';
import 'package:matchwise/widgets/profile_clickable_icons.dart';

class ScreenBaseTemplate extends StatelessWidget {
  const ScreenBaseTemplate({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: context.height,
            width: context.width,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const NavigationColumn(),
                child,
              ],
            ),
          ),
          const Align(
            alignment: Alignment.topRight,
            child: ProfileClickableIcon(),
          ),
        ],
      ),
    );
  }
}
