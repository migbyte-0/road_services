import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../core/error/failure.dart';
import '../../domain/repositories/user_repository.dart';
import '../models/user_model.dart';

class UserRepositoryImpl implements UserRepository {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;

  UserRepositoryImpl(this._firebaseAuth, this._firestore);

  @override
  Future<Either<Failure, void>> registerUser(UserModel userModel) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: userModel.email,
        password: userModel.password,
      );

      // Additional user details can be stored in Firestore
      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'name': userModel.name,
        'phoneNumber': userModel.phoneNumber,
        'tireSize': userModel.tireSize,
      });

      return const Right(null);
    } on FirebaseAuthException catch (e) {
      return Left(ServerFailure(e.message ?? 'Registration failed'));
    }
  }

  @override
  Future<Either<Failure, UserModel>> getUserInfo() async {
    try {
      User? currentUser = _firebaseAuth.currentUser;
      if (currentUser != null) {
        DocumentSnapshot userDoc =
            await _firestore.collection('users').doc(currentUser.uid).get();

        if (userDoc.exists) {
          Map<String, dynamic> userData =
              userDoc.data() as Map<String, dynamic>;
          UserModel userModel = UserModel(
            id: currentUser.uid,
            email: currentUser.email ?? '',
            password: '', // Password should not be stored or retrieved
            name: userData['name'] ?? '',
            phoneNumber: userData['phoneNumber'] ?? '',
            tireSize: userData['tireSize'] ?? '',
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
  Future<Either<Failure, void>> login(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return const Right(null);
    } on FirebaseAuthException catch (e) {
      return Left(ServerFailure(e.message ?? 'Login failed'));
    }
  }

  @override
  Future<Either<Failure, void>> updateUserDetails(UserModel userModel) async {
    try {
      User? currentUser = _firebaseAuth.currentUser;
      if (currentUser != null && currentUser.uid == userModel.id) {
        await _firestore.collection('users').doc(currentUser.uid).update({
          'name': userModel.name,
          'phoneNumber': userModel.phoneNumber,
          'tireSize': userModel.tireSize,
        });
        return const Right(null);
      } else {
        return const Left(ServerFailure('No matching user found'));
      }
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
