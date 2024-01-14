import 'package:get/get.dart';

import '../../data/models/user_model.dart';
import '../../domain/repositories/user_repository.dart';

class UserController extends GetxController {
  final UserRepository repository;
  UserController(this.repository);

  final Rx<UserModel?> _userModel = Rx<UserModel?>(null);

  UserModel? get user => _userModel.value;

  // Future<Either<Failure, void>> registerRoadServiceUser(RoadServiceUserModel userModel) async {
  //   return await repository.registerRoadServiceUser(userModel);
  // }
}
