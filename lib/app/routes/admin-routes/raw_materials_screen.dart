import 'package:go_router/go_router.dart';
import 'package:stichit/app/routes/routes.dart';
import 'package:stichit/app/routes/routes_base.dart';
import 'package:stichit/raw_materials/view/stock_page.dart';

class RawMaterialsScreen implements ScreenRouter {
  static final instance = RawMaterialsScreen._internal();
  RawMaterialsScreen._internal();

  factory RawMaterialsScreen() {
    return instance;
  }

  @override
  RouteBase route() {
    return GoRoute(
      path: AdminRoutes.customers,
      name: 'Raw Materials',
      builder: (context, state) => const RawMaterialPage(),
    );
  }
}
