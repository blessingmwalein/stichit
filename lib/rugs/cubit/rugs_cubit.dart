import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
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

  //update selected rugSizes
  ///update rug sizes
  void updateRugSizes(List<RugSizes>? rugSizes) {
    emit(state.copyWith(rugSizes: rugSizes));
  }

  ///add rug size
  void addRugSize(RugSizes rugSize) {
    final rugSizes = [...state.rugSizes, rugSize];
    emit(state.copyWith(rugSizes: rugSizes));
  }

  // Save stock
  void saveRug() {
    final rugForm = state.rugForm;
    emit(state.copyWith(formStatus: FormzSubmissionStatus.inProgress));
    //check is isedit
    if (state.isEditing) {
      _rugRepository.updateRug(rugForm, state.rugSizes).then((_) {
        //get rugs after updating
        getRugs();
        emit(state.copyWith(
            formStatus: FormzSubmissionStatus.success,
            isEditing: false,
            selectedRug: null,
            rugForm: Rug.empty,
            rugSizes: [],
            successMessage: "Rug updated successfully"));
      }).catchError((error) {
        emit(state.copyWith(
            formStatus: FormzSubmissionStatus.failure,
            errorMessage: error.toString()));
      });
      return;
    } else {
      _rugRepository.addRug(rugForm, state.rugSizes).then((_) {
        //get rugs after saving
        getRugs();
        emit(state.copyWith(
            formStatus: FormzSubmissionStatus.success,
            isEditing: false,
            selectedRug: null,
            rugForm: Rug.empty,
            rugSizes: [],
            successMessage: "Rug saved successfully"));
      }).catchError((error) {
        emit(state.copyWith(
            formStatus: FormzSubmissionStatus.failure,
            errorMessage: error.toString()));
      });
    }
  }

  // Onclick edit
  void editRug(Rug rug) {
    //get rug sizes
    getRugSizes(rug);
    emit(state.copyWith(
      rugForm: rug,
      isEditing: true,
      selectedRug: rug,
    ));
  }

  // Set selected stock
  void setSelectedRug(Rug rug) {
    getRugSizes(rug);
    emit(state.copyWith(
      selectedRug: rug,
      rugForm: rug,
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
      rugSizes: [],
      selectedImages: [],
    ));
  }

  //get seleted rug rugSizes
  void getRugSizes(Rug rug) {
    _rugRepository.getRugSizes(rug.id).then((rugSizes) {
      emit(state.copyWith(rugSizes: rugSizes));
    }).catchError((error) {
      emit(state.copyWith(errorMessage: error.toString()));
    });
  }
}
