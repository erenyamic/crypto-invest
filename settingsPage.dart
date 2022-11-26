import 'dart:collection';

import 'package:cryptoinvest/home_page.dart';
import 'package:cryptoinvest/profilePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:cryptoinvest/jsonclass.dart';
import 'charts.dart';

class SettingsPage extends StatelessWidget{
  var pass="Try Again";
  var userId;var cname="Try Again";
  var newpass1=TextEditingController();
  var newpass2=TextEditingController();
  var newname=TextEditingController();
  var ref=FirebaseDatabase.instance.ref().child("users");
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final user=FirebaseAuth.instance.currentUser;
    late FirebaseAuth _auth;
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text("Settings"),centerTitle: true,
          backgroundColor: Color.fromRGBO(37, 41, 76, 1.0),
          foregroundColor: Colors.white,
        ),
        bottomNavigationBar: Container(color: Color.fromRGBO(37, 41, 76, 1.0),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 15.0),
            child: GNav(gap: 8,selectedIndex: 2,
                backgroundColor: Color.fromRGBO(37, 41, 76, 1.0),color: Colors.white,activeColor: Colors.white,tabBackgroundColor: Color.fromRGBO(30, 33, 64, 1.0),
                padding: EdgeInsets.all(16),
                tabs: [
                  GButton(icon: Icons.home,text: "Home",onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>home_page()));
                  },),
                  GButton(icon: FontAwesomeIcons.chartLine,text: "Chart",onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>charts(say1: 1)));
                  },),
                  GButton(icon: Icons.settings,text: "Settings",),
                  GButton(icon: Icons.account_circle,text: "Profile",onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfilePage()));},),
                ]),
          ),
        ),
        body: Container(
          width: double.infinity,color: Color.fromRGBO(30, 33, 64, 1.0),
          child: Column(
            children: [
              Padding(padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text("Account",style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold
                ),),
              ),
              ),
              InkWell(
                onTap: (){
                  ref.onValue.listen((event) {
                    var deger1=event.snapshot.value as dynamic;
                    if(deger1!=null){
                      deger1.forEach((key,nesne){
                        var deger2=vt.fromJson(nesne);
                        if(FirebaseAuth.instance.currentUser?.email==deger2.email){
                          cname=deger2.name.toString();
                          userId=key.toString();
                        }
                      });
                    }
                  });

                  showDialog(context: context, builder: (BuildContext){
                    return AlertDialog(
                      title: Text("Change name"),
                      content: Text("Current name: ${cname}"),
                      actions: [
                        TextField(
                          decoration: InputDecoration(
                            hintText: "New name",
                          ),controller: newname,
                        ),
                        TextButton(onPressed: ()async{
                          print(userId);
                          if(newname.text.toString()!=""&&userId!=null){
                            var updatedinfo2=HashMap<String,dynamic>();
                            updatedinfo2["name"]=newname.text.toString();
                            await ref.child(userId).update(updatedinfo2);
                            Navigator.pop(context);


                          }else{
                            showDialog(context: context, builder: (BuildContext){
                              return AlertDialog(
                                title: Text("Failed"),
                              );
                            });
                          }
                        }, child: Text("Rename"))

                      ],
                    );
                  });
                },
                child: Container(
                  child: TextField(enabled: false,
                    decoration: InputDecoration(labelText: "Name",enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2,color: Colors.white)
                    ),labelStyle: TextStyle(color: Colors.white),suffixIcon: Icon(FontAwesomeIcons.arrowRight,color: Colors.white,),prefixIcon: Icon(FontAwesomeIcons.signature,color: Colors.white,size: 20,),),
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                    ),
                  ),
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(37, 41, 76, 1.0)
                  ),
                ),
              ),
              InkWell(
                onTap: (){
                  showDialog(context: context, builder: (BuildContext){
                    return AlertDialog(
                      title: Text(FirebaseAuth.instance.currentUser!.email.toString()),
                    );
                  });

                },
                child: Container(
                  child: TextField(enabled: false,
                    decoration: InputDecoration(labelText: "Email address",enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2,color: Colors.white)
                    ),labelStyle: TextStyle(color: Colors.white),suffixIcon: Icon(FontAwesomeIcons.arrowRight,color: Colors.white,),prefixIcon: Icon(Icons.mail,color: Colors.white,size: 20,),),
                    style: TextStyle(
                        fontSize: 25,
                        color: Colors.white
                    ),
                  ),
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(37, 41, 76, 1.0)
                  ),
                ),
              ),
              InkWell(onTap: (){
                ref.onValue.listen((event) {
                  var deger1=event.snapshot.value as dynamic;
                  if(deger1!=null){
                    deger1.forEach((key,nesne){
                      var deger2=vt.fromJson(nesne);
                      if(FirebaseAuth.instance.currentUser?.email==deger2.email){
                        pass=deger2.password.toString();
                        userId=key.toString();
                      }
                    });
                  }
                });
                showDialog(context: context, builder: (BuildContext){
                  return AlertDialog(
                    title: Text("Change password"),
                    content: Text("Current password: ${pass}"),
                    actions: [
                      TextField(
                        decoration: InputDecoration(
                          hintText: "New password",
                        ),controller: newpass1,
                      ),
                      TextField(
                        decoration: InputDecoration(
                          hintText: "Password again",
                        ),controller: newpass2,
                      ),
                      TextButton(onPressed: ()async{
                        print(userId);
                        if(newpass1.text.toString()!=""&&newpass2.text.toString()!=""&&newpass1.text.toString()==newpass2.text.toString()&&userId!=null){
                          FirebaseAuth.instance.currentUser?.updatePassword(newpass1.text);
                          var updatedinfo=HashMap<String,dynamic>();
                          updatedinfo["password"]=newpass1.text.toString();
                          await ref.child(userId).update(updatedinfo);
                          Navigator.pop(context);


                        }else{
                          showDialog(context: context, builder: (BuildContext){
                            return AlertDialog(
                              title: Text("Failed"),
                            );
                          });
                        }
                      }, child: Text("Reset Password"))

                    ],
                  );
                });
              },
                child: Container(
                  child: TextField(enabled: false,
                    decoration: InputDecoration(labelText: "Change password",enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2,color: Colors.white)
                    ),labelStyle: TextStyle(color: Colors.white),suffixIcon: Icon(FontAwesomeIcons.arrowRight,color: Colors.white,),prefixIcon: Icon(FontAwesomeIcons.lock,color: Colors.white,size: 20,),),
                    style: TextStyle(
                        fontSize: 25,
                        color: Colors.white
                    ),
                  ),
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(37, 41, 76, 1.0)
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Other",style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                  ),),
                ),
              ),
              InkWell(
                onTap: ()async{
                  await FirebaseAuth.instance.signOut();Navigator.of(context).pushNamedAndRemoveUntil(
                      '/', (Route<dynamic> route) => false);
                },
                child: Container(
                  child: TextField(enabled: false,
                    decoration: InputDecoration(labelText: "Logout",enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2,color: Colors.white)
                    ),labelStyle: TextStyle(color: Colors.white),suffixIcon: Icon(FontAwesomeIcons.arrowRight,color: Colors.white,),prefixIcon: Icon(FontAwesomeIcons.signOutAlt,color: Colors.white,size: 20,),),
                    style: TextStyle(
                        fontSize: 25,
                        color: Colors.white
                    ),
                  ),
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(37, 41, 76, 1.0)
                  ),
                ),
              ),






              //Text(user!.email.toString()),
              /*TextButton(
              onPressed: (){
                _auth=FirebaseAuth.instance;
                _auth.signOut();
                Navigator.pop(context);},
              child: Text("Log Out"),
            )*/
            ],
          ),
        )
    );
  }
}