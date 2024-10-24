import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:matchwise/core/constants/app_colors.dart';
import 'package:matchwise/core/constants/app_constants.dart';
import 'package:matchwise/core/utilities/extensions.dart';
import 'package:matchwise/core/utilities/utils.dart';
import 'package:matchwise/providers/common_providers.dart';
import 'package:matchwise/screens/home_screen.dart';
import 'package:matchwise/screens/login_screen.dart';
import 'package:resize/resize.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController animationController;
  late final Animation<double> zoomAnimation;
  late final Animation<double> fadeAnimation;

  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: 1500.milliseconds,
    );

    zoomAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(
          0,
          0.7,
          curve: Curves.bounceOut,
        ),
      ),
    );

    fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(
          0.3,
          0.7,
          curve: Curves.easeIn,
        ),
      ),
    );

    animationController.addStatusListener((e) {
      if (e.isCompleted) {
        Future.delayed(
          500.milliseconds,
          // () => mounted ? navigateOffAll(context, const LoginScreen()) : null,
          () => mounted ? navigateOffAll(context, const HomeScreen()) : null,
        );
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ref.watch(initAppProvider(context)).when(
            data: (_) {
              animationController.forward();
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Hero(
                      tag: heroTag,
                      child: ScaleTransition(
                        scale: zoomAnimation,
                        child: Container(
                          height: context.width * 0.1,
                          width: context.width * 0.1,
                          decoration: BoxDecoration(
                            color: carolinaBlue,
                            borderRadius: BorderRadius.circular(23.sp),
                          ),
                          padding: EdgeInsets.all(15.sp),
                          child: SvgPicture.asset(
                            logoAsset,
                            width: double.infinity,
                            height: double.infinity,
                            fit: BoxFit.contain,
                            colorFilter: const ColorFilter.mode(
                              white,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Gap(15.sp),
                    FadeTransition(
                      opacity: fadeAnimation,
                      child: Text(
                        appName,
                        style: TextStyle(
                          fontSize: 40.sp,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
            error: (err, stacktrace) {
              //TODO: error screen
              log(
                'Error at Initialisation',
                error: err,
                stackTrace: stacktrace,
              );
              return Container();
            },
            loading: () => const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(
                  carolinaBlue2,
                ),
              ),
            ),
          ),
    );
  }
}
