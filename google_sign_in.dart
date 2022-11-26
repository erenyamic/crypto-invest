
import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cryptoinvest/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInProvider extends ChangeNotifier{
  final googleSignIn=GoogleSignIn();
  var db;var sayac=0;
  var ref=FirebaseDatabase.instance.ref().child("users");
  GoogleSignInAccount? _user;
  GoogleSignInAccount get user => _user!;
  Future googleLogin(context) async {
    final googleUser = await googleSignIn.signIn();
    if (googleUser == null) return;
    _user = googleUser;
    final googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,

    );

    await FirebaseAuth.instance.signInWithCredential(credential);
    notifyListeners();
    db=FirebaseFirestore.instance;
    var _userDoc=await db.collection("users").get();
    for (var eleman in _userDoc.docs){
      Map userMap=eleman.data();
      if(userMap.containsValue(_user?.email.toString())){
        sayac++;
      }
    }
    if(sayac==0){
      final user = <String, dynamic>{
        "name": "-",
        "email": _user?.email.toString(),
        "password": "-",
        "balance": "1000"
      };
      db.collection("users").add(user);

      var value1=new HashMap<String,dynamic>();
      value1["balance"]="1500";
      value1["name"]="-";
      value1["email"]=_user?.email.toString();
      value1["password"]="-";
      ref.push().set(value1);

    }
    Navigator.push( context,MaterialPageRoute(builder: (context)=>home_page()));
  }
  }