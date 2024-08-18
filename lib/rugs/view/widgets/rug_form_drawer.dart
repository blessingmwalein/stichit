import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:multi_image_picker_view/multi_image_picker_view.dart';
import 'package:rugs_repository/rugs_repository.dart';
import 'package:stichit/app/const/colors.dart';
import 'package:stichit/rugs/cubit/rugs_cubit.dart';
import 'package:stichit/rugs/view/widgets/rug_sizes_form_fields.dart';
import 'package:stichit/ui_commons/alerts/snack_bar.dart';
import 'package:stichit/ui_commons/buttons/custom_button.dart';
import 'package:stichit/ui_commons/forms/custom_text_input.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

class RugFormDrawer extends StatefulWidget {
  final VoidCallback closeDrawer;
  final String title;

  const RugFormDrawer({
    super.key,
    required this.closeDrawer,
    required this.title,
  });

  @override
  RugFormDrawerState createState() => RugFormDrawerState();
}

class RugFormDrawerState extends State<RugFormDrawer> {
  late MultiImagePickerController controller;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RugsCubit, RugsState>(
      listener: (context, state) {
        switch (state.formStatus) {
          case FormzSubmissionStatus.success:
            showCustomSnackbar(
              context,
              'Zvaita!',
              state.successMessage ?? 'Rug saved successfully',
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
        child: BlocBuilder<RugsCubit, RugsState>(
          builder: (context, state) {
            // final selectedRug = state.selectedRug;
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
                            state.selectedRug != null
                                ? 'Edit Rug - ${state.selectedRug?.name}'
                                : 'Add Rug',
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
                                          label: 'Name',
                                          onChanged: (value) => context
                                              .read<RugsCubit>()
                                              .onFormChange('name', value),
                                          hint: 'Blessing Mwale',
                                          defaultValue: state.rugForm.name,
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
                                              .read<RugsCubit>()
                                              .onFormChange(
                                                  'description', value),
                                          hint: '',
                                          defaultValue:
                                              state.rugForm.description,
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
                                    suffixIconPath:
                                        "assets/icons/currency-dollar.svg",
                                    label: 'Approx Price Per Unit(USD)',
                                    onChanged: (value) => context
                                        .read<RugsCubit>()
                                        .onFormChange('approxPricePerUnit',
                                            double.parse(value)),
                                    hint: '0.00',
                                    defaultValue: state
                                        .rugForm.approxPricePerUnit
                                        .toString(),
                                  ),
                                ),
                                const SizedBox(height: 15),
                                Padding(
                                  padding: const EdgeInsets.all(13.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Rug Sizes',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: CustomColors.white
                                              .withOpacity(0.8),
                                        ),
                                      ),
                                      TextButton(
                                          onPressed: () {
                                            context
                                                .read<RugsCubit>()
                                                .updateRugSizes([
                                              ...state.rugSizes,
                                              RugSizes.empty,
                                            ]);
                                          },
                                          child: Row(
                                            children: [
                                              const Icon(Icons.add),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                'Add Size',
                                                style: TextStyle(
                                                    color: CustomColors.white
                                                        .withOpacity(0.6)),
                                              )
                                            ],
                                          )),
                                    ],
                                  ),
                                ),
                                const RugSizesFormFields(),

                                // Add the sizes here
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
                            context.read<RugsCubit>().saveRug();
                            // Listen to the state and show snackbar
                            context.read<RugsCubit>().stream.listen((state) {
                              if (state.formStatus ==
                                  FormzSubmissionStatus.success) {
                                context.read<RugsCubit>().clearForm();
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
