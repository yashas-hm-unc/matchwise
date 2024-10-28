import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:matchwise/core/constants/app_colors.dart';
import 'package:matchwise/core/constants/app_constants.dart';
import 'package:matchwise/core/models/matchwise_user.dart';
import 'package:matchwise/core/utilities/extensions.dart';
import 'package:matchwise/providers/common_providers.dart';
import 'package:matchwise/providers/ui_provider.dart';
import 'package:matchwise/providers/user_provider.dart';
import 'package:resize/resize.dart';

class NavigationColumn extends ConsumerStatefulWidget {
  const NavigationColumn({super.key});

  @override
  ConsumerState<NavigationColumn> createState() => _NavigationColumnState();
}

class _NavigationColumnState extends ConsumerState<NavigationColumn>
    with SingleTickerProviderStateMixin {
  late final AnimationController animationController;

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: 300.milliseconds,
      reverseDuration: 300.milliseconds,
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.read(userProvider);
    final collapsed = ref.watch(collapsedProvider);

    return AnimatedContainer(
      duration: 500.milliseconds,
      height: context.height,
      width: collapsed ? context.width / 20 : context.width / 5,
      color: carolinaBlue.withOpacity(0.2),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            padding: EdgeInsets.all(collapsed ? 10.sp : 15.sp),
            alignment: Alignment.centerRight,
            child: InkWell(
              splashColor: carolinaBlue,
              highlightColor: carolinaBlue,
              customBorder: const CircleBorder(),
              onTap: () => setState(() {
                if (!collapsed) {
                  animationController.forward();
                } else {
                  animationController.reverse();
                }
                ref.read(collapsedProvider.notifier).update((_) => !collapsed);
              }),
              child: Container(
                width: context.width / 35,
                height: context.width / 35,
                padding: EdgeInsets.all(10.sp),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: RotationTransition(
                  turns: Tween<double>(begin: 0, end: 0.5).animate(
                    CurvedAnimation(
                      parent: animationController,
                      curve: Curves.linear,
                    ),
                  ),
                  child: SvgPicture.asset(
                    backAsset,
                    fit: BoxFit.contain,
                    colorFilter: const ColorFilter.mode(
                      black,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Gap(context.width / 10),
          Expanded(
            child: Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: collapsed ? 10.sp : 15.sp),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: navItems(user),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: black,
                  width: 1.sp,
                ),
              ),
            ),
            padding: EdgeInsets.all(collapsed ? 10.sp : 15.sp),
            alignment: Alignment.center,
            child: RichText(
              text: TextSpan(
                children: [
                  if (!collapsed)
                    TextSpan(
                      text: appName,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: black,
                        fontSize: 23.sp,
                      ),
                    ),
                  TextSpan(
                    text: ' ${ref.read(versionProvider)}',
                    style: TextStyle(
                      color: black,
                      fontWeight: FontWeight.w300,
                      fontSize: 20.sp,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> navItems(MatchWiseUser user) {
    final List<Widget> children = <Widget>[];

    switch (user.type) {
      case UserType.admin:
        for (int index = 0; index < adminNavigation.length; index++) {
          children.add(
            NavItem(
              itemName: adminNavigation[index],
              index: index,
              icon: adminNavIcons[index],
              animationController: animationController,
            ),
          );
          children.add(Gap(10.sp));
        }
      case UserType.student:
        for (int index = 0; index < studentNavigation.length; index++) {
          children.add(
            NavItem(
              itemName: studentNavigation[index],
              index: index,
              icon: studentNavIcons[index],
              animationController: animationController,
            ),
          );
          children.add(Gap(10.sp));
        }
      case UserType.faculty:
        for (int index = 0; index < facultyNavigation.length; index++) {
          children.add(
            NavItem(
              itemName: facultyNavigation[index],
              index: index,
              icon: facultyNavIcons[index],
              animationController: animationController,
            ),
          );
          children.add(Gap(10.sp));
        }
    }

    return children;
  }
}

class NavItem extends ConsumerWidget {
  const NavItem({
    super.key,
    required this.itemName,
    required this.index,
    required this.icon,
    required this.animationController,
  });

  final String itemName;

  final int index;

  final String icon;

  final AnimationController animationController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(navIndexProvider);
    final collapsed = ref.watch(collapsedProvider);

    return AnimatedSwitcher(
      duration: 500.milliseconds,
      transitionBuilder: (child, animation) => ScaleTransition(
        scale: animation,
        child: child,
      ),
      child: collapsed
          ? Material(
              key: const Key('1'),
              color: selectedIndex == index ? carolinaBlue : Colors.transparent,
              borderRadius: BorderRadius.circular(200.sp),
              child: InkWell(
                borderRadius: BorderRadius.circular(200.sp),
                highlightColor: carolinaBlue,
                splashColor: carolinaBlue,
                onTap: selectedIndex == index
                    ? () {}
                    : () => ref
                        .read(navIndexProvider.notifier)
                        .update((_) => index),
                child: Container(
                  constraints: BoxConstraints(
                    maxHeight: context.width / 30,
                  ),
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(10.sp),
                  width: double.infinity,
                  child: SvgPicture.asset(
                    icon,
                    fit: BoxFit.contain,
                    height: (context.width / 20) / 3,
                    colorFilter: ColorFilter.mode(
                      selectedIndex == index ? white : black,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
            )
          : Material(
              key: const Key('2'),
              borderRadius: BorderRadius.circular(10.sp),
              color: selectedIndex == index ? carolinaBlue : Colors.transparent,
              child: InkWell(
                highlightColor: carolinaBlue,
                splashColor: carolinaBlue,
                onTap: selectedIndex == index
                    ? () {}
                    : () => ref
                        .read(navIndexProvider.notifier)
                        .update((_) => index),
                borderRadius: BorderRadius.circular(10.sp),
                child: Container(
                  constraints: BoxConstraints(
                    maxHeight: context.width / 30,
                  ),
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.all(10.sp),
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SvgPicture.asset(
                        icon,
                        height: (context.width / 20) / 3,
                        fit: BoxFit.contain,
                        colorFilter: ColorFilter.mode(
                          selectedIndex == index ? white : black,
                          BlendMode.srcIn,
                        ),
                      ),
                      Gap(15.sp),
                      Flexible(
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            itemName,
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w500,
                              color: selectedIndex == index ? white : black,
                            ),
                            overflow: TextOverflow.clip,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
