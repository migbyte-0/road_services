import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:road_servoces/features/Orders/data/models/orders_model.dart';
import '../../../../core/error/failure.dart';
import '../../domain/repositories/orders_repository.dart';

class OrdersRepositoryImpl implements OrdersRepository {
  final FirebaseFirestore _firestore;

  OrdersRepositoryImpl(this._firestore);

  @override
  Future<Either<Failure, List<OrderModel>>> fetchOrders() async {
    try {
      QuerySnapshot querySnapshot = await _firestore.collection('orders').get();
      List<OrderModel> orders = querySnapshot.docs
          .map((doc) => OrderModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
      return Right(orders);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> acceptOrder(String orderId) async {
    try {
      await _firestore.collection('orders').doc(orderId).update({'status': 'accepted'});
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> denyOrder(String orderId) async {
    try {
      await _firestore.collection('orders').doc(orderId).update({'status': 'denied'});
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
