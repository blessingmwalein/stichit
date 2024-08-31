import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:stichit/app/const/colors.dart';
import 'package:stichit/customers/cubit/customer_cubit.dart';
import 'package:stichit/rugs/cubit/rugs_cubit.dart';
import 'package:stichit/ui_commons/alerts/snack_bar.dart';
import 'package:stichit/ui_commons/buttons/custom_button.dart';
import 'package:stichit/ui_commons/forms/custom_date_picker.dart';
import 'package:stichit/ui_commons/forms/custom_multiple_select_field.dart';
import 'package:stichit/ui_commons/forms/custom_select_field.dart';
import 'package:stichit/ui_commons/forms/custom_text_input.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

class OrdersFormDrawer extends StatefulWidget {
  final VoidCallback closeDrawer;
  final String title;

  const OrdersFormDrawer({
    super.key,
    required this.closeDrawer,
    required this.title,
  });

  @override
  OrdersFormDrawerState createState() => OrdersFormDrawerState();
}

class OrdersFormDrawerState extends State<OrdersFormDrawer> {
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
              'Success!',
              state.successMessage ?? 'Order saved successfully',
              ContentType.success,
            );
            break;
          case FormzSubmissionStatus.failure:
            showCustomSnackbar(
              context,
              'Error!',
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
                            state.selectedOrder != null
                                ? 'Edit Order - ${state.selectedOrder?.id}'
                                : 'Add Order',
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
                                        child: CustomSelectTextFieldWidget(
                                          isOutline: true,
                                          label: 'Customer',
                                          selectedOption: null,
                                          primaryColor: CustomColors.white,
                                          options: state.customers
                                              .map((e) => e.fullName)
                                              .toList(),
                                          onChanged: (value) {
                                            final selectedCustomer =
                                                state.customers.firstWhere(
                                              (customer) =>
                                                  customer.fullName == value,
                                            );
                                            context
                                                .read<CustomerCubit>()
                                                .onFormChange('userId',
                                                    selectedCustomer.id);
                                          },
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      const Expanded(child: RugTypeInput()),
                                    ],
                                  ),
                                ),

                                const SizedBox(height: 15),
                                //total amount

                                BlocBuilder<RugsCubit, RugsState>(
                                  builder: (context, rugState) {
                                    return rugState.selectedRug != null
                                        ? const Padding(
                                            padding: EdgeInsets.all(13.0),
                                            child: RugSizeInput())
                                        : const SizedBox();
                                  },
                                ),
                                //status
                                Padding(
                                  padding: const EdgeInsets.all(13.0),
                                  child:
                                      CustomMultiSelectTextFieldWidget<String>(
                                    isOutline: true,
                                    label: 'Color Palet',
                                    primaryColor: CustomColors.white,
                                    options: const [
                                      'Red',
                                      'Blue',
                                      'Green',
                                      'Yellow',
                                      'Orange',
                                      'Purple',
                                      'Brown',
                                      'Black',
                                      'White',
                                      'Gray',
                                      'Pink'
                                    ],
                                    selectedOptions: const [],
                                    onChanged: (value) {
                                      context
                                          .read<CustomerCubit>()
                                          .onFormChange('colorPalet', value);
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(13.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: CustomTextFieldWidget(
                                          isPassword: false,
                                          isOutline: true,
                                          suffixIconPath:
                                              "assets/icons/curency-dollar.svg",
                                          label: 'Deposit',
                                          onChanged: (value) => context
                                              .read<CustomerCubit>()
                                              .onFormChange('deposit',
                                                  double.parse(value)),
                                          hint: '0.00',
                                          defaultValue: state.orderForm.deposit
                                              .toString(),
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      Expanded(
                                        child: CustomTextFieldWidget(
                                          isPassword: false,
                                          isOutline: true,
                                          suffixIconPath:
                                              "assets/icons/curency-dollar.svg",
                                          label: 'Total',
                                          onChanged: (value) => context
                                              .read<CustomerCubit>()
                                              .onFormChange('totalCost',
                                                  double.parse(value)),
                                          hint: '0.00',
                                          defaultValue: state
                                              .orderForm.totalCost
                                              .toString(),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(13.0),
                                  child: CustomDatePickerWidget(
                                    label: 'Estimate delivery date',
                                    initialDate: DateTime.now()
                                        .add(const Duration(days: 7)),
                                    onDateChanged: (DateTime date) {
                                      context
                                          .read<CustomerCubit>()
                                          .onFormChange(
                                              'estimatedDeliveryDate', date);
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(13.0),
                                  child: CustomTextFieldWidget(
                                    isPassword: false,
                                    isOutline: true,
                                    maxLines: 3,
                                    suffixIconPath:
                                        "assets/icons/information-circle.svg",
                                    label: 'Notes',
                                    onChanged: (value) => context
                                        .read<CustomerCubit>()
                                        .onFormChange('notes', value),
                                    hint: 'Enter notes here',
                                    defaultValue: state.orderForm.notes,
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
                            context.read<CustomerCubit>().saveOrder();
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

class RugTypeInput extends StatelessWidget {
  const RugTypeInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CustomerCubit, CustomerState>(
      buildWhen: (previous, current) =>
          previous.orderForm.rugId != current.orderForm.rugId,
      builder: (context, state) {
        return BlocBuilder<RugsCubit, RugsState>(
          builder: (context, rugState) {
            return CustomSelectTextFieldWidget(
              isOutline: true,
              label: 'Rug Type',
              selectedOption: null,
              primaryColor: CustomColors.white,
              options: rugState.rugs.map((e) => e.name).toList(),
              onChanged: (value) {
                final slectedRug = rugState.rugs.firstWhere(
                  (rug) => rug.name == value,
                );
                context
                    .read<CustomerCubit>()
                    .onFormChange('rugId', slectedRug.id);
                context.read<RugsCubit>().setSelectedRug(slectedRug);
              },
            );
          },
        );
      },
    );
  }
}

class RugSizeInput extends StatelessWidget {
  const RugSizeInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CustomerCubit, CustomerState>(
      buildWhen: (previous, current) =>
          previous.orderForm.rugSizeId != current.orderForm.rugSizeId,
      builder: (context, state) {
        return BlocBuilder<RugsCubit, RugsState>(
          builder: (context, rugState) {
            return CustomSelectTextFieldWidget(
              isOutline: true,
              label: 'Rug Size',
              selectedOption: null,
              primaryColor: CustomColors.white,
              options: rugState.rugSizes
                  .map((e) => '${e.length}cm x ${e.width}cm')
                  .toList(),
              onChanged: (value) {
                final slectedRug = rugState.rugSizes.firstWhere(
                  (rug) => '${rug.length}cm x ${rug.width}cm' == value,
                );
                context
                    .read<CustomerCubit>()
                    .onFormChange('rugSizeId', slectedRug.id);
              },
            );
          },
        );
      },
    );
  }
}
