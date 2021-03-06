import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthImplementaion {
   Future<String>SignUp(String email, String password);
    Future<String>SignIn(String email, String password);
    Future<String> getCurrentUser();
    Future<void> signOut();
}

class Auth implements AuthImplementaion {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  Future<String>SignIn(String email, String password) async {
    FirebaseUser user = await firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    return user.uid;
  }

  Future<String>SignUp(String email, String password) async {
    FirebaseUser user = await firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    return user.uid;
  }

  Future<String> getCurrentUser() async
  {
    FirebaseUser user = await firebaseAuth.currentUser(); 
      return user.uid;
  }

  Future<void> signOut() async
  {
    firebaseAuth.signOut();
  
  }
}
