import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:form_inputs/form_inputs.dart';

/// {@template user}
/// UserModel model
///
/// [UserModel.empty] represents an unauthenticated user.
/// {@endtemplate}
class UserModel extends Equatable {
  /// {@macro user}
  const UserModel(
      {required this.id,
      this.email,
      this.fullName,
      this.photo,
      this.address,
      this.gender,
      this.mobile,
      this.confirmPassword,
      this.password});

  /// The current user's
  final Email? email;

  /// The current user's id.
  final String id;

  /// The current user's fullName (display fullName).
  final String? fullName;

  final String? gender;

  final String? mobile;

  final String? address;

  //password
  final Password? password;
  //confirm password
  final Password? confirmPassword;

  /// Url for the current user's photo.
  final String? photo;

  /// Empty user which represents an unauthenticated user.
  static const empty = UserModel(id: '');

  /// Convenience getter to determine whether the current user is empty.
  bool get isEmpty => this == UserModel.empty;

  /// Convenience getter to determine whether the current user is not empty.
  bool get isNotEmpty => this != UserModel.empty;

  /// Creates a UserModel instance from Firestore document snapshot.
  factory UserModel.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data()!;
    return UserModel(
      id: snapshot.id,
      email: data['email'],
      fullName: data['full_name'],
      photo: data['photo'],
      address: data['address'],
      gender: data['gender'],
      mobile: data['mobile'],
    );
  }

  /// Converts the UserModel instance to a Firestore document.
  Map<String, dynamic> toFirestore() {
    return {
      'email': email?.value ?? '',
      'full_name': fullName,
      'photo': photo,
      'address': address,
      'gender': gender,
      'mobile': mobile,
    };
  }

  /// Returns a copy of the UserModel instance with the specified fields replaced with new values.
  UserModel copyWith(
      {String? id,
      Email? email,
      String? fullName,
      String? photo,
      String? address,
      String? gender,
      String? mobile,
      Password? confirmPassword,
      Password? password}) {
    return UserModel(
        id: id ?? this.id,
        email: email ?? this.email,
        fullName: fullName ?? this.fullName,
        photo: photo ?? this.photo,
        address: address ?? this.address,
        gender: gender ?? this.gender,
        mobile: mobile ?? this.mobile,
        confirmPassword: confirmPassword ?? this.confirmPassword,
        password: password ?? this.password);
  }

  /// Returns a copy of the UserModel instance with a specific field replaced with a new value.
  UserModel copyWithField(String field, dynamic value) {
    switch (field) {
      case 'email':
        final email = Email.dirty(value);

        return copyWith(email: email);
      case 'fullName':
        return copyWith(fullName: value);
      case 'photo':
        return copyWith(photo: value);
      case 'address':
        return copyWith(address: value);
      case 'gender':
        return copyWith(gender: value);
      case 'mobile':
        return copyWith(mobile: value);
      case 'password':
        final password = Password.dirty(value);
        return copyWith(password: password);
      case 'confirmPassword':
        final confirmPassword = Password.dirty(value);
        return copyWith(confirmPassword: confirmPassword);
      default:
        return this;
    }
  }

  //tojson
  Map<String, dynamic> toJson() {
    return {
      'email': email?.value ?? '',
      'full_name': fullName,
      'photo': photo,
      'address': address,
      'gender': gender,
      'mobile': mobile,
      'id': id,
    };
  }

  //check form valid
  bool get isValid {
    return email?.displayError != null && password?.displayError != null;
  }

  @override
  List<Object?> get props => [
        email,
        id,
        fullName,
        photo,
        address,
        gender,
        mobile,
        password,
        confirmPassword
      ];
}

class Gender {
  static const String male = 'Male';
  static const String female = 'Female';

  static const List<String> values = [male, female];

  static String fromString(String name) {
    return values.firstWhere((gender) => gender == name,
        orElse: () => throw ArgumentError('Unknown Gender: $name'));
  }
}
