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
