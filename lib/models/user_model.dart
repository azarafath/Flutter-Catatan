import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String id;
  final String email;
  final String name;
  final String hobby;
  final String job;

  const UserModel({
    required this.id,
    required this.email,
    required this.name,
    this.job = '',
    this.hobby = '',
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      email: json['email'],
      name: json['name'],
      hobby: json['hobby'],
      job: json['job'],
    );
  }

  @override
  List<Object?> get props => [
        id,
        email,
        name,
        job,
        hobby,
      ];
}
