import 'package:equatable/equatable.dart';

class UserDetails extends Equatable {
  final String id;
  final String userId;
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final String homeAddress;
  final String gender;
  final String type;
  final String age;

  const UserDetails({
    required this.id,
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.homeAddress,
    required this.gender,
    required this.type,
    required this.age,
  });

  factory UserDetails.fromJson(Map<String, dynamic> json) {
    return UserDetails(
      id: json['id'] ?? '',
      userId: json['user_id'] ?? '',
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      email: json['email'] ?? '',
      phoneNumber: json['phone_number'] ?? '',
      homeAddress: json['home_address'] ?? '',
      gender: json['gender'] ?? '',
      type: json['type'] ?? '',
      age: json['age'] ?? '',
    );
  }

  //empty user details
  static UserDetails empty = const UserDetails(
      userId: '',
      firstName: '',
      lastName: '',
      email: '',
      phoneNumber: '',
      homeAddress: '',
      age: '',
      type: '',
      gender: '',
      id: '');

  @override
  List<Object?> get props => [
        userId,
        firstName,
        lastName,
        email,
        phoneNumber,
        homeAddress,
        gender,
        type,
        age,
        id
      ];
}
