import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:formz/formz.dart';
import 'package:multi_image_picker_view/multi_image_picker_view.dart';
import 'package:rugs_repository/rugs_repository.dart';

part 'rugs_state.dart';

class RugsCubit extends Cubit<RugsState> {
  RugsCubit({
    required RugsRepositoryBase rugRepository,
  })  : _rugRepository = rugRepository,
        super(RugsState());

  final RugsRepositoryBase _rugRepository;

  void onFormChange(String field, dynamic value) {
    log("field: $field, value: $value");
    final updatedRug = state.rugForm.copyWithField(field, value);
    log("updatedRug: $updatedRug");
    emit(state.copyWith(rugForm: updatedRug));
  }

  //update selected images
  void updateImages(List<ImageFile> images) {
    print('images: $images');
    emit(state.copyWith(images: images));
  }

  // Save stock
  void saveRug() {
    final rugForm = state.rugForm;
    emit(state.copyWith(formStatus: FormzSubmissionStatus.inProgress));
    //check is isedit
    if (state.isEditing) {
      _rugRepository.updateRug(rugForm, state.images).then((_) {
        emit(state.copyWith(
            formStatus: FormzSubmissionStatus.success,
            successMessage: "Rug updated successfully"));
      }).catchError((error) {
        emit(state.copyWith(
            formStatus: FormzSubmissionStatus.failure,
            errorMessage: error.toString()));
      });
      return;
    } else {
      _rugRepository.addRug(rugForm, state.images).then((_) {
        emit(state.copyWith(
            formStatus: FormzSubmissionStatus.success,
            successMessage: "Rug saved successfully"));
      }).catchError((error) {
        emit(state.copyWith(
            formStatus: FormzSubmissionStatus.failure,
            errorMessage: error.toString()));
      });
    }
  }

  // Onclick edit
  void editRug(Rug stock) {
    emit(state.copyWith(
      rugForm: stock,
      isEditing: true,
      selectedRug: stock,
    ));
  }

  // Set selected stock
  void setSelectedRug(Rug stock) {
    getRugImages(stock);
    emit(state.copyWith(
      selectedRug: stock,
      rugForm: stock,
    ));
  }

  // Get all rugs
  void getRugs() {
    emit(state.copyWith(pageStatus: FormzSubmissionStatus.inProgress));

    _rugRepository.getRugs().then((rugs) {
      emit(state.copyWith(
          rugs: rugs, pageStatus: FormzSubmissionStatus.success));
    }).catchError((error) {
      emit(state.copyWith(
          errorMessage: error.toString(),
          pageStatus: FormzSubmissionStatus.failure));
    });
  }

  //clearForm
  void clearForm() {
    emit(state.copyWith(
      rugForm: Rug.empty,
      isEditing: false,
      selectedRug: null,
      formStatus: FormzSubmissionStatus.initial,
      successMessage: null,
      errorMessage: null,
      images: [],
      selectedImages: [],
    ));
  }

  //get seleted rug images
  void getRugImages(Rug rug) {
    _rugRepository.getRugImages(rug.id).then((images) {
      emit(state.copyWith(selectedImages: images));
    }).catchError((error) {
      emit(state.copyWith(errorMessage: error.toString()));
    });
  }
}
