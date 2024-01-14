import 'package:flutter/material.dart';
import 'package:road_servoces/core/constants/constants_exports.dart';

import 'screen_exports.dart';

class WorkshopMainScreen extends StatefulWidget {
  const WorkshopMainScreen({super.key});

  @override
  _WorkshopMainScreenState createState() => _WorkshopMainScreenState();
}

class _WorkshopMainScreenState extends State<WorkshopMainScreen> with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
    
      bottomNavigationBar: Material(
        color: Colors.transparent,
        child: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(icon: Icon(Icons.person), text: AppTexts.account),
            Tab(icon: Icon(Icons.list), text: AppTexts.orders),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children:
[
  ProfileScreen(),
   const OrdersScreen()],
),
);
}

@override
void dispose() {
_tabController?.dispose();
super.dispose();
}
}

