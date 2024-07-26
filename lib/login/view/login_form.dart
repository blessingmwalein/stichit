import 'package:authentication_repository/authentication_repository.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:stichit/app/const/colors.dart';
import 'package:stichit/home/view/admin.dart';
import 'package:stichit/login/cubit/login_cubit.dart';
import 'package:stichit/ui_commons/alerts/snack_bar.dart';
import 'package:stichit/ui_commons/buttons/custom_button.dart';
import 'package:stichit/ui_commons/forms/custom_text_input.dart';
import 'package:stichit/ui_commons/icons/custom_svg_icon.dart';
import 'package:ui_commons/ui_commons.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state.status.isFailure) {
          showCustomSnackbar(
            context,
            'Mahwanii!',
            state.errorMessage ?? 'An error occurred',
            ContentType.failure,
          );
        } else if (state.status.isSuccess) {
          showCustomSnackbar(
            context,
            'Tapinda!',
            'You have successfully logged in',
            ContentType.success,
          );
          //navigate to personal details page
          // Navigator.of(context).push<void>(
          //     // HomePage.route(),
          //     );
        }
      },
      child: Align(
        alignment: const Alignment(0, -1 / 3),
        child: SingleChildScrollView(
          child: Container(
            //50% of the screen
            height: MediaQuery.of(context).size.height * 0.8,
            width: MediaQuery.of(context).size.width * 0.5,
            //circle radius
            decoration: BoxDecoration(
              image: const DecorationImage(
                image: AssetImage('assets/images/rug.jpeg'), // Background image
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(25),
            ),
            padding: const EdgeInsets.all(16),
            child: Stack(
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: Column(
                      children: [
                        _EmailInput(),
                        const SizedBox(height: 20),
                        _PasswordInput(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextButton(
                                onPressed: () {
                                  // Navigator.of(context)
                                  //     .push<void>(AccountTypePage.route());
                                },
                                child: Text(
                                  'Don`t Have an account? Sign Up',
                                  style: TextStyle(
                                    color: primaryWhite.withOpacity(0.6),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 20),
                        const SocialLoginButtons(),
                        const SizedBox(height: 40),

                        // const SizedBox(height: 8)
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 80, // Adjust the bottom spacing as needed
                  left: 0,
                  right: 0,

                  child: Center(
                    child: SizedBox(
                      height: 60,
                      child: CustomButton(
                        label: 'Sign in with Google',
                        primaryColor: orange,
                        radius: 40,
                        onPressed: () {
                          context.read<LoginCubit>().logInWithGoogle();
                        },
                        icon: "assets/icons/google.svg",
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//sicial login buttons
class SocialLoginButtons extends StatelessWidget {
  const SocialLoginButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 18),
        Text(
          'Or Login with',
          style: TextStyle(
            color: primaryWhite.withOpacity(0.6),
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(width: 20),
            Container(
              width: 50,
              height: 50,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: primaryWhite,
                borderRadius: BorderRadius.circular(100),
              ),
              child: customSvgIcon(
                  path: "assets/icons/google.svg", width: 50, height: 50),
            ),
            const SizedBox(width: 20),
            Container(
              width: 50,
              height: 50,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: primaryWhite,
                borderRadius: BorderRadius.circular(100),
              ),
              child: customSvgIcon(
                  path: "assets/icons/facebook.svg", width: 50, height: 50),
            ),
          ],
        ),
      ],
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return CustomTextFieldWidget(
          key: const Key('loginForm_emailInput_textField'),
          label: 'Email',
          hint: 'Enter your email',
          isPassword: false,
          controller: TextEditingController(text: state.email.value),
          textInputType: TextInputType.emailAddress,
          errorText: state.email.displayError != null ? 'invalid email' : null,
          onChanged: (email) => context.read<LoginCubit>().emailChanged(email),
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return CustomTextFieldWidget(
          key: const Key('loginForm_passwordInput_textField'),
          label: "Password",
          hint: "*********",
          isPassword: true,
          onChanged: (value) {
            context.read<LoginCubit>().passwordChanged(value);
          },
          errorText:
              state.password.displayError != null ? 'invalid password' : null,
        );
      },
    );
  }
}
