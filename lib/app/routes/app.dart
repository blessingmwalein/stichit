import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stichit/app/routes/admin-routes/dashboard_page_screen.dart';
import 'package:stichit/app/routes/routes.dart';
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
      ],
      redirect: (BuildContext context, GoRouterState state) =>
          _guard(context, state, appBloc),
    );
  }

  static String? _guard(
      BuildContext context, GoRouterState state, AppBloc bloc) {
    final bool logginIn = state.matchedLocation == UserRoutes.login;

    if (bloc.state.status != AppStatus.authenticated) {
      return UserRoutes.login;
    }

    if (logginIn) {
      return UserRoutes.home;
    }

    return null;
  }
}
