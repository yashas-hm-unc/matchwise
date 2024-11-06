import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:matchwise/core/constants/app_colors.dart';
import 'package:matchwise/core/constants/app_constants.dart';
import 'package:matchwise/core/utilities/extensions.dart';
import 'package:matchwise/core/utilities/utils.dart';
import 'package:matchwise/providers/ui_provider.dart';
import 'package:matchwise/screens/splash_screen.dart';
import 'package:resize/resize.dart';

class ProfileClickableIcon extends ConsumerWidget {
  const ProfileClickableIcon({super.key});

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    return Container(
      height: context.width / 30,
      width: context.width / 30,
      margin: EdgeInsets.all(15.sp),
      clipBehavior: Clip.hardEdge,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: carolinaBlue,
      ),
      child: PopupMenuButton(
        padding: EdgeInsets.zero,
        menuPadding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.sp),
        ),
        offset: Offset(
          -20.sp,
          -20.sp,
        ),
        icon: Container(),
        tooltip: 'Profile Menu',
        onSelected: (selected) =>
            ref.read(navIndexProvider.notifier).update((_) => selected),
        position: PopupMenuPosition.under,
        itemBuilder: (BuildContext context) => generateMenu(context),
      ),
    );
  }

  List<PopupMenuItem> generateMenu(BuildContext context) {
    final List<PopupMenuItem> list = [];
    final List<Function> functions = [
      () {},
      () {},
      () async {
        await FirebaseAuth.instance.signOut();
        if (context.mounted) {
          navigateOffAll(
            context,
            const SplashScreen(),
          );
        }
      },
    ];

    for (var i = 0; i < settingsPopup.length; i++) {
      list.add(
        PopupMenuItem(
          value: i + 10,
          child: Text(
            settingsPopup[i],
          ),
        ),
      );
    }

    return list;
  }
}
