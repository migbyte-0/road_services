import '../../../../core/error/failure.dart';
import '../../data/models/workshop_user_model.dart';
import '../repositories/workshop_user_repository.dart';
import 'package:dartz/dartz.dart';

class GetWorkShopUserInfoUseCase {
  final WorkShopUserRepository repository;

  GetWorkShopUserInfoUseCase(this.repository);

  Future<Either<Failure, WorkShopUserModel>> call() async {
    return await repository.getWorkShopUserInfo();
  }
}
