import '../../../../core/error/failure.dart';
import '../../data/models/user_model.dart';
import '../repositories/user_repository.dart';
import 'package:dartz/dartz.dart';

class UpdateUserDetailsUseCase {
  final UserRepository repository;

  UpdateUserDetailsUseCase(this.repository);

  Future<Either<Failure, void>> call(UserModel userModel) async {
    return await repository.updateUserDetails(userModel);
  }
}
