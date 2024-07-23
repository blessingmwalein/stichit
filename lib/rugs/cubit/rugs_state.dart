part of 'rugs_cubit.dart';

final class RugsState extends Equatable {
  RugsState({
    this.formStatus = FormzSubmissionStatus.initial,
    this.pageStatus = FormzSubmissionStatus.initial,
    this.isFormValid = false,
    this.errorMessage,
    this.successMessage,
    Rug? rugForm,
    this.rugs = const [],
    this.isEditing = false,
    this.selectedRug,
    this.images = const [],
    this.selectedImages = const [],
  }) : rugForm = rugForm ?? Rug.empty;

  final FormzSubmissionStatus formStatus;
  final FormzSubmissionStatus pageStatus;
  final bool isFormValid;
  final String? errorMessage;
  final String? successMessage;
  final Rug rugForm;
  final bool isEditing;
  final List<Rug> rugs;
  final Rug? selectedRug;
  final List<ImageFile>? images;
  final List<RugImage>? selectedImages;

  RugsState copyWith({
    FormzSubmissionStatus? formStatus,
    FormzSubmissionStatus? pageStatus,
    bool? isFormValid,
    String? errorMessage,
    String? successMessage,
    Rug? rugForm,
    bool? isEditing,
    List<Rug>? rugs,
    Rug? selectedRug,
    List<ImageFile>? images,
    List<RugImage>? selectedImages,
  }) {
    return RugsState(
      formStatus: formStatus ?? this.formStatus,
      pageStatus: pageStatus ?? this.pageStatus,
      isFormValid: isFormValid ?? this.isFormValid,
      errorMessage: errorMessage ?? this.errorMessage,
      successMessage: successMessage ?? this.successMessage,
      rugForm: rugForm ?? this.rugForm,
      isEditing: isEditing ?? this.isEditing,
      rugs: rugs ?? this.rugs,
      selectedRug: selectedRug ?? this.selectedRug,
      images: images ?? this.images,
      selectedImages: selectedImages ?? this.selectedImages,
    );
  }

  @override
  List<Object?> get props => [
        formStatus,
        pageStatus,
        isFormValid,
        errorMessage,
        successMessage,
        rugForm,
        isEditing,
        rugs,
        selectedRug,
        images,
        selectedImages,
      ];
}
