import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'features/Orders/data/datasources/orders_remote_data_source.dart';
import 'features/Orders/data/models/orders_model.dart';
import 'features/Orders/domain/repositories/orders_repository.dart';
import 'features/workshop_user/data/repositories/workshop_user_repository_impl.dart';
import 'features/workshop_user/view/controller/workshop_user_controller.dart';
import 'features/Orders/domain/usecases/orders_usecases_exports.dart';
import 'features/Orders/data/repositories/orders_repository_impl.dart';
import 'features/Orders/data/datasources/order_remote_data_source_impl.dart';

void setup() {
  Get.lazyPut<OrderRemoteDataSource>(
    () => OrderRemoteDataSourceImpl(firestore: FirebaseFirestore.instance),
  );
   Get.lazyPut<OrdersRepository>(
    () => OrdersRepositoryImpl(FirebaseFirestore.instance),
  );
  Get.lazyPut(() => FetchOrders(Get.find()));
  Get.lazyPut(() => AcceptOrder(Get.find()));
  Get.lazyPut(() => DenyOrder(Get.find()));

  Get.lazyPut<WorkShopUserController>(
    () => WorkShopUserController(
      WorkShopUserRepositoryImpl(FirebaseAuth.instance, FirebaseFirestore.instance),
      FirebaseAuth.instance,
      Get.find<FetchOrders>(),
      Get.find<AcceptOrder>(),
      Get.find<DenyOrder>(),
      true.obs,  // obscurePassword as RxBool
      true.obs,  // obscureconfirmPassword as RxBool
      <OrderModel>[].obs,  // orders as observable list
    ),
  );
}
