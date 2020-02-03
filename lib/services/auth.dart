import 'package:hallo/models/user.dart';
import "package:firebase_auth/firebase_auth.dart";
import 'package:hallo/services/database.dart';
import 'package:hallo/models/uid.dart';
import 'package:hallo/screens/nav_menu/nav_menu.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService{

  final FirebaseAuth _auth=FirebaseAuth.instance;

  //Create user object on firebaseUser
  User userFromFirebaseUser(FirebaseUser user){

    return user!= null ? User(uid:user.uid) : null;
  }




// auth change user stream

  Stream<User> get user{
    return _auth.onAuthStateChanged
    //.map((FirebaseUser user)=> _userFromFirebaseUser(user));
        .map(userFromFirebaseUser);
  }



  //sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {

    try{
      AuthResult result= await _auth.signInWithEmailAndPassword(email: email, password: password );
      FirebaseUser user = result.user;


      return userFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }





  //register with email and password
  Future registerWithEmailAndPassword(String email, String password,String name,String phone) async {

    try{
      AuthResult result= await _auth.createUserWithEmailAndPassword(email: email, password: password );
      FirebaseUser user = result.user;
       current_user_uid=user.uid;

      await DatabaseService(uid: current_user_uid).updateUserData(name, "Hey i am available on Hallo", phone , email);

      return userFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  //signout

  Future signOut() async {
    try{
      return _auth.signOut();
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  // get user id


}