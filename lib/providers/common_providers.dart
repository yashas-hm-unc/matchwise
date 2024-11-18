import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:matchwise/core/utilities/utils.dart';

final FutureProviderFamily<Widget, BuildContext> initAppProvider =
    FutureProvider.family((ref, BuildContext context) => initApp(ref, context));

final StateProvider<String> versionProvider = StateProvider<String>((_) => '');

final StateProvider<String> matchingCollectionProvider = StateProvider<String>((_)=>'');
