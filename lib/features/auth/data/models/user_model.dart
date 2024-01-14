import '../../domain/entities/user.dart';

class UserModel extends AppUser {
  final String password;

  const UserModel({
    required String id,
    required String email,
    this.password = '',
    required String name,
    required String phoneNumber,
    required String tireSize,
  }) : super(
          id: id,
          email: email,
          name: name,
          phoneNumber: phoneNumber,
          tireSize: tireSize,
        );

  // إنشاء نموذج من JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      email: json['email'],
      password: json['password'],
      name: json['name'],
      phoneNumber: json['phoneNumber'],
      tireSize: json['tireSize'],
    );
  }

  // تحويل النموذج إلى JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'password': password,
      'name': name,
      'phoneNumber': phoneNumber,
      'tireSize': tireSize
    };
  }
}
