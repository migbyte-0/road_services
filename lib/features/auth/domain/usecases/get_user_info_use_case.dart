import '../../../../core/error/failure.dart';
import '../../data/models/user_model.dart';
import '../repositories/user_repository.dart';
import 'package:dartz/dartz.dart';

class GetUserInfoUseCase {
  final UserRepository repository;

  GetUserInfoUseCase(this.repository);

  Future<Either<Failure, UserModel>> call() async {
    return await repository.getUserInfo();
  }
}
