import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rugs_repository/rugs_repository.dart';
import 'package:stichit/rugs/cubit/rugs_cubit.dart';
import 'package:stichit/ui_commons/forms/custom_text_input.dart';

class RugSizesFormFields extends StatefulWidget {
  const RugSizesFormFields({super.key});

  @override
  State<RugSizesFormFields> createState() => _RugSizesFormFieldsState();
}

class _RugSizesFormFieldsState extends State<RugSizesFormFields> {
  @override
  Widget build(BuildContext context) {
    final rugSizes = context.select((RugsCubit cubit) => cubit.state.rugSizes);

    return Column(
      children: rugSizes.asMap().entries.map((entry) {
        final index = entry.key;
        final size = entry.value;

        return Padding(
          padding: const EdgeInsets.all(13.0),
          child: Row(
            children: [
              Expanded(
                child: CustomTextFieldWidget(
                  isPassword: false,
                  isOutline: true,
                  label: 'Length (cm)',
                  suffixIconPath: "assets/icons/ruler.svg", // Updated icon path
                  hint: '',
                  defaultValue: size.length.toString(),
                  onChanged: (value) {
                    final updatedSize = size.copyWith(
                      length: double.tryParse(value) ?? size.length,
                    );
                    _updateSize(context, updatedSize, index);
                  },
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: CustomTextFieldWidget(
                  isPassword: false,
                  isOutline: true,
                  label: 'Width (cm)',
                  suffixIconPath: "assets/icons/ruler.svg", // Updated icon path
                  hint: '',
                  defaultValue: size.width.toString(),
                  onChanged: (value) {
                    final updatedSize = size.copyWith(
                      width: double.tryParse(value) ?? size.width,
                    );
                    _updateSize(context, updatedSize, index);
                  },
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: CustomTextFieldWidget(
                  isPassword: false,
                  isOutline: true,
                  label: 'Price (\$)',
                  suffixIconPath: "assets/icons/dollar-sign.svg",
                  hint: '',
                  defaultValue: size.price.toString(),
                  onChanged: (value) {
                    final updatedSize = size.copyWith(
                      price: double.tryParse(value) ?? size.price,
                    );
                    _updateSize(context, updatedSize, index);
                  },
                ),
              ),
              IconButton(
                icon: const Icon(Icons.delete),
                color: Colors.red,
                onPressed: () => _deleteSize(context, index),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  void _updateSize(BuildContext context, RugSizes updatedSize, int index) {
    final cubit = context.read<RugsCubit>();
    final updatedSizes = List<RugSizes>.from(cubit.state.rugSizes);

    // Update the specific index in the list
    updatedSizes[index] = updatedSize;

    cubit.updateRugSizes(updatedSizes);
  }

  void _deleteSize(BuildContext context, int index) {
    final cubit = context.read<RugsCubit>();
    final updatedSizes = List<RugSizes>.from(cubit.state.rugSizes);

    // Remove the size at the specific index
    updatedSizes.removeAt(index);

    cubit.updateRugSizes(updatedSizes);
  }
}
