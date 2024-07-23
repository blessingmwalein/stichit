import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stichit/home/view/admin.dart';
import 'package:stichit/login/view/view.dart';

final GoRouter _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/auth/login',
      builder: (context, state) => const LoginPage(
        userType: UserType.client,
      ),
    ),
  ],
);
