import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:matchwise/core/utilities/extensions.dart';
import 'package:matchwise/core/utilities/utils.dart';
import 'package:matchwise/providers/ui_provider.dart';
import 'package:matchwise/providers/user_provider.dart';

import '../widgets/nav_column.dart';
import '../widgets/profile_clickable_icons.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                Expanded(
                  child: Consumer(
                    builder: (ctx, ref, _) {
                      final index = ref.watch(navIndexProvider);
                      final user = ref.read(userProvider);
                      return AnimatedSwitcher(
                        duration: 500.milliseconds,
                        child: buildScreen(index, user),
                      );
                    },
                  ),
                ),
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
