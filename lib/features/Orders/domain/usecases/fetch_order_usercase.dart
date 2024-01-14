import 'package:dartz/dartz.dart';
import 'package:road_servoces/features/Orders/data/models/orders_model.dart';
import 'package:road_servoces/features/Orders/domain/repositories/orders_repository.dart';
import 'package:road_servoces/core/error/failure.dart';

class FetchOrders {
  final OrdersRepository repository;

  FetchOrders(this.repository);

  Future<List<OrderModel>> call() async {
    Either<Failure, List<OrderModel>> result = await repository.fetchOrders();
    return result.fold(
      (failure) {
        // Handle failure here, for example, throw an exception or return an empty list
        throw Exception('Failed to fetch orders');
      },
      (ordersList) => ordersList, // On success, return the list of orders
    );
  }
}
