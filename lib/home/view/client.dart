import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stichit/app/layouts/auth_layout.dart';
import 'package:stichit/login/view/login_form.dart';

class ClientHomePage extends StatelessWidget {
  const ClientHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AuthLayout(
        child: Container(
      child: Text('Client Home Page'),
    ));
  }
}
