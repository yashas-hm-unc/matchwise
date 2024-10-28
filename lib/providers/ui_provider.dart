import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:matchwise/core/models/matchwise_user.dart';

final StateProvider<int> navIndexProvider = StateProvider<int>((_) => 0);

final StateProvider<bool> collapsedProvider = StateProvider<bool>((_) => false);

final StateProvider<bool> dashboardLoaderProvider =
    StateProvider<bool>((_) => true);

final StateProvider<bool> datesLoaderProvider =
    StateProvider<bool>((_) => true);

final StateProvider<List<MatchWiseUser>> userLoader =
    StateProvider((_) => <MatchWiseUser>[]);
