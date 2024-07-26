import 'dart:typed_data';
import 'package:cached_network_image/cached_network_image.dart';
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
import 'package:stichit/util/picker.dart'; // Add this import

class ViewRugDrawer extends StatefulWidget {
  final VoidCallback closeDrawer;
  final VoidCallback? editRug;
  final String title;

  const ViewRugDrawer({
    super.key,
    required this.closeDrawer,
    required this.title,
    this.editRug,
  });

  @override
  _ViewRugDrawerState createState() => _ViewRugDrawerState();
}

class _ViewRugDrawerState extends State<ViewRugDrawer> {
  late MultiImagePickerController controller;

  @override
  void initState() {
    super.initState();
  }

  Widget _buildDetailRow(String label, String value) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: Text(
                  label,
                  style: TextStyle(
                    color: CustomColors.white.withOpacity(0.6),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Expanded(
                flex: 7,
                child: Text(
                  value,
                  style: TextStyle(
                    color: CustomColors.white.withOpacity(0.6),
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ],
          ),
        ),
        Divider(
          color: CustomColors.white.withOpacity(0.3),
          thickness: 1,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
                          'View Rug ${selectedRug?.description ?? ''}',
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
                    if (selectedRug != null)
                      Expanded(
                        child: SingleChildScrollView(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: CustomColors.darkBackGround,
                            ),
                            padding: const EdgeInsets.all(15),
                            child: Column(
                              children: [
                                _buildDetailRow('Name', selectedRug.name),
                                _buildDetailRow(
                                    'Description', selectedRug.description),
                                _buildDetailRow('Price Per Unit',
                                    '\$${selectedRug.pricePerUnit.toStringAsFixed(2)}'),
                                _buildDetailRow(
                                    'Measure Type', selectedRug.measureType),
                                _buildDetailRow('Measure Value',
                                    selectedRug.measureValue.toString()),
                                _buildDetailRow('Type', selectedRug.type),
                                _buildDetailRow('Shape', selectedRug.shape),
                                if (state.selectedImages != null &&
                                    state.selectedImages!.isNotEmpty)
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Images:',
                                        style: TextStyle(
                                          color: CustomColors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Wrap(
                                        spacing: 8,
                                        runSpacing: 8,
                                        children:
                                            state.selectedImages!.map((image) {
                                          return Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            child: CachedNetworkImage(
                                                imageUrl: image.imageUrl,
                                                width: 100,
                                                height: 100,
                                                fit: BoxFit.cover,
                                                placeholder: (context, url) =>
                                                    const CircularProgressIndicator(),
                                                errorWidget:
                                                    (context, url, error) {
                                                  print(
                                                      'Error Iri ${image.imageUrl}');
                                                  return Icon(Icons.error);
                                                }),
                                          );
                                        }).toList(),
                                      ),
                                    ],
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
                        label: 'Close',
                        radius: 40,
                        primaryColor: Colors.red,
                        onPressed: widget.closeDrawer,
                      ),
                      const SizedBox(width: 16),
                      CustomButton(
                        label: 'Edit',
                        primaryColor: CustomColors.orange,
                        radius: 40,
                        isLoading: state.formStatus ==
                            FormzSubmissionStatus.inProgress,
                        isDisabled: state.formStatus ==
                            FormzSubmissionStatus.inProgress,
                        onPressed: () {
                          widget.editRug!();
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
    );
  }
}
