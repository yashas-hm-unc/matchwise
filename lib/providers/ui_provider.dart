import 'package:flutter_riverpod/flutter_riverpod.dart';

final StateProvider<int> navIndexProvider = StateProvider<int>((_) => 0);

final StateProvider<bool> collapsedProvider = StateProvider<bool>((_) => false);
