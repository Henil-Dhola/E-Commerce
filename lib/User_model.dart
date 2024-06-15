import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class user_model{
  String? fullname;
  String? email;
  String? password;


  user_model(this.fullname, this.email, this.password);


  toJson(){
    return{
      "Fullname":fullname,
      "Email":email,
      "Password":password,

    };
  }

  factory user_model.fromSnapshot(DocumentSnapshot<Map<String,dynamic>> document){
    final data=document.data()!;
    return user_model(data["Fullname"], data["Email"], data["Password"]);
  }
}