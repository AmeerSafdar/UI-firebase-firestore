// ignore_for_file: unused_import, library_prefixes, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task2/screens/login_screen.dart';
import 'package:task2/models/user_model.dart' as userModels;
class FirebaseMethods {
  final FirebaseAuth _firebaseauth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  late UserCredential userCredential;
  var userId=FirebaseAuth.instance.currentUser;

  Future<String> userSigIn(String userEmail, String userPassword) async{
      String res='';
      try {
        await _firebaseauth.signInWithEmailAndPassword(email: userEmail, password: userPassword)
            .then((value) => {
              res= 'successful'
            });
      }
      catch(exc){
        res=exc.toString();
      }
       return res;
}

  signUpUser(String email,String firstName,String lastName,String password
  ) async{
     String res='';
    try {
    userCredential =await _firebaseauth.createUserWithEmailAndPassword(email: email, password: password);
    userModels.UserModelClass user =userModels.UserModelClass(
          firstName: firstName,
          lastName:lastName,
          uid: userCredential.user!.uid,
          email: email,
        );
    await _firebaseFirestore.collection('users').doc(userCredential.user!.uid).set(
              user.toJson(),
            ).then((value) => {
              res= 'successful'
            });
    } catch (e) {
      res=e.toString();
    }
    
    return res;
}

updateUserData(String email, String firstName, String lastName,String uid)async{
  userModels.UserModelClass user =userModels.UserModelClass(
          firstName: firstName,
          lastName:lastName,
          uid: uid,
          email: email,
        );
        
        await _firebaseFirestore.collection('users').doc(uid).update(
        user.toJson()
      );
}

    Future<void> signOut(BuildContext cntxt) async {
    await _firebaseauth.signOut().then((value) {
      userId=null;
     Navigator.pushReplacement(cntxt, MaterialPageRoute(
        builder: (context) => const LoginScreen()));
    });
  }
}