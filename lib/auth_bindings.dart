import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'features/Orders/data/models/orders_model.dart';
import 'features/auth/data/repositories/user_repository_impl.dart';
import 'features/auth/view/controller/user_controller.dart';
import 'features/workshop_user/data/repositories/workshop_user_repository_impl.dart';
import 'features/workshop_user/view/controller/workshop_user_controller.dart';
import 'features/Orders/domain/usecases/orders_usecases_exports.dart';

class AuthBindings extends Bindings {
  @override
  void dependencies() {
    // Create Firebase instances
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    // Provide these instances to your repositories
    Get.lazyPut<UserController>(
      () => UserController(UserRepositoryImpl(firebaseAuth, firestore)),
    );

    // Lazy put for Order use cases
    Get.lazyPut(() => FetchOrders(Get.find()));
    Get.lazyPut(() => AcceptOrder(Get.find()));
    Get.lazyPut(() => DenyOrder(Get.find()));

    // Provide all required dependencies to WorkShopUserController
    Get.lazyPut<WorkShopUserController>(
      () => WorkShopUserController(
        WorkShopUserRepositoryImpl(firebaseAuth, firestore),
        firebaseAuth,
        Get.find<FetchOrders>(),  // FetchOrders use case
        Get.find<AcceptOrder>(),  // AcceptOrder use case
        Get.find<DenyOrder>(),    // DenyOrder use case
        true.obs,                // obscurePassword as RxBool
        true.obs,                // obscureconfirmPassword as RxBool
        <OrderModel>[].obs,      // orders as observable list
      ),
    );
  }
}
