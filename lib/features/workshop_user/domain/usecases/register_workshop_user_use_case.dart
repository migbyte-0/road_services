import '../../../../core/error/failure.dart';
import '../../data/models/workshop_user_model.dart';
import '../repositories/workshop_user_repository.dart';
import 'package:dartz/dartz.dart';

class RegisterWorkShopUserUseCase {
  final WorkShopUserRepository repository;

  RegisterWorkShopUserUseCase(this.repository);

  Future<Either<Failure, void>> call(WorkShopUserModel workShopUserModel) async {
    return await repository.registerWorkShopUser(workShopUserModel);
  }
}
