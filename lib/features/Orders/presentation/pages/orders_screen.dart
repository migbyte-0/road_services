import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../workshop_user/view/controller/workshop_user_controller.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<WorkShopUserController>();

    return Obx(() {
      final orders = controller.orders; // This will now correctly refer to the observable list
      return ListView.builder(
        itemCount: orders.length,
        itemBuilder: (context, index) {
          final order = orders[index];
          return Card(
            child: ListTile(
              title: Text("Location: ${order.location}"),
              subtitle: Text("Tire Size: ${order.tireSize}"),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ElevatedButton(
                    onPressed: () => controller.acceptOrder(order.id),
                    child: Text("Accept"),
                  ),
                  SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () => controller.denyOrder(order.id),
                    child: Text("Deny"),
                  ),
                ],
              ),
            ),
          );
        },
      );
    });
  }
}
