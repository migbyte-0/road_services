import 'package:equatable/equatable.dart';

class AppUser extends Equatable {
  final String id;
  final String email;
  final String name;
  final String phoneNumber;
  final String tireSize;

  const AppUser({
    required this.id,
    required this.email,
    required this.name,
    required this.phoneNumber,
    required this.tireSize,
  });

  @override
  List<Object?> get props => [id, email, name, phoneNumber, tireSize];
}
