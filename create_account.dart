import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cryptoinvest/home_page.dart';
import 'package:cryptoinvest/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'login.dart';

class CreateAccount extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    var ad_soyad=TextEditingController();
    var email=TextEditingController();
    var password=TextEditingController();
    late FirebaseAuth _auth;
    var ref=FirebaseDatabase.instance.ref().child("users");
    var db;

    void signUp(){
      _auth=FirebaseAuth.instance;
      db=FirebaseFirestore.instance;

      if(email.text.toString()!=""&&password.text.toString()!=""&&ad_soyad.text.toString()!=""){
        try{
          var new_user=_auth.createUserWithEmailAndPassword(email: email.text, password: password.text).catchError((dynamic error){
            if(error.toString().contains('email-already-in-use')){
              showDialog(context: context, builder:(BuildContext context){
                return AlertDialog(
                  title: Text("Sign Up Failed"),
                  content: Text("Email already in use"),
                  actions: [
                    TextButton(onPressed: (){Navigator.pop(context);}, child: Text("Ok"))
                  ],
                );
              });
            }else if(error.toString().contains('invalid-email')){
              showDialog(context: context, builder: (BuildContext context){
                return AlertDialog(
                  title: Text("Sign Up Failed"),
                  content: Text("Invalid Email"),
                  actions: [
                    TextButton(onPressed: (){Navigator.pop(context);}, child: Text("Ok"),),
                  ],
                );
              });
            }else if(error.toString().contains('weak-password')){
              showDialog(context: context, builder: (BuildContext context){
                return AlertDialog(
                  title: Text("Sign Up Failed"),
                  content: Text('Weak Password'),
                  actions: [
                    TextButton(onPressed: (){Navigator.pop(context);}, child: Text("Ok"),),
                  ],
                );
              });
            }else{
              showDialog(context: context, builder: (BuildContext context){
                return AlertDialog(
                  title: Text("Sign Up Failed"),
                  content: Text("Try Again"),
                  actions: [
                    TextButton(onPressed: (){Navigator.pop(context);}, child: Text("Ok"),),
                  ],
                );
              });
            }
          }).then((value){
            final user = <String, dynamic>{
              "name": ad_soyad.text.toString(),
              "email": email.text.toString(),
              "password": password.text.toString(),
              "balance": "1000"
            };db.collection("users").add(user);

            var value1=new HashMap<String,dynamic>();
            value1["balance"]="1500";
            value1["name"]=ad_soyad.text.toString();
            value1["email"]=email.text.toString();
            value1["password"]=password.text.toString();
            ref.push().set(value1);
            return Navigator.push(context, MaterialPageRoute(builder: (context)=>easy_login()));

          });
        }catch(e){
          print(e.toString());
        }
      }else{
        showDialog(context: context, builder: (BuildContext context){
          return AlertDialog(
            title: Text("Cannot be blank"),
            content: Text("!"),
            actions: [
              TextButton(onPressed: (){Navigator.pop(context);}, child:Text("Ok"))
            ],
          );
        });
      }

        

    }





    // TODO: implement build
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 35),
              child: Column(
                children: [
                  Padding(padding: EdgeInsets.symmetric(vertical: 5,horizontal: 36),child: Align(alignment: Alignment.centerLeft,child: Text("Create Account",style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  ),),),),
                  Padding(padding: EdgeInsets.symmetric(vertical: 5,horizontal: 36),child: Align(alignment: Alignment.centerLeft,child: Text("Hello there, please sign up to continue.",style: TextStyle(color: Colors.grey.shade600),),),),
                  Padding(padding: EdgeInsets.symmetric(vertical: 5,horizontal: 36),
                    child:
                    TextField(
                      controller: ad_soyad,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        prefixIcon: Icon(Icons.account_circle,color: Color.fromRGBO(0, 149, 252, 1.0)),
                        labelText: "Ad Soyad",
                        filled: true,
                        fillColor: Colors.white,
                      ),

                    ),
                  ),
                  Padding(padding: EdgeInsets.symmetric(vertical: 5,horizontal: 36),child:
                  TextField(
                    controller: email,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                        ),
                        prefixIcon: Icon(Icons.mail,color: Color.fromRGBO(0, 149, 252, 1.0),),
                        labelText: "Email",
                        filled: true,
                        fillColor: Colors.white
                    ),
                  )
                    ,),
                  Padding(padding: EdgeInsets.symmetric(vertical: 5,horizontal: 36),
                    child: TextField(
                      controller: password,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          prefixIcon: Icon(Icons.lock,color: Color.fromRGBO(0, 149, 252,1.0),),
                          labelText: "Password",
                          filled: true,
                          fillColor: Colors.white
                      ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.fromLTRB(50.0,10.0,50.0,5.0),
                    child: ElevatedButton(
                      onPressed: signUp,
                      child: Text("Sign Up"),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Color.fromRGBO(0, 149, 252, 1.0)),
                        foregroundColor: MaterialStateProperty.all(Colors.white),
                        padding: MaterialStateProperty.all(EdgeInsets.fromLTRB(30,15, 30, 15)),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))),


                      ),

                    ),),
                  Padding(padding: EdgeInsets.symmetric(vertical: 5,horizontal: 36),child: ElevatedButton(
                    onPressed: (){Navigator.pop(context);},
                    child: Text("Log In"),
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Color.fromRGBO(0, 149, 252, 1.0)),
                        foregroundColor: MaterialStateProperty.all(Colors.white),
                        padding: MaterialStateProperty.all(EdgeInsets.fromLTRB(35, 15, 35, 15)),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)))
                    ),
                  ),)
                ],
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(40.0),topRight: Radius.circular(40.0))

              ),
            )

          ],
        ),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("lib/img/bg3.png"),
            fit: BoxFit.cover
          ),

        ),
      ),
    );
  }
}