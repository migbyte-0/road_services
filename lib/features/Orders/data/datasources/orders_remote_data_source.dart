
import '../models/orders_model.dart';

abstract class OrderRemoteDataSource {
  Future<List<OrderModel>> fetchOrders();
  Future<void> acceptOrder(String orderId);
  Future<void> denyOrder(String orderId);
}


