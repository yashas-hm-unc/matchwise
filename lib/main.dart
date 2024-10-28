import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:matchwise/core/constants/app_theme.dart';
import 'package:matchwise/core/utilities/extensions.dart';
import 'package:matchwise/screens/splash_screen.dart';
import 'package:oktoast/oktoast.dart';
import 'package:resize/resize.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  usePathUrlStrategy();
  runApp(const ProviderScope(child: MatchWise()));
}

class MatchWise extends ConsumerWidget {
  const MatchWise({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size size;

    if (context.isMobile) {
      size = const Size(410, 910);
    } else {
      size = const Size(1728, 1000);
    }

    return Resize(
      builder: () => OKToast(
        child: MaterialApp(
          theme: lightTheme(context),
          debugShowCheckedModeBanner: false,
          title: 'MatchWise',
          home: const SplashScreen(),
        ),
      ),
      allowtextScaling: false,
      size: size,
    );
  }
}
