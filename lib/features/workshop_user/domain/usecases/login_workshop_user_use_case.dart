import '../../../../core/error/failure.dart';
import '../repositories/workshop_user_repository.dart';
import 'package:dartz/dartz.dart';

class LoginWorkShopUserUseCase {
  final WorkShopUserRepository repository;

  LoginWorkShopUserUseCase(this.repository);

  Future<Either<Failure, void>> call(String email, String password) async {
    try {
      // Logic to authenticate road service user
      await repository.loginWorkShopUser(email, password);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
