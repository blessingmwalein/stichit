import 'package:go_router/go_router.dart';
import 'package:stichit/app/routes/routes.dart';
import 'package:stichit/app/routes/routes_base.dart';
import 'package:stichit/login/view/view.dart';

class LoginScreenRouter implements ScreenRouter {
  static final instance = LoginScreenRouter._internal();
  LoginScreenRouter._internal();

  factory LoginScreenRouter() {
    return instance;
  }

  @override
  RouteBase route() {
    return GoRoute(
      path: UserRoutes.login,
      name: 'Login',
      builder: (context, state) => const LoginPage(),
    );
  }
}
