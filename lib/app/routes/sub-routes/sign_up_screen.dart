import 'package:go_router/go_router.dart';
import 'package:stichit/app/routes/routes.dart';
import 'package:stichit/app/routes/routes_base.dart';
import 'package:stichit/sign-up/view/sign_up_page.dart';

class SignUpScreenRouter implements ScreenRouter {
  static final instance = SignUpScreenRouter._internal();
  SignUpScreenRouter._internal();

  factory SignUpScreenRouter() {
    return instance;
  }

  @override
  RouteBase route() {
    return GoRoute(
      path: UserRoutes.signUp,
      builder: (context, state) => const SignUpPage(),
    );
  }
}
