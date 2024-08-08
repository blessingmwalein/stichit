import 'package:go_router/go_router.dart';
import 'package:stichit/app/routes/app.dart';
import 'package:stichit/app/routes/routes.dart';
import 'package:stichit/app/routes/routes_base.dart';
import 'package:stichit/home/view/admin.dart';
import 'package:stichit/home/view/client.dart';

class DashboardPageScreen implements ScreenRouter {
  static final instance = DashboardPageScreen._internal();
  DashboardPageScreen._internal();

  factory DashboardPageScreen() {
    return instance;
  }

  @override
  RouteBase route() {
    return GoRoute(
      path: AdminRoutes.admin,
      builder: (context, state) => const AdminDashboard(),
    );
  }
}
