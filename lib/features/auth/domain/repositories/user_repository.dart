import '../../data/models/user_model.dart';
import '../../../../core/error/failure.dart';
import 'package:dartz/dartz.dart';

abstract class UserRepository {
  Future<Either<Failure, void>> registerUser(UserModel userModel);
  Future<Either<Failure, UserModel>> getUserInfo();

  // Add other methods as needed, for example:
  Future<Either<Failure, void>> updateUserDetails(UserModel userModel);
  Future<Either<Failure, void>> login(String email, String password);
}
