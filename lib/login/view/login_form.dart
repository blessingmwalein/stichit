import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:go_router/go_router.dart';
import 'package:stichit/app/const/colors.dart';
import 'package:stichit/app/routes/routes.dart';
import 'package:stichit/login/cubit/login_cubit.dart';
import 'package:stichit/ui_commons/alerts/snack_bar.dart';
import 'package:stichit/ui_commons/buttons/custom_button.dart';
import 'package:stichit/ui_commons/forms/custom_text_input.dart';
import 'package:stichit/ui_commons/icons/custom_svg_icon.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool _hasShownError = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state.formStatus.isFailure) {
          if (!_hasShownError) {
            _hasShownError = true;
            showCustomSnackbar(
              context,
              'Mahwanii!',
              state.errorMessage ?? 'An error occurred',
              ContentType.failure,
            );
          }
        } else if (state.formStatus.isSuccess) {
          if (!_hasShownError) {
            _hasShownError = true;
            showCustomSnackbar(
              context,
              'Tapinda!',
              'You have successfully logged in',
              ContentType.success,
            );
            GoRouter.of(context).go(UserRoutes.home);
          }
        } else {
          _hasShownError = false;
        }
      },
      child: Align(
        alignment: const Alignment(0, -1 / 3),
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.8,
            width: MediaQuery.of(context).size.width * 0.5,
            decoration: BoxDecoration(
              image: const DecorationImage(
                image: AssetImage('assets/images/rug.jpeg'),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(25),
            ),
            padding: const EdgeInsets.all(0),
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 70.0, right: 70),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Login Stichit',
                          style: TextStyle(
                            color: primaryWhite,
                            fontSize: 40,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 40),
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
                                  GoRouter.of(context).go(UserRoutes.signUp);
                                },
                                child: const Text(
                                  'Don’t Have an account? Sign Up',
                                  style: TextStyle(
                                    color: primaryWhite,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 30),
                        LoginButton(),
                        const SizedBox(height: 20),
                        const SocialLoginButtons(),
                        const SizedBox(height: 40),
                      ],
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

// Social login buttons
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
      buildWhen: (previous, current) =>
          previous.authRequest.email != current.authRequest.email,
      builder: (context, state) {
        return CustomTextFieldWidget(
          key: const Key('loginForm_emailInput_textField'),
          label: 'Email',
          hint: 'Enter your email',
          isOutline: true,
          isPassword: false,
          controller:
              TextEditingController(text: state.authRequest.email.value),
          textInputType: TextInputType.emailAddress,
          errorText: state.authRequest.email.displayError != null
              ? 'invalid email'
              : null,
          onChanged: (email) =>
              context.read<LoginCubit>().onFormChange('email', email),
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) =>
          previous.authRequest.password != current.authRequest.password,
      builder: (context, state) {
        return CustomTextFieldWidget(
          key: const Key('loginForm_passwordInput_textField'),
          label: "Password",
          hint: "*********",
          isOutline: true,
          isPassword: true,
          controller:
              TextEditingController(text: state.authRequest.password.value),
          onChanged: (value) =>
              context.read<LoginCubit>().onFormChange('password', value),
          errorText: state.authRequest.password.displayError != null
              ? 'invalid password'
              : null,
        );
      },
    );
  }
}

class LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        return SizedBox(
          height: 60,
          width: MediaQuery.of(context).size.width * 0.2,
          child: CustomButton(
            label: 'Login',
            primaryColor: CustomColors.orange,
            radius: 40,
            isDisabled: !state.isFormValid,
            isLoading: state.formStatus.isInProgress,
            icon: "assets/icons/save-as.svg",
            onPressed: () {
              context.read<LoginCubit>().loginUser();
            },
          ),
        );
      },
    );
  }
}
