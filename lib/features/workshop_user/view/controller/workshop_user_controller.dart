// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:road_servoces/core/error/failure.dart';
import 'package:road_servoces/features/Orders/data/models/orders_model.dart';

import '../../../../core/constants/constants_exports.dart';
import '../../../../core/error/validation_failure.dart';
import '../../../Orders/domain/usecases/orders_usecases_exports.dart';
import '../../data/models/workshop_user_model.dart';
import '../../domain/repositories/workshop_user_repository.dart';
import '../screens/workshop_main_screen.dart';
import '../screens/workshop_user_login_screen.dart';
import '../validators/validation_util.dart';

class WorkShopUserController extends GetxController {
  final WorkShopUserRepository workShopUserRepository;
  final FirebaseAuth firebaseAuth;
  final FetchOrders fetchOrders;
  final AcceptOrder acceptOrder;
  final DenyOrder denyOrder;
  var obscurePassword = true.obs;
  var obscureconfirmPassword = true.obs;

  var orders = <OrderModel>[].obs; // Observable list of orders


    // Change userDetails to Rx<WorkShopUserModel>
  var userDetails = Rx<WorkShopUserModel>(
    const WorkShopUserModel(
    id: '',
    email: '',
    password: '',
    name: '',
    phoneNumber: '',
    workshopName: '',
    location: '',
  ));
  
  

  WorkShopUserController(
    this.workShopUserRepository,
    this.firebaseAuth,
    this.fetchOrders,
    this.acceptOrder,
    this.denyOrder,
    this.obscurePassword,
    this.obscureconfirmPassword,
    this.orders,
  );


 @override
  void onInit() {
    super.onInit();
    _fetchUserDetails();
  }


  String getCurrentUserId() {
    return firebaseAuth.currentUser?.uid ?? '';
  }

void _fetchUserDetails() async {
  User? firebaseUser = firebaseAuth.currentUser;
  if (firebaseUser != null) {
    // Fetch user details from Firestore
    final doc = await FirebaseFirestore.instance.collection('workshop_users').doc(firebaseUser.uid).get();
    if (doc.exists) {
      var data = doc.data() as Map<String, dynamic>;
      // Set email from FirebaseAuth user
      data['email'] = firebaseUser.email ?? '';
      userDetails.value = WorkShopUserModel.fromJson(data);
    }
  }
}



Future<void> updateEmail(String newEmail) async {
    User? user = firebaseAuth.currentUser;
    try {
      await user?.updateEmail(newEmail);
      // Update email in Firestore as well
      await FirebaseFirestore.instance.collection('workshop_users').doc(user?.uid).update({'email': newEmail});
    } catch (e) {
      // Handle exceptions
      // For example, show an error message using Get.snackbar
      Get.snackbar('Error', 'Failed to update email: ${e.toString()}');
    }
  }

  Future<Either<Failure, void>> registerWorkShopUser(
      WorkShopUserModel userModel) async {
    String? emailError = ValidationUtil.validateEmail(userModel.email);
    String? passwordError = ValidationUtil.validatePassword(userModel.password);

    if (emailError != null || passwordError != null) {
      return Left(ValidationFailure(emailError ?? passwordError!));
    }

    return await workShopUserRepository.registerWorkShopUser(userModel);
  }

  // ... other methods ...

  Future<User?> loginWorkShopUser(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    } catch (e) {
      // Handle exceptions
      return null;
    }
  }



Future<void> updateWorkShopUserDetails(String id, String username, String phoneNumber, String workshopName, String location) async {
  // Validation checks
  String? usernameError = ValidationUtil.validateUsername(username);
  String? phoneNumberError = ValidationUtil.validatePhoneNumber(phoneNumber);
  if (usernameError != null || phoneNumberError != null) {
    Get.snackbar('Error', usernameError ?? phoneNumberError!);
    return;
  }

  // Show loading dialog
  Get.dialog(
    const Center(child: AppLoading()),
    barrierDismissible: false,
  );

  // Create updated user model
  final updatedUser = WorkShopUserModel(
    id: id,
    email: userDetails.value.email, // Keep existing email
    password: '', // Password is not stored or retrieved
    name: username,
    phoneNumber: phoneNumber,
    workshopName: workshopName,
    location: location,
  );

  // Update user details in Firestore and in the controller
  final result = await workShopUserRepository.updateWorkShopUserDetails(updatedUser);
  result.fold(
    (failure) {
      Get.back(); // Close loading dialog
      Get.snackbar('Error', failure.toString());
    },
    (_) {
      userDetails.value = updatedUser; // Update the userDetails observable
      Get.back(); // Close loading dialog
      Get.offAll(() => const WorkshopMainScreen()); // Navigate to home screen
    },
  );
}


 void loadOrders() async {
    var fetchedOrders = await fetchOrders();
    orders.assignAll(fetchedOrders);
  }

  void onAcceptOrder(String orderId) async {
    await acceptOrder(orderId);
    loadOrders(); // Refresh orders after acceptance
  }

  void onDenyOrder(String orderId) async {
    await denyOrder(orderId);
    loadOrders(); // Refresh orders after denial
  }


  // Add logout logic
  void logout() {
    // Your logout logic
    Get.offAll(() => const WorkShopUserLoginScreen());
  }
}



