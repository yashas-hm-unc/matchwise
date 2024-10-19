import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:matchwise/core/constants/app_colors.dart';
import 'package:matchwise/core/constants/app_constants.dart';
import 'package:matchwise/core/utilities/auth_utils.dart';
import 'package:matchwise/core/utilities/extensions.dart';
import 'package:resize/resize.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: context.width * 0.4,
          height: context.height * 0.5,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(23.sp),
            color: carolinaBlue.withOpacity(0.5),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 60.sp,
            vertical: 30.sp,
          ),
          alignment: Alignment.center,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Hero(
                tag: heroTag,
                child: Container(
                  height: 80.sp,
                  width: 80.sp,
                  decoration: BoxDecoration(
                    color: carolinaBlue,
                    borderRadius: BorderRadius.circular(13.sp),
                  ),
                  padding: EdgeInsets.all(10.sp),
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
              Gap(10.sp),
              Text(
                appName,
                style: TextStyle(
                  fontSize: 25.sp,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      loginScreenText,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.sp,
                      ),
                    ),
                    Gap(40.sp),
                    Container(
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(13.sp),
                        color: white,
                        boxShadow: [
                          BoxShadow(
                            color: shadowColor,
                            blurRadius: 10.sp,
                            spreadRadius: 1.sp,
                          ),
                        ],
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: loading
                              ? null
                              : () async {
                                  setState(() => loading = true);
                                  await googleSignIn();
                                  setState(() => loading = false);
                                },
                          child: Container(
                            width: (context.width * 0.4) / 3,
                            height: 50.sp,
                            padding: EdgeInsets.symmetric(
                              horizontal: 10.sp,
                              vertical: 5.sp,
                            ),
                            child: AnimatedSwitcher(
                              duration: 800.milliseconds,
                              child: loading
                                  ? const CircularProgressIndicator(
                                      key: ValueKey(0),
                                      valueColor:
                                          AlwaysStoppedAnimation(carolinaBlue2),
                                    )
                                  : Row(
                                      key: const ValueKey(1),
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          loginScreenBtnText,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 20.sp,
                                            fontWeight: FontWeight.w800,
                                            color: black,
                                          ),
                                        ),
                                        Gap(10.sp),
                                        SvgPicture.asset(
                                          googleAsset,
                                          width: 30.sp,
                                          height: 30.sp,
                                          fit: BoxFit.contain,
                                        ),
                                      ],
                                    ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
