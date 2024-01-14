import '../../../../core/error/failure.dart';
import '../repositories/user_repository.dart';
import 'package:dartz/dartz.dart';

class LoginUseCase {
  final UserRepository repository;

  LoginUseCase(this.repository);

  Future<Either<Failure, void>> call(String email, String password) async {
    return await repository.login(email, password);
  }
}
