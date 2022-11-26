import 'package:cryptoinvest/charts.dart';
import 'package:cryptoinvest/home_page.dart';
import 'package:cryptoinvest/main.dart';
import 'package:cryptoinvest/settingsPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:cryptoinvest/jsonclass.dart';
import 'package:intl/intl.dart';

class ProfilePage extends StatelessWidget{
  var name_c=TextEditingController();
  var email_c=TextEditingController();
  var balance_c=TextEditingController();
  var ref=FirebaseDatabase.instance.ref().child("users");
  bool isEmailVerified=false;
  var userId,email_,name_,balance_;

  Future sendVerification() async{
    final user= FirebaseAuth.instance.currentUser!;
    await user.sendEmailVerification();
  }
  Future checkEmailVerified()async{
    await FirebaseAuth.instance.currentUser!.reload();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final user=FirebaseAuth.instance.currentUser;
    late FirebaseAuth _auth;
    name_c.text="****";
    email_c.text="****";
    balance_c.text="****";

    ref.onValue.listen((event) async{
      var deger1=event.snapshot.value as dynamic;
      if(deger1!=null){
        await deger1.forEach((key,nesne){
          var deger2=vt.fromJson(nesne);
          if(FirebaseAuth.instance.currentUser?.email==deger2.email){
            userId=key.toString();
            email_="Email: "+deger2.email.toString();
            name_="Name: "+deger2.name.toString();
            balance_="Balance: "+NumberFormat.simpleCurrency(locale: "en_US",decimalDigits: 2).format(int.parse(deger2.balance.toString()));
          }
        });
      }
    });

    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text("Profile"),centerTitle: true,
          backgroundColor: Color.fromRGBO(37, 41, 76, 1.0),
          foregroundColor: Colors.white,
        ),
        bottomNavigationBar: Container(color: Color.fromRGBO(37, 41, 76, 1.0),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 15.0),
            child: GNav(gap: 8,selectedIndex: 3,
                backgroundColor: Color.fromRGBO(37, 41, 76, 1.0),color: Colors.white,activeColor: Colors.white,tabBackgroundColor: Color.fromRGBO(30, 33, 64, 1.0),
                padding: EdgeInsets.all(16),
                tabs: [
                  GButton(icon: Icons.home,text: "Home",onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>home_page()));
                  },),
                  GButton(icon: FontAwesomeIcons.chartLine,text: "Chart",onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>charts(say1: 1)));
                  },),
                  GButton(icon: Icons.settings,text: "Settings",onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>SettingsPage()));
                  },),
                  GButton(icon: Icons.account_circle,text: "Profile",),
                ]),
          ),
        ),
        body: Container(
          width: double.infinity,color: Color.fromRGBO(30, 33, 64, 1.0),
          child: Column(
            children: [
              Padding(padding: EdgeInsets.symmetric(vertical: 15,horizontal: 36),child:
              InkWell(
                onTap: (){
                  ref.onValue.listen((event) async{
                    var deger1=event.snapshot.value as dynamic;
                    if(deger1!=null){
                      await deger1.forEach((key,nesne){
                        var deger2=vt.fromJson(nesne);
                        if(FirebaseAuth.instance.currentUser?.email==deger2.email){
                          userId=key.toString();
                          email_="Email: "+deger2.email.toString();
                          name_="Name: "+deger2.name.toString();
                          balance_="Balance: "+NumberFormat.simpleCurrency(locale: "en_US",decimalDigits: 2).format(int.parse(deger2.balance.toString()));

                        }
                      });
                    }
                  });
                  email_c.text=email_;
                  name_c.text=name_;
                  balance_c.text=balance_;
                },onDoubleTap: (){
                  email_c.text="****";
                  name_c.text="****";
                  balance_c.text="****";
              },
                child: Container(
                  width: 150,height: 150,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("lib/img/profile.png"),
                        fit:BoxFit.cover
                    ),shape: BoxShape.circle,border: Border.all(color: Color.fromRGBO(37, 41, 76, 1.0),width: 10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                ),
              )
                ,),
              Padding(padding: EdgeInsets.symmetric(vertical: 10,horizontal: 36),child: Align(alignment: Alignment.centerLeft,child: Text("User info:",style: TextStyle(color: Colors.grey.shade400,fontWeight: FontWeight.bold),),),),

              Padding(padding: EdgeInsets.symmetric(vertical: 10,horizontal: 36),child:
              TextField(
                controller: name_c,
                enabled: false,

                decoration: InputDecoration(


                ),style: TextStyle(color: Colors.white,fontSize: 16),

              )
                ,),

              Padding(padding: EdgeInsets.symmetric(vertical: 10,horizontal: 36),child:
              TextField(
                controller: email_c,
                enabled: false,

                decoration: InputDecoration(


                ),style: TextStyle(color: Colors.white,fontSize: 16),

              )
                ,),

              Padding(padding: EdgeInsets.symmetric(vertical: 10,horizontal: 36),child:
              TextField(
                controller: balance_c,
                enabled: false,

                decoration: InputDecoration(


                ),style: TextStyle(color: Colors.white,fontSize: 16),

              )
                ,),
              Padding(padding: EdgeInsets.symmetric(vertical: 10,horizontal: 36),child: Text("Note: Click on the circle to see the information",style: TextStyle(color: Colors.grey.shade400),),),
              Padding(padding: EdgeInsets.symmetric(vertical: 15,horizontal: 36),child:
              ElevatedButton(
                child: Text("Verify Account"),
                onPressed: (){
                  isEmailVerified=FirebaseAuth.instance.currentUser!.emailVerified;
                  if(!isEmailVerified){
                    sendVerification();
                    showDialog(context: context, builder: (BuildContext){
                      return AlertDialog(
                        title: Text("A verification email has been sent to your email"),
                      );
                    });
                    checkEmailVerified();
                  }else{
                    final user=FirebaseAuth.instance.currentUser!;
                    if(user.emailVerified){
                      showDialog(context: context, builder: (BuildContext){
                        return AlertDialog(
                          title: Text("Email has already been verified"),
                        );
                      });
                    }
                  }
                },
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all(Colors.white),
                  backgroundColor: MaterialStateProperty.all(Color.fromRGBO(37, 41, 76, 1.0)),
                  padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 17,horizontal: 27))
                ),
              )
                ,)

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