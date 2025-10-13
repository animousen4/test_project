import 'package:auto_route/auto_route.dart';
import 'package:user_overview/user_overview.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(
  modules: <Type>[
    UserOverviewFeatureRoutes,
  ],
)
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => <AutoRoute>[
        AutoRoute(page: UserOverviewRoute.page, initial: true),
        AutoRoute(page: UserDetailsRoute.page),
      ];
}
