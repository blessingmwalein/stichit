import 'package:go_router/go_router.dart';
import 'package:stichit/app/routes/routes.dart';
import 'package:stichit/app/routes/routes_base.dart';
import 'package:stichit/rugs/view/rugs_page.dart';

class RugsPageScreen implements ScreenRouter {
  static final instance = RugsPageScreen._internal();
  RugsPageScreen._internal();

  factory RugsPageScreen() {
    return instance;
  }

  @override
  RouteBase route() {
    return GoRoute(
      path: AdminRoutes.rugs,
      name: 'Rugs',
      builder: (context, state) => const RugsPage(),
    );
  }
}
