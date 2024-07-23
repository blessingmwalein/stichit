import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:stichit/app/const/colors.dart';
import 'package:stichit/stock/cubit/stock_cubit.dart';
import 'package:stichit/ui_commons/alerts/snack_bar.dart';
import 'package:stichit/ui_commons/buttons/custom_button.dart';
import 'package:stichit/ui_commons/forms/custom_select_field.dart';
import 'package:stichit/ui_commons/forms/custom_text_input.dart';
import 'package:stock_repository/stock_repository.dart';

class StockFormDrawer extends StatelessWidget {
  final VoidCallback closeDrawer;
  final String title;

  const StockFormDrawer({
    super.key,
    required this.closeDrawer,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<StockCubit, StockCubitState>(
      listener: (context, state) {
        if (state.formStatus == FormzSubmissionStatus.success) {
          showCustomSnackbar(
            context,
            'Tapinda!',
            state.successMessage ?? 'Stock saved successfully',
            ContentType.success,
          );
        } else if (state.formStatus == FormzSubmissionStatus.failure) {
          showCustomSnackbar(
            context,
            'Mahwanii!',
            state.errorMessage ?? 'An error occurred',
            ContentType.failure,
          );
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
        child: BlocBuilder<StockCubit, StockCubitState>(
          builder: (context, state) {
            final selectedStock = state.selectedStock;
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
                            state.selectedStock != null
                                ? 'Edit Stock - ${state.selectedStock?.name}'
                                : 'Add Stock',
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.normal,
                              color: CustomColors.white,
                            ),
                          ),
                          const Spacer(),
                          IconButton(
                            onPressed: closeDrawer,
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
                                          label: 'Name',
                                          onChanged: (value) => context
                                              .read<StockCubit>()
                                              .onFormChange('name', value),
                                          hint: 'Blessing Mwale',
                                          defaultValue: state.stockForm?.name ??
                                              selectedStock?.name ??
                                              '',
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      Expanded(
                                        child: CustomTextFieldWidget(
                                          isPassword: false,
                                          isOutline: true,
                                          label: 'Description',
                                          suffixIconPath:
                                              "assets/icons/clipboard-list.svg",
                                          onChanged: (value) => context
                                              .read<StockCubit>()
                                              .onFormChange(
                                                  'description', value),
                                          hint: '',
                                          defaultValue:
                                              state.stockForm?.description ??
                                                  selectedStock?.description ??
                                                  '',
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 15),
                                Padding(
                                  padding: const EdgeInsets.all(13.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: CustomTextFieldWidget(
                                          isPassword: false,
                                          isOutline: true,
                                          suffixIconPath:
                                              "assets/icons/color-swatch.svg",
                                          label: 'Color',
                                          onChanged: (value) => context
                                              .read<StockCubit>()
                                              .onFormChange('color', value),
                                          hint: '0',
                                          defaultValue:
                                              state.stockForm?.color ??
                                                  selectedStock?.color ??
                                                  '',
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      Expanded(
                                        child: CustomTextFieldWidget(
                                          isPassword: false,
                                          isOutline: true,
                                          suffixIconPath:
                                              "assets/icons/scale.svg",
                                          label: 'Quantity',
                                          onChanged: (value) => context
                                              .read<StockCubit>()
                                              .onFormChange(
                                                  'quantity', int.parse(value)),
                                          hint: '0',
                                          defaultValue: state
                                                  .stockForm?.quantity
                                                  ?.toString() ??
                                              selectedStock?.quantity
                                                  ?.toString() ??
                                              '',
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      Expanded(
                                        child: CustomSelectTextFieldWidget(
                                          isOutline: true,
                                          label: 'Category',
                                          selectedOption:
                                              state.stockForm?.category ??
                                                  selectedStock?.category ??
                                                  'Yarn',
                                          options: StockCategory.values
                                              .map((e) =>
                                                  e.toString().split('.').last)
                                              .toList(),
                                          onChanged: (value) {
                                            context
                                                .read<StockCubit>()
                                                .onFormChange(
                                                    'category', value);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 15),
                                Padding(
                                  padding: const EdgeInsets.all(13.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: CustomTextFieldWidget(
                                          isPassword: false,
                                          isOutline: true,
                                          suffixIconPath:
                                              "assets/icons/currency-dollar.svg",
                                          label: 'Buy Price',
                                          onChanged: (value) => context
                                              .read<StockCubit>()
                                              .onFormChange(
                                                  'price', double.parse(value)),
                                          hint: '0.00',
                                          defaultValue: state.stockForm?.price
                                                  ?.toString() ??
                                              selectedStock?.price
                                                  ?.toString() ??
                                              '',
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      Expanded(
                                        child: CustomSelectTextFieldWidget(
                                          isOutline: true,
                                          label: 'Measure Type',
                                          selectedOption:
                                              state.stockForm?.measureType ??
                                                  selectedStock?.measureType ??
                                                  'Cm',
                                          options: MeasureType.values
                                              .map((e) =>
                                                  e.toString().split('.').last)
                                              .toList(),
                                          onChanged: (value) {
                                            context
                                                .read<StockCubit>()
                                                .onFormChange(
                                                    'measureType', value);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 15),
                                Padding(
                                  padding: const EdgeInsets.all(13.0),
                                  child: CustomTextFieldWidget(
                                    isPassword: false,
                                    isOutline: true,
                                    suffixIconPath: "assets/icons/scale.svg",
                                    label: 'Measure Value',
                                    onChanged: (value) => context
                                        .read<StockCubit>()
                                        .onFormChange('measureValue',
                                            double.parse(value)),
                                    hint: '0',
                                    defaultValue: state.stockForm?.measureValue
                                            ?.toString() ??
                                        selectedStock?.measureValue
                                            ?.toString() ??
                                        '',
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
                          onPressed: closeDrawer,
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
                            context.read<StockCubit>().saveStock();
                            // Listen to the state and show snackbar
                            context.read<StockCubit>().stream.listen((state) {
                              if (state.formStatus ==
                                  FormzSubmissionStatus.success) {
                                context.read<StockCubit>().clearForm();

                                // Close the drawer
                                closeDrawer();
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
