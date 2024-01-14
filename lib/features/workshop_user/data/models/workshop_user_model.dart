import '../../domain/entities/workshop_user.dart';

class WorkShopUserModel extends WorkShopUser {
  const WorkShopUserModel({
    required String id,
    required String email,
    required String password,
    String? name,
    String? phoneNumber,
    String? workshopName,
    String? location,
  }) : super(
          id: id,
          email: email,
          password: password,
          name: name,
          phoneNumber: phoneNumber,
          workshopName: workshopName,
          location: location,
        );

  factory WorkShopUserModel.fromJson(Map<String, dynamic> json) {
    return WorkShopUserModel(
      id: json['id'],
      email: json['email'],
      password: json['password'],
      name: json['name'],
      phoneNumber: json['phoneNumber'],
      workshopName: json['workshopName'],
      location: json['location'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'password': password,
      'name': name,
      'phoneNumber': phoneNumber,
      'workshopName': workshopName,
      'location': location,
    };
  }
}
