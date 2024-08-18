import 'package:flutter/material.dart';
import 'package:stichit/app/layouts/client_layout.dart';
import 'package:stichit/sign-up/view/sign_up_form.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ClientLayout(child: SignUpForm());
  }
}
