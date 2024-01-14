import 'package:equatable/equatable.dart';

class WorkShopUser extends Equatable {
  final String id;
  final String email;
  final String password; // Password field
  final String? name; // Make name optional
  final String? phoneNumber; // Make phoneNumber optional
  final String? workshopName; // Make workshopName optional
  final String? location; // Make location optional

  const WorkShopUser({
    required this.id,
    required this.email,
    required this.password,
    this.name, // Optionala
    this.phoneNumber, // Optional
    this.workshopName, // Optional
    this.location, // Optional
  });

  @override
  List<Object?> get props =>
      [id, email, password, name, phoneNumber, workshopName, location];
}
