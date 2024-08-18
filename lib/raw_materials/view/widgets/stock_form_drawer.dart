import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:stichit/app/const/colors.dart';
import 'package:stichit/raw_materials/cubit/raw_material_cubit.dart';
import 'package:stichit/ui_commons/alerts/snack_bar.dart';
import 'package:stichit/ui_commons/buttons/custom_button.dart';
import 'package:stichit/ui_commons/forms/custom_select_field.dart';
import 'package:stichit/ui_commons/forms/custom_text_input.dart';
import 'package:raw_materials_repository/raw_materials_repository.dart';

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
    return BlocListener<RawMaterialCubit, RawMaterialCubitState>(
      listener: (context, state) {
        if (state.formStatus == FormzSubmissionStatus.success) {
          showCustomSnackbar(
            context,
            'Tapinda!',
            state.successMessage ?? 'RawMaterial saved successfully',
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
        child: BlocBuilder<RawMaterialCubit, RawMaterialCubitState>(
          builder: (context, state) {
            // final selectedStock = state.selectedStock;
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
                                ? 'Edit RawMaterial - ${state.selectedStock?.name}'
                                : 'Add RawMaterial',
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
                                              .read<RawMaterialCubit>()
                                              .onFormChange('name', value),
                                          hint: 'Blessing Mwale',
                                          defaultValue:
                                              state.rawMaterialForm.name,
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
                                              .read<RawMaterialCubit>()
                                              .onFormChange(
                                                  'description', value),
                                          hint: '',
                                          defaultValue:
                                              state.rawMaterialForm.description,
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
                                      // Expanded(
                                      //   child: CustomTextFieldWidget(
                                      //     isPassword: false,
                                      //     isOutline: true,
                                      //     suffixIconPath:
                                      //         "assets/icons/color-swatch.svg",
                                      //     label: 'Color',
                                      //     onChanged: (value) => context
                                      //         .read<RawMaterialCubit>()
                                      //         .onFormChange('color', value),
                                      //     hint: '0',
                                      //     defaultValue:
                                      //         state.rawMaterialForm?.color ??
                                      //             selectedStock?.color ??
                                      //             '',
                                      //   ),
                                      // ),
                                      const SizedBox(width: 16),
                                      // Expanded(
                                      //   child: CustomTextFieldWidget(
                                      //     isPassword: false,
                                      //     isOutline: true,
                                      //     suffixIconPath:
                                      //         "assets/icons/scale.svg",
                                      //     label: 'Quantity',
                                      //     onChanged: (value) => context
                                      //         .read<RawMaterialCubit>()
                                      //         .onFormChange(
                                      //             'quantity', int.parse(value)),
                                      //     hint: '0',
                                      //     defaultValue: state
                                      //             .rawMaterialForm?.quantity
                                      //             ?.toString() ??
                                      //         selectedStock?.quantity
                                      //             ?.toString() ??
                                      //         '',
                                      //   ),
                                      // ),
                                      const SizedBox(width: 16),
                                      Expanded(
                                        child: CustomSelectTextFieldWidget(
                                          isOutline: true,
                                          label: 'Category',
                                          selectedOption: state.rawMaterialForm
                                              .rawMaterialCategory,
                                          options: RawMaterialCategory.values
                                              .map((e) =>
                                                  e.toString().split('.').last)
                                              .toList(),
                                          onChanged: (value) {
                                            context
                                                .read<RawMaterialCubit>()
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
                                      // Expanded(
                                      //   child: CustomTextFieldWidget(
                                      //     isPassword: false,
                                      //     isOutline: true,
                                      //     suffixIconPath:
                                      //         "assets/icons/currency-dollar.svg",
                                      //     label: 'Buy Price',
                                      //     onChanged: (value) => context
                                      //         .read<RawMaterialCubit>()
                                      //         .onFormChange(
                                      //             'price', double.parse(value)),
                                      //     hint: '0.00',
                                      //     defaultValue: state.rawMaterialForm?.price
                                      //             ?.toString() ??
                                      //         selectedStock?.price
                                      //             ?.toString() ??
                                      //         '',
                                      //   ),
                                      // ),
                                      const SizedBox(width: 16),
                                      Expanded(
                                        child: CustomSelectTextFieldWidget(
                                          isOutline: true,
                                          label: 'Measure Type',
                                          selectedOption:
                                              state.rawMaterialForm.measureType,
                                          options: MeasureType.values
                                              .map((e) =>
                                                  e.toString().split('.').last)
                                              .toList(),
                                          onChanged: (value) {
                                            context
                                                .read<RawMaterialCubit>()
                                                .onFormChange(
                                                    'measureType', value);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 15),
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
                            context.read<RawMaterialCubit>().saveStock();
                            // Listen to the state and show snackbar
                            context
                                .read<RawMaterialCubit>()
                                .stream
                                .listen((state) {
                              if (state.formStatus ==
                                  FormzSubmissionStatus.success) {
                                context.read<RawMaterialCubit>().clearForm();

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
