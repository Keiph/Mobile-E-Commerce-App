import 'package:firebase_auth/firebase_auth.dart';

class AuthService{
  Future<UserCredential> register(email, password) {
    return FirebaseAuth.instance.createUserWithEmailAndPassword(email: email,
        password: password);
  }
  Future<UserCredential> login(email, password) {
    return FirebaseAuth.instance.signInWithEmailAndPassword(email: email,
        password: password);
  }
  Future<void> forgotPassword(email) {
    return FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }
  Stream<User?> getAuthUser() {
    return FirebaseAuth.instance.authStateChanges();
  }

  User? getCurrentUser() {
    return FirebaseAuth.instance.currentUser;
  }

  logOut() {
    return FirebaseAuth.instance.signOut();
  }
}