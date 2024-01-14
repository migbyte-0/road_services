import '../../data/models/workshop_user_model.dart';

import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';


abstract class WorkShopUserRepository {
  Future<Either<Failure, void>> registerWorkShopUser(
      WorkShopUserModel workShopUserModel);
  Future<Either<Failure, WorkShopUserModel>> getWorkShopUserInfo();
  Future<Either<Failure, void>> updateWorkShopUserDetails(
      WorkShopUserModel workShopUserModel);
  Future<Either<Failure, void>> loginWorkShopUser(
      String email, String password);
}
