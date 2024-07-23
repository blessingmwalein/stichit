import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stichit/app/layouts/auth_layout.dart';
import 'package:stichit/login/view/login_form.dart';

class LoginPage extends StatelessWidget {
  final UserType userType;

  const LoginPage({Key? key, required this.userType}) : super(key: key);

  static Page<void> page() => const MaterialPage<void>(
          child: LoginPage(
        userType: UserType.barber,
      ));

  static Route<void> route() {
    return MaterialPageRoute<void>(
        builder: (_) => const LoginPage(
              userType: UserType.barber,
            ));
  }

  @override
  Widget build(BuildContext context) {
    return const AuthLayout(child: LoginForm());
  }
}
