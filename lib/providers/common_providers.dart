import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:matchwise/core/utilities/utils.dart';

final initAppProvider = FutureProvider.family(
        (ref, BuildContext context) => initApp(ref, context));