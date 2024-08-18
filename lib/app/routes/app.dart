import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stichit/app/routes/admin-routes/dashboard_page_screen.dart';
import 'package:stichit/app/routes/admin-routes/rugs_page_scree.dart';
import 'package:stichit/app/routes/routes.dart';
import 'package:stichit/app/routes/sub-routes/customers_page_screen.dart';
import 'package:stichit/app/routes/sub-routes/home_page_screen.dart';
import 'package:stichit/app/routes/sub-routes/login_screen.dart';
import 'package:stichit/app/routes/sub-routes/sign_up_screen.dart';
import 'package:stichit/app/bloc/app_bloc.dart';

abstract class AppRouter {
  static GoRouter userRouter(AppBloc appBloc) {
    return GoRouter(
      initialLocation: UserRoutes.home,
      routes: [
        HomeScreenRouter.instance.route(),
        LoginScreenRouter.instance.route(),
        SignUpScreenRouter.instance.route(),
        DashboardPageScreen.instance.route(),
        CustomersPageScreen.instance.route(),
        RugsPageScreen.instance.route(),
      ],
      redirect: (BuildContext context, GoRouterState state) =>
          _guard(context, state, appBloc),
    );
  }

  static Future<String?> _guard(
      BuildContext context, GoRouterState state, AppBloc bloc) async {
    final bool logginIn = state.matchedLocation == UserRoutes.login;

    final UserModel? user = await bloc.currentUser;

    if (bloc.state.status != AppStatus.authenticated) {
      return UserRoutes.login;
    }

    if (logginIn) {
      return UserRoutes.home;
    }

    return null;
  }
}
