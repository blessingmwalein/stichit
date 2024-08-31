import 'package:go_router/go_router.dart';
import 'package:stichit/app/routes/routes.dart';
import 'package:stichit/app/routes/routes_base.dart';
import 'package:stichit/customers/view/customer_page.dart';
import 'package:stichit/customers/view/orders_page.dart';

class OrdersPageScreen implements ScreenRouter {
  static final instance = OrdersPageScreen._internal();
  OrdersPageScreen._internal();

  factory OrdersPageScreen() {
    return instance;
  }

  @override
  RouteBase route() {
    return GoRoute(
      path: AdminRoutes.orders,
      name: 'Orders',
      builder: (context, state) => const CustomerOrderPage(),
    );
  }
}
