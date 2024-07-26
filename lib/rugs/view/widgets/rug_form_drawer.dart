import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:multi_image_picker_view/multi_image_picker_view.dart';
import 'package:rugs_repository/rugs_repository.dart';
import 'package:stichit/app/const/colors.dart';
import 'package:stichit/rugs/cubit/rugs_cubit.dart';
import 'package:stichit/ui_commons/alerts/snack_bar.dart';
import 'package:stichit/ui_commons/buttons/custom_button.dart';
import 'package:stichit/ui_commons/forms/custom_select_field.dart';
import 'package:stichit/ui_commons/forms/custom_text_input.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:stichit/util/picker.dart';

class RugFormDrawer extends StatefulWidget {
  final VoidCallback closeDrawer;
  final String title;

  const RugFormDrawer({
    super.key,
    required this.closeDrawer,
    required this.title,
  });

  @override
  _RugFormDrawerState createState() => _RugFormDrawerState();
}

class _RugFormDrawerState extends State<RugFormDrawer> {
  late MultiImagePickerController controller;
  @override
  void initState() {
    super.initState();
    controller = MultiImagePickerController(
      maxImages: 12,
      picker: (bool allowMultiple) async {
        final List<ImageFile> images =
            await pickImagesUsingFilePicker(allowMultiple);
        //update state images
        if (mounted) {
          context.read<RugsCubit>().updateImages(images);
        }
        return images;
      },
    );
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
            final selectedRug = state.selectedRug;
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
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: CustomSelectTextFieldWidget(
                                          isOutline: true,
                                          label: 'Type',
                                          selectedOption: state.isEditing &&
                                                  selectedRug != null
                                              ? selectedRug.type
                                              : state.rugForm.type,
                                          options: RugType.values
                                              .map((e) =>
                                                  e.toString().split('.').last)
                                              .toList(),
                                          onChanged: (value) {
                                            context
                                                .read<RugsCubit>()
                                                .onFormChange('type', value);
                                          },
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      Expanded(
                                        child: CustomSelectTextFieldWidget(
                                          isOutline: true,
                                          label: 'Measure Type',
                                          selectedOption: state.isEditing &&
                                                  selectedRug != null
                                              ? selectedRug.measureType
                                              : state.rugForm.measureType,
                                          options: RugMeasureType.values
                                              .map((e) =>
                                                  e.toString().split('.').last)
                                              .toList(),
                                          onChanged: (value) {
                                            context
                                                .read<RugsCubit>()
                                                .onFormChange(
                                                    'measureType', value);
                                          },
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      Expanded(
                                        child: CustomTextFieldWidget(
                                          isPassword: false,
                                          isOutline: true,
                                          suffixIconPath:
                                              "assets/icons/scale.svg",
                                          label: 'Measure Value',
                                          onChanged: (value) => context
                                              .read<RugsCubit>()
                                              .onFormChange('measureValue',
                                                  double.parse(value)),
                                          hint: '0',
                                          defaultValue: state
                                              .rugForm.measureValue
                                              .toString(),
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
                                          label: 'Price Per Unit',
                                          onChanged: (value) => context
                                              .read<RugsCubit>()
                                              .onFormChange('pricePerUnit',
                                                  double.parse(value)),
                                          hint: '0.00',
                                          defaultValue: state
                                              .rugForm.pricePerUnit
                                              .toString(),
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      Expanded(
                                        child: CustomSelectTextFieldWidget(
                                          isOutline: true,
                                          label: 'Shape',
                                          selectedOption: state.isEditing &&
                                                  selectedRug != null
                                              ? selectedRug.shape
                                              : state.rugForm.shape,
                                          options: RugShape.values
                                              .map((e) =>
                                                  e.toString().split('.').last)
                                              .toList(),
                                          onChanged: (value) {
                                            context
                                                .read<RugsCubit>()
                                                .onFormChange(
                                                    'rugShape', value);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 15),
                                Padding(
                                  padding: const EdgeInsets.all(13.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Images',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: CustomColors.white,
                                        ),
                                      ),
                                      const SizedBox(height: 15),
                                      MultiImagePickerView(
                                        controller: controller,
                                        draggable: true,
                                        longPressDelayMilliseconds: 250,
                                        onDragBoxDecoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .shadow
                                                  .withOpacity(0.3),
                                              blurRadius: 8,
                                            ),
                                          ],
                                        ),
                                        shrinkWrap: true,
                                        padding: const EdgeInsets.all(0),
                                        gridDelegate:
                                            const SliverGridDelegateWithMaxCrossAxisExtent(
                                          maxCrossAxisExtent: 150,
                                          childAspectRatio: 0.8,
                                          crossAxisSpacing: 4,
                                          mainAxisSpacing: 4,
                                        ),
                                        builder: (context, imageFile) {
                                          return Stack(
                                            children: [
                                              Positioned.fill(
                                                child: ImageFileView(
                                                    imageFile: imageFile),
                                              ),
                                              Positioned(
                                                top: 4,
                                                right: 4,
                                                child: DraggableItemInkWell(
                                                  borderRadius:
                                                      BorderRadius.circular(16),
                                                  onPressed: () => controller
                                                      .removeImage(imageFile),
                                                  child: Container(
                                                    padding:
                                                        const EdgeInsets.all(6),
                                                    decoration: BoxDecoration(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .secondary
                                                          .withOpacity(0.5),
                                                      shape: BoxShape.circle,
                                                    ),
                                                    child: Icon(
                                                      Icons
                                                          .delete_forever_rounded,
                                                      size: 20,
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .onSecondary,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                        initialWidget: SizedBox(
                                          height: 150,
                                          width: double.infinity,
                                          child: Center(
                                            child: ElevatedButton.icon(
                                              onPressed: () {
                                                print('ndabaiwa');
                                                controller.pickImages();
                                              },
                                              icon:
                                                  const Icon(Icons.add_a_photo),
                                              label: const Text('Pick Images'),
                                            ),
                                          ),
                                        ),
                                        addMoreButton: SizedBox(
                                          height: 150,
                                          width: double.infinity,
                                          child: Center(
                                            child: TextButton(
                                              style: TextButton.styleFrom(
                                                backgroundColor: Colors.black
                                                    .withOpacity(0.2),
                                                shape: const CircleBorder(),
                                              ),
                                              onPressed: controller.pickImages,
                                              child: const Padding(
                                                padding: EdgeInsets.all(12),
                                                child: Icon(
                                                  Icons.add,
                                                  size: 32,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
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
