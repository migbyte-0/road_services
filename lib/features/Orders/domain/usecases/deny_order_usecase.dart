import '../repositories/orders_repository.dart';

class DenyOrder {
  final OrdersRepository repository;

  DenyOrder(this.repository);

  Future<void> call(String orderId) async {
    await repository.denyOrder(orderId);
  }}