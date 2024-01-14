import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/orders_model.dart';
import 'orders_remote_data_source.dart';

class OrderRemoteDataSourceImpl implements OrderRemoteDataSource {
  final FirebaseFirestore firestore;

  OrderRemoteDataSourceImpl({required this.firestore});

  @override
  Future<List<OrderModel>> fetchOrders() async {
    try {
      QuerySnapshot querySnapshot = await firestore.collection('orders').get();
      return querySnapshot.docs
          .map((doc) => OrderModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('Error fetching orders: ${e.toString()}');
    }
  }

  @override
  Future<void> acceptOrder(String orderId) async {
    try {
      await firestore.collection('orders').doc(orderId).update({'status': 'accepted'});
    } catch (e) {
      throw Exception('Error accepting order: ${e.toString()}');
    }
  }

  @override
  Future<void> denyOrder(String orderId) async {
    try {
      await firestore.collection('orders').doc(orderId).update({'status': 'denied'});
    } catch (e) {
      throw Exception('Error denying order: ${e.toString()}');
    }
  }
}
