import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:stichit/app/const/colors.dart';
import 'package:stichit/customers/cubit/customer_cubit.dart';
import 'package:stichit/ui_commons/alerts/snack_bar.dart';
import 'package:stichit/ui_commons/buttons/custom_button.dart';
import 'package:stichit/ui_commons/forms/custom_phone_number_text.dart';
import 'package:stichit/ui_commons/forms/custom_select_field.dart';
import 'package:stichit/ui_commons/forms/custom_text_input.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

class CustomerFormDrawer extends StatefulWidget {
  final VoidCallback closeDrawer;
  final String title;

  const CustomerFormDrawer({
    super.key,
    required this.closeDrawer,
    required this.title,
  });

  @override
  _RugFormDrawerState createState() => _RugFormDrawerState();
}

class _RugFormDrawerState extends State<CustomerFormDrawer> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CustomerCubit, CustomerState>(
      listener: (context, state) {
        switch (state.formStatus) {
          case FormzSubmissionStatus.success:
            showCustomSnackbar(
              context,
              'Zvaita!',
              state.successMessage ?? 'Customer saved successfully',
              ContentType.success,
            );
            break;
          case FormzSubmissionStatus.failure:
            showCustomSnackbar(
              context,
              'Mahwanii!',
              state.errorMessage ?? 'An error occurred',
              ContentType.failure,
            );
            break;
          default:
            break;
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.4,
        decoration: const BoxDecoration(
          color: CustomColors.lightBackGround,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: BlocBuilder<CustomerCubit, CustomerState>(
          builder: (context, state) {
            // final selectedCustomer = state.selectedCustomer;
            return Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            state.selectedCustomer != null
                                ? 'Edit Customer - ${state.selectedCustomer?.fullName}'
                                : 'Add Customer',
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.normal,
                              color: CustomColors.white,
                            ),
                          ),
                          const Spacer(),
                          IconButton(
                            onPressed: widget.closeDrawer,
                            icon: const Icon(Icons.close,
                                color: CustomColors.white),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Divider(
                        color: CustomColors.grey.withOpacity(0.4),
                        height: 0.4,
                      ),
                      const SizedBox(height: 15),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 70),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(13.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: CustomTextFieldWidget(
                                          isPassword: false,
                                          isOutline: true,
                                          suffixIconPath:
                                              "assets/icons/user.svg",
                                          label: 'Full Name',
                                          onChanged: (value) => context
                                              .read<CustomerCubit>()
                                              .onFormChange('fullName', value),
                                          hint: 'Blessing Mwale',
                                          defaultValue:
                                              state.customerForm.fullName,
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      Expanded(
                                        child: CustomTextFieldWidget(
                                          isPassword: false,
                                          isOutline: true,
                                          label: 'Email',
                                          suffixIconPath:
                                              "assets/icons/mail.svg",
                                          onChanged: (value) => context
                                              .read<CustomerCubit>()
                                              .onFormChange('email', value),
                                          hint: '',
                                          defaultValue:
                                              state.customerForm.email?.value,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 15),
                                //address
                                Padding(
                                  padding: const EdgeInsets.all(13.0),
                                  child: CustomTextFieldWidget(
                                    isPassword: false,
                                    isOutline: true,
                                    label: 'Address',
                                    suffixIconPath:
                                        "assets/icons/location-marker.svg",
                                    onChanged: (value) => context
                                        .read<CustomerCubit>()
                                        .onFormChange('address', value),
                                    hint: '1234, Harare, Zimbabwe',
                                    defaultValue: state.customerForm.address,
                                  ),
                                ),
                                //gender and mobile
                                Padding(
                                  padding: const EdgeInsets.all(13.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: CustomSelectTextFieldWidget(
                                          isOutline: true,
                                          label: 'Gender',
                                          selectedOption: 'Male',
                                          primaryColor: CustomColors.white
                                              .withOpacity(0.4),
                                          options: Gender.values
                                              .map((e) =>
                                                  e.toString().split('.').last)
                                              .toList(),
                                          onChanged: (value) {
                                            context
                                                .read<CustomerCubit>()
                                                .onFormChange('gender', value);
                                          },
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      Expanded(
                                        child: CustomPhoneNumberText(
                                          labelText: 'Phone Number',
                                          defaultValue:
                                              state.customerForm.mobile?.value,
                                          initialCountryCode: "ZW",
                                          isOutline: true,
                                          onChanged: (value) => {
                                            context
                                                .read<CustomerCubit>()
                                                .onFormChange(
                                                    'mobile', value.number)
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  left: 0,
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    color: CustomColors.lightBackGround,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CustomButton(
                          label: 'Cancel',
                          radius: 40,
                          primaryColor: Colors.red,
                          onPressed: widget.closeDrawer,
                        ),
                        const SizedBox(width: 16),
                        CustomButton(
                          label: 'Save',
                          primaryColor: CustomColors.orange,
                          radius: 40,
                          isLoading: state.formStatus ==
                              FormzSubmissionStatus.inProgress,
                          isDisabled: state.formStatus ==
                              FormzSubmissionStatus.inProgress,
                          onPressed: () {
                            context.read<CustomerCubit>().saveCustomer();
                            // Listen to the state and show snackbar
                            context
                                .read<CustomerCubit>()
                                .stream
                                .listen((state) {
                              if (state.formStatus ==
                                  FormzSubmissionStatus.success) {
                                context.read<CustomerCubit>().clearForm();
                                // Close the drawer
                                widget.closeDrawer();
                              }
                            });
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
