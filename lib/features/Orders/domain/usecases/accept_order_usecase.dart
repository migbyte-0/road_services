import '../repositories/orders_repository.dart';

class AcceptOrder {
  final OrdersRepository repository;

  AcceptOrder(this.repository);

  Future<void> call(String orderId) async {
    await repository.acceptOrder(orderId);
  }
}