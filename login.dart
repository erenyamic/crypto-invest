import 'package:cryptoinvest/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cryptoinvest/jsonclass.dart';

class easy_login extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    var email=TextEditingController();
    var password=TextEditingController();
    var ref=FirebaseDatabase.instance.ref().child("users");

    late FirebaseAuth _auth;

    void login(){
      _auth=FirebaseAuth.instance;
      if(email.text.toString()!=""&&password.text.toString()!=""){
        var user=_auth.signInWithEmailAndPassword(email: email.text, password: password.text).catchError((dynamic error){
          if(error.toString().contains('invalid-email')){
            showDialog(context: context, builder:(BuildContext context){
              return AlertDialog(
                title: Text("Invalid Email"),
                content: Text(" "),
                actions: [
                  TextButton(onPressed: (){Navigator.pop(context);}, child: Text("Ok"))
                ],
              );
            });
          }else if(error.toString().contains('user-not-found')){
            showDialog(context: context, builder:(BuildContext context){
              return AlertDialog(
                title: Text("User not found"),
                content: Text(" "),
                actions: [
                  TextButton(onPressed: (){Navigator.pop(context);}, child: Text("Ok"))
                ],
              );
            });
          }else if(error.toString().contains('wrong-password')){
            showDialog(context: context, builder:(BuildContext context){
              return AlertDialog(
                title: Text("Wrong Password"),
                content: Text(" "),
                actions: [
                  TextButton(onPressed: (){Navigator.pop(context);}, child: Text("Ok"))
                ],
              );
            });
          }
        }).then((value) {
          ref.onValue.listen((event) {
            var deger1=event.snapshot.value as dynamic;
            if(deger1!=null){
              deger1.forEach((key,nesne){
                var deger2=vt.fromJson(nesne);
                if(email.text.toString()==deger2.email&&password.text.toString()==deger2.password){
                  return Navigator.push(context, MaterialPageRoute(builder: (context)=>home_page()));

                }
              });
            }
          });



        });
      }else{
        showDialog(context: context, builder:(BuildContext context){
          return AlertDialog(
            title: Text("Log In Failed"),
            content: Text("Cannot be blank"),
            actions: [
              TextButton(onPressed: (){Navigator.pop(context);}, child: Text("Ok"))
            ],
          );
        });

      }
    }

    void forgotpass(){
      if(email.text.toString()!=""){
        _auth=FirebaseAuth.instance;
        _auth.sendPasswordResetEmail(email: email.text.trim());
        showDialog(context: context, builder: (BuildContext){
          return AlertDialog(
          title: Text("Sent succsessfull"),
          );
        });
      }else{
        showDialog(context: context, builder: (BuildContext context){
          return AlertDialog(
            title: Text("Cannot be blank email"),
            content: Text("Warning"),
            actions: [
              TextButton(onPressed: (){Navigator.of(context).pop();}, child: Text("Ok"))
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
              padding: EdgeInsets.symmetric(vertical: 35.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topRight: Radius.circular(40.0),topLeft: Radius.circular(40.0))
              ),
              child: Column(
                children: [
                  Padding(padding: EdgeInsets.symmetric(vertical: 5,horizontal: 36),child: Align(alignment: Alignment.centerLeft,child: Text("Login to your account",style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                  ),),),),
                  Padding(padding: EdgeInsets.symmetric(vertical: 5,horizontal: 36),child: Align(alignment: Alignment.centerLeft,child: Text("Hello there, please login to continue.",style: TextStyle(color: Colors.grey.shade600),),),),
                  Padding(padding: EdgeInsets.symmetric(vertical: 0,horizontal: 36),
                    child: Align(alignment: Alignment.centerLeft,child: TextButton(
                      child: Text("Forgot password ?"),
                      onPressed: forgotpass,
                      style: ButtonStyle(
                          textStyle: MaterialStateProperty.all(TextStyle(decoration: TextDecoration.underline))
                      ),
                    ),)
                  ),
                  Padding(padding: EdgeInsets.symmetric(vertical: 5,horizontal: 36),child: TextField(
                    controller: email,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),

                      ),
                      prefixIcon: Icon(Icons.mail,color: Color.fromRGBO(0, 149, 252, 1.0),),

                      labelText: "Email",
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),),
                  Padding(padding: EdgeInsets.symmetric(vertical: 5,horizontal: 36),child: TextField(
                    controller: password,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),

                      ),
                      prefixIcon: Icon(Icons.lock,color: Color.fromRGBO(0, 149, 252, 1.0),),

                      labelText: "Password",
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),),
                  Padding(padding: EdgeInsets.fromLTRB(50.0,10.0,50.0,5.0),
                    child: ElevatedButton(
                      onPressed: login,
                      child: Text("Login"),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Color.fromRGBO(0, 149, 252, 1.0)),
                        foregroundColor: MaterialStateProperty.all(Colors.white),
                        padding: MaterialStateProperty.all(EdgeInsets.fromLTRB(35,15, 35, 15)),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))),


                      ),

                    ),),
                  Padding(padding: EdgeInsets.symmetric(vertical: 5,horizontal: 36),child: ElevatedButton(
                    onPressed: (){Navigator.pop(context);},
                    child: Text("Sign Up"),
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Color.fromRGBO(0, 149, 252, 1.0)),
                        foregroundColor: MaterialStateProperty.all(Colors.white),
                        padding: MaterialStateProperty.all(EdgeInsets.fromLTRB(28, 15, 28, 15)),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)))
                    ),
                  ),)
                ],
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