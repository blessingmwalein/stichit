import 'package:authentication_repository/authentication_repository.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:go_router/go_router.dart';
import 'package:rugs_repository/rugs_repository.dart';
import 'package:stichit/app/const/colors.dart';
import 'package:stichit/app/routes/routes.dart';
import 'package:stichit/login/view/login_form.dart';
import 'package:stichit/sign-up/cubit/sign_up_cubit.dart';
import 'package:stichit/ui_commons/alerts/snack_bar.dart';
import 'package:stichit/ui_commons/buttons/custom_button.dart';
import 'package:stichit/ui_commons/forms/custom_phone_number_text.dart';
import 'package:stichit/ui_commons/forms/custom_select_field.dart';
import 'package:stichit/ui_commons/forms/custom_text_input.dart';
import 'package:ui_commons/ui_commons.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpCubit, SignUpState>(
      listener: (context, state) {
        if (state.formStatus.isFailure) {
          showCustomSnackbar(
            context,
            'Error!',
            state.errorMessage ?? 'An error occurred',
            ContentType.failure,
          );
        } else if (state.formStatus.isSuccess) {
          showCustomSnackbar(
            context,
            'Success!',
            'You have successfully signed up',
            ContentType.success,
          );
          // Navigate to another page if needed
          // Navigator.of(context).push<void>(YourNextPage.route());
        }
      },
      child: Align(
        alignment: const Alignment(0, -1 / 3),
        child: SingleChildScrollView(
          child: Container(
            // 50% of the screen
            height: MediaQuery.of(context).size.height * 0.83,
            width: MediaQuery.of(context).size.width * 0.5,
            // Circle radius
            decoration: BoxDecoration(
              image: const DecorationImage(
                image: AssetImage('assets/images/rug.jpeg'), // Background image
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(25),
            ),
            padding: const EdgeInsets.all(0),
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.6), // Overlay color
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                Container(
                  // 70% of the screen width
                  child: Padding(
                    padding: const EdgeInsets.only(left: 30.0, right: 30),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Create Stichit Account',
                          style: TextStyle(
                            color: primaryWhite,
                            fontSize: 25,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 25),
                        //row for full name and phone number
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(child: _FullNameInput()),
                            const SizedBox(width: 20),
                            Expanded(child: _GenderInout()),
                          ],
                        ),
                        const SizedBox(height: 20),
                        _PhoneNumberInput(),
                        const SizedBox(height: 20),
                        _EmailInput(),
                        const SizedBox(height: 20),
                        _AddressInput(),
                        const SizedBox(height: 20),
                        //passords in a row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(child: _PasswordInput()),
                            const SizedBox(width: 20),
                            Expanded(child: _ConfirmPasswordInput()),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextButton(
                                onPressed: () {
                                  // Navigator.of(context)
                                  //     .push<void>(AccountTypePage.route());
                                  GoRouter.of(context).go(UserRoutes.login);
                                },
                                child: const Text(
                                  'Already have an account? Login',
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
                        _SignUpButton(),
                        const SocialLoginButtons(),
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

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) =>
          previous.userForm.email != current.userForm.email,
      builder: (context, state) {
        return CustomTextFieldWidget(
          key: const Key('signUpForm_emailInput_textField'),
          label: 'Email',
          hint: 'Enter your email',
          isOutline: true,
          isPassword: false,
          controller: TextEditingController(text: state.userForm.email?.value),
          textInputType: TextInputType.emailAddress,
          errorText: state.userForm.email?.displayError != null
              ? 'Invalid email format. Please enter a valid email address, such as example@domain.com.'
              : null,
          onChanged: (email) =>
              context.read<SignUpCubit>().onFormChange('email', email),
        );
      },
    );
  }
}

//full name
class _FullNameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) =>
          previous.userForm.fullName != current.userForm.fullName,
      builder: (context, state) {
        return CustomTextFieldWidget(
          key: const Key('signUpForm_fullNameInput_textField'),
          label: 'Full Name',
          hint: 'Enter your full name',
          isOutline: true,
          isPassword: false,
          controller: TextEditingController(text: state.userForm.fullName),
          textInputType: TextInputType.text,
          onChanged: (fullName) =>
              context.read<SignUpCubit>().onFormChange('fullName', fullName),
        );
      },
    );
  }
}

//phone number use CustomPhoneNumber
class _PhoneNumberInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) =>
          previous.userForm.mobile != current.userForm.mobile,
      builder: (context, state) {
        return CustomPhoneNumberText(
          labelText: 'Phone Number',
          initialCountryCode: "ZW",
          isOutline: true,
          onChanged: (value) =>
              {context.read<SignUpCubit>().onFormChange('mobile', value)},
        );
      },
    );
  }
}

class _GenderInout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) =>
          previous.userForm.mobile != current.userForm.mobile,
      builder: (context, state) {
        return CustomSelectTextFieldWidget(
          isOutline: true,
          label: 'Gender',
          selectedOption: 'Male',
          options:
              Gender.values.map((e) => e.toString().split('.').last).toList(),
          onChanged: (value) {
            context.read<SignUpCubit>().onFormChange('gender', value);
          },
        );
      },
    );
  }
}

//address
class _AddressInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) =>
          previous.userForm.address != current.userForm.address,
      builder: (context, state) {
        return CustomTextFieldWidget(
          key: const Key('signUpForm_addressInput_textField'),
          label: 'Address',
          hint: 'Enter your address',
          isPassword: false,
          isOutline: true,
          maxLines: 3,
          controller: TextEditingController(text: state.userForm.address),
          textInputType: TextInputType.text,
          onChanged: (address) =>
              context.read<SignUpCubit>().onFormChange('address', address),
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) =>
          previous.userForm.password != current.userForm.password,
      builder: (context, state) {
        return CustomTextFieldWidget(
          key: const Key('signUpForm_passwordInput_textField'),
          label: "Password",
          hint: "*********",
          isOutline: true,
          isPassword: true,
          errorText: state.userForm.password?.displayError != null
              ? 'At least 8 characters long and contains both letters and digits.'
              : null,
          onChanged: (value) {
            context.read<SignUpCubit>().onFormChange('password', value);
          },
        );
      },
    );
  }
}

//

class _ConfirmPasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) =>
          previous.userForm.confirmPassword != current.userForm.confirmPassword,
      builder: (context, state) {
        return CustomTextFieldWidget(
          key: const Key('signUpForm_confirmPasswordInput_textField'),
          label: "Confirm Password",
          hint: "*********",
          isOutline: true,
          isPassword: true,
          onChanged: (value) {
            context.read<SignUpCubit>().onFormChange('confirmPassword', value);
          },
          errorText: state.userForm.confirmPassword?.displayError != null
              ? 'passwords do not match'
              : null,
        );
      },
    );
  }
}

class _SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      builder: (context, state) {
        return SizedBox(
          height: 60,
          //
          width: MediaQuery.of(context).size.width * 0.2,

          child: CustomButton(
              label: 'Sign Up',
              primaryColor: CustomColors.orange,
              radius: 40,
              isDisabled: !state.isFormValid,
              icon: "assets/icons/save-as.svg",
              isLoading: state.formStatus.isInProgress,
              onPressed: () {
                context.read<SignUpCubit>().saveUser();
                context.read<SignUpCubit>().stream.listen((state) {
                  if (state.formStatus == FormzSubmissionStatus.success) {
                    GoRouter.of(context).go(UserRoutes.home);
                  }
                });
              }),
        );
      },
    );
  }
}
