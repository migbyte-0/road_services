import 'package:road_servoces/features/Orders/data/models/orders_model.dart';

import '../../../../core/error/failure.dart';
import 'package:dartz/dartz.dart';

abstract class OrdersRepository {
  Future<Either<Failure, List<OrderModel>>> fetchOrders();
  Future<Either<Failure, void>> acceptOrder(String orderId);
  Future<Either<Failure, void>> denyOrder(String orderId);
}
