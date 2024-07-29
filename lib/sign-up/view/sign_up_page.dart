import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stichit/app/layouts/auth_layout.dart';
import 'package:stichit/login/view/login_form.dart';
import 'package:stichit/sign-up/view/sign_up_form.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const AuthLayout(child: SignUpForm());
  }
}
