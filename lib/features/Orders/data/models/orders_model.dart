import '../../domain/entities/orders.dart';

class OrderModel extends Order {
  OrderModel({required String id, required String location, required String tireSize})
    : super(id: id, location: location, tireSize: tireSize);

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'],
      location: json['location'],
      tireSize: json['tireSize'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'location': location,
      'tireSize': tireSize,
    };
  }
}
