import 'package:go_router/go_router.dart';
import 'package:stichit/app/routes/routes.dart';
import 'package:stichit/app/routes/routes_base.dart';
import 'package:stichit/customers/view/customer_page.dart';

class CustomersPageScreen implements ScreenRouter {
  static final instance = CustomersPageScreen._internal();
  CustomersPageScreen._internal();

  factory CustomersPageScreen() {
    return instance;
  }

  @override
  RouteBase route() {
    return GoRoute(
      path: AdminRoutes.customers,
      name: 'Customers',
      builder: (context, state) => const CustomerPage(),
    );
  }
}
