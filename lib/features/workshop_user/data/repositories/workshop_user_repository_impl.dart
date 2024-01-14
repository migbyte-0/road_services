import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../core/error/failure.dart';
import '../../domain/repositories/workshop_user_repository.dart';
import '../models/workshop_user_model.dart';

class WorkShopUserRepositoryImpl implements WorkShopUserRepository {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;

 WorkShopUserRepositoryImpl(this._firebaseAuth, this._firestore);

  @override
  Future<Either<Failure, void>> registerWorkShopUser(
      WorkShopUserModel userModel) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: userModel.email,
        password: userModel.password,
      );

      await _firestore
          .collection('Workshop_users')
          .doc(userCredential.user!.uid)
          .set({
        'email': userModel.email, // Store the email

        'name': userModel.name,
        'phoneNumber': userModel.phoneNumber,
        'workshopName': userModel.workshopName,
        'location': userModel.location,
      });

      return const Right(null);
    } on FirebaseAuthException catch (e) {
      return Left(ServerFailure(e.message ?? 'Registration failed'));
    }
  }

  @override
  Future<Either<Failure, WorkShopUserModel>> getWorkShopUserInfo() async {
    try {
      User? currentUser = _firebaseAuth.currentUser;
      if (currentUser != null) {
        DocumentSnapshot userDoc = await _firestore
            .collection('Workshop_users')
            .doc(currentUser.uid)
            .get();

        if (userDoc.exists) {
          Map<String, dynamic> userData =
              userDoc.data() as Map<String, dynamic>;
          WorkShopUserModel userModel =WorkShopUserModel(
            id: currentUser.uid,
            email: currentUser.email ?? '',
            password: 'userPassword', // Ensure this field is provided

            name: userData['name'] ?? '',
            phoneNumber: userData['phoneNumber'] ?? '',
            workshopName: userData['workshopName'] ?? '',
            location: userData['location'] ?? '',
          );
          return Right(userModel);
        } else {
          return const Left(ServerFailure('User data not found'));
        }
      } else {
        return const Left(ServerFailure('No user logged in'));
      }
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateWorkShopUserDetails(
      WorkShopUserModel userModel) async {
    try {
      await _firestore
          .collection('Workshop_users')
          .doc(userModel.id)
          .update({
        'name': userModel.name,
        'phoneNumber': userModel.phoneNumber,
        'workshopName': userModel.workshopName,
        'location': userModel.location,
      });
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> loginWorkShopUser(
      String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return const Right(null);
    } on FirebaseAuthException catch (e) {
      return Left(ServerFailure(e.message ?? 'Login failed'));
    }
  }
}
