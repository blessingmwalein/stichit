import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stichit/app/routes/routes.dart';
import 'package:stichit/app/routes/sub-routes/home_page_screen.dart';
import 'package:stichit/app/routes/sub-routes/login_screen.dart';

abstract class AppRouter {
  static final GoRouter userRouter =
      GoRouter(initialLocation: UserRoutes.home, routes: [
    HomeScreenRouter.instance.route(),
    LoginScreenRouter.instance.route(),
  ]);
}
