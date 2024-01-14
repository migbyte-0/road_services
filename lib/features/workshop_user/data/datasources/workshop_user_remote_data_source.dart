import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RoadServiceUserRemoteDataSource {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;

  RoadServiceUserRemoteDataSource(this.firebaseAuth, this.firestore);

  // Function to register road service user
  Future<User?> registerRoadServiceUser(
      String email,
      String password,
      String name,
      String phoneNumber,
      String workshopName,
      String location) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      // Add additional user details to Firestore
      await firestore
          .collection('workshop_users')
          .doc(userCredential.user!.uid)
          .set({
        'email': email, // Store the email
        'name': name,
        'phoneNumber': phoneNumber,
        'workshopName': workshopName,
        'location': location,
      });

      return userCredential.user;
    } catch (e) {
      // Handle exceptions
      return null;
    }
  }

  // Function to login road service user
  Future<User?> loginRoadServiceUser(String email, String password) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    } catch (e) {
      // Handle exceptions
      return null;
    }
  }

  // Function to sign out user
  Future<void> signOut() async {
    await firebaseAuth.signOut();
  }

  // Stream to monitor current user's state
  Stream<User?> get currentUser => firebaseAuth.authStateChanges();

  // Update road service user's details in Firebase
  Future<void> updateRoadServiceUserDetails(
      String userId, Map<String, dynamic> userDetails) async {
    await firestore
        .collection('workshop_users')
        .doc(userId)
        .update(userDetails);
  }
}
