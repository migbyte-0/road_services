import 'package:flutter/material.dart';
import 'core/constants/constants_exports.dart';
import 'features/auth/view/screens/user_login_screen.dart';
import 'features/workshop_user/view/screens/workshop_user_login_screen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<Color> appBarColors = [
    AppColors.userFourthColor,
     AppColors.workShopFourthColor];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
  if (_tabController.index != _tabController.previousIndex) {
    setState(() {}); // Trigger a rebuild to update AppBar color
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColors[_tabController.index],
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.green,
          isScrollable: true,
          tabs: const [
            Tab(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(AppTexts.userLogin, style: Styles.style22),
              ),
            ),
            Tab(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(AppTexts.workshopUserLogin, style: Styles.style22),
              ),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          UserLoginScreen(),
          WorkShopUserLoginScreen(),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabSelection);
    _tabController.dispose();
    super.dispose();
  }
}
