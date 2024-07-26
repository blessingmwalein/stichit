import 'package:go_router/go_router.dart';
import 'package:stichit/app/routes/app.dart';
import 'package:stichit/app/routes/routes.dart';
import 'package:stichit/app/routes/routes_base.dart';
import 'package:stichit/home/view/admin.dart';
import 'package:stichit/home/view/client.dart';

class HomeScreenRouter implements ScreenRouter {
  static final instance = HomeScreenRouter._internal();
  HomeScreenRouter._internal();

  factory HomeScreenRouter() {
    return instance;
  }

  @override
  RouteBase route() {
    return GoRoute(
      path: UserRoutes.home,
      builder: (context, state) => const ClientHomePage(),
    );
  }
}