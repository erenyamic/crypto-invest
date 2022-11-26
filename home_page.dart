import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cryptoinvest/charts.dart';
import 'package:cryptoinvest/main.dart';
import 'package:cryptoinvest/profilePage.dart';
import 'package:cryptoinvest/settingsPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';
import 'package:cryptoinvest/jsonclass.dart';





class home_page extends StatefulWidget {
   home_page({Key? key}) : super(key: key);

  @override
  State createState() => home_page2();
}

class home_page2 extends State {
  var db;var balance=0;
  var contol_balance=TextEditingController();
  late FirebaseFirestore _firestore;
  late FirebaseAuth _auth;
  var _userSubscribe;
  var ref=FirebaseDatabase.instance.ref().child("users");
  @override
  void initState(){
    _firestore=FirebaseFirestore.instance;
    _auth=FirebaseAuth.instance;
contol_balance.text="********";

  }
Future getBalance() async{
  /*db=FirebaseFirestore.instance;
  var _userDoc=await db.collection("users").get();
  for (var eleman in _userDoc.docs){
    Map userMap=eleman.data();
    if(userMap.containsValue(FirebaseAuth.instance.currentUser?.email.toString())){
      balance=int.parse(userMap["balance"].toString());
    }*/
   /*var _userStream = await _firestore.collection("users").snapshots();
    _userSubscribe=_userStream.listen((event) {
      event.docs.forEach((element) {
        Map map=element.data();
        if(map.containsValue(_auth.currentUser!.email.toString())){
          balance=int.parse(map['balance'].toString());
        }
      });
    });*/


  ref.onValue.listen((event) {
    var deger1=event.snapshot.value as dynamic;
    if(deger1!=null){
      deger1.forEach((key,nesne){
        var deger2=vt.fromJson(nesne);
        if(_auth.currentUser?.email==deger2.email){
          balance=int.parse(deger2.balance.toString());
        }
      });
    }
  });
contol_balance.text=NumberFormat.simpleCurrency(locale: "en_US",decimalDigits: 2).format(balance);
  }
  //print(balance.toString());
//}
  /*@override
  void dispose() {
    super.dispose();
  }*/

  @override
  Widget build(BuildContext context) {
    //final user=FirebaseAuth.instance.currentUser;
    //late FirebaseAuth _auth;
//Navigator.push(context, MaterialPageRoute(builder: (context)=>home_page()));

    getBalance();
    contol_balance.text="********";
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text("Home"),centerTitle: true,
          backgroundColor: Color.fromRGBO(37, 41, 76, 1.0),
          foregroundColor: Colors.white,
        ),
        bottomNavigationBar: Container(color: Color.fromRGBO(37, 41, 76, 1.0),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 15.0),
            child: GNav(gap: 8,
                backgroundColor: Color.fromRGBO(37, 41, 76, 1.0),color: Colors.white,activeColor: Colors.white,tabBackgroundColor: Color.fromRGBO(30, 33, 64, 1.0),
                padding: EdgeInsets.all(16),
                tabs: [
                  GButton(icon: Icons.home,text: "Home",onPressed: (){
                  },),
                  GButton(icon: FontAwesomeIcons.chartLine,text: "Chart",onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>charts(say1: 1)));
                  },),
                  GButton(icon: Icons.settings,text: "Settings",onPressed: (){
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (BuildContext context){
                      return SettingsPage();
                    }),(route)=>false);
                  },),
                  GButton(icon: Icons.account_circle,text: "Profile",onPressed:(){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfilePage()));
                  }),
                ]),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            width: double.infinity,color: Color.fromRGBO(30, 33, 64, 1.0),
            child: Column(
              children: [
                Padding(padding: EdgeInsets.symmetric(vertical: 20,horizontal: 30),
                  child: InkWell(
                    onTap: (){getBalance();},onDoubleTap: (){
                      contol_balance.text="********";
                  },
                   child: Container(
                     padding: EdgeInsets.symmetric(vertical: 20,horizontal: 10),
                     width: double.infinity,
                     child:
                     Column(
                       children:<Widget> [
                         Align(child: Text("Total Assets Balance",style: TextStyle(color: Colors.grey.shade200),),alignment: Alignment.centerLeft,),
                         Align(child: Padding(padding: EdgeInsets.fromLTRB(0,10,0,0),child:
                         TextField(enabled: false,
                         controller: contol_balance,
                         decoration: InputDecoration(border: InputBorder.none,suffixIcon: Icon(FontAwesomeIcons.eye,color: Colors.white,size: 20,),),
                         style: TextStyle(
                             fontSize: 25,
                             color: Colors.white
                         ),
                           ),
                         ),alignment: Alignment.centerLeft,),
                       ],),


                     decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(10),
                       color: Color.fromRGBO(37, 41, 76, 1.0),
                       //border: Border.all(color: Colors.white),
                     ),
                   ),
                  )
                ),
                Padding(padding: EdgeInsets.symmetric(vertical: 15,horizontal: 30),
                    child: Align(child: Text("Favorites",
                      style: TextStyle(color: Colors.white,fontSize: 17),
                    ),alignment: Alignment.centerLeft,)
                ),

                Padding(padding: EdgeInsets.symmetric(vertical: 5,horizontal: 30),
                    child: InkWell(onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>charts(say1:1)));
                    },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 20,horizontal: 10),
                        width: double.infinity,
                        child:
                        Column(
                          children:<Widget> [
                            Align(child: Text("Bitcoin",style: TextStyle(color: Colors.grey.shade200),),alignment: Alignment.centerLeft,),
                            Padding(padding: EdgeInsets.fromLTRB(0,10,0,0),child:
                            Row(
                              children: [
                                Padding(padding: EdgeInsets.symmetric(horizontal: 10),child:
                                Container(
                                  width: 30,height: 30,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage("lib/img/btc.png"),
                                          fit: BoxFit.cover
                                      ),shape: BoxShape.circle
                                  ),
                                ),
                                ),
                                Padding(padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: Text("BTC/USD",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),),

                                ),
                                Padding(padding: EdgeInsets.symmetric(horizontal: 10),child:
                                Text(NumberFormat.simpleCurrency(locale: "en_US",decimalDigits: 2).format(19674),
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white
                                  ),),
                                )
                              ],
                            ),
                            ),
                          ],),


                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color.fromRGBO(37, 41, 76, 1.0),
                          //border: Border.all(color: Colors.white),
                        ),
                      ),
                    )
                ),

                Padding(padding: EdgeInsets.symmetric(vertical: 5,horizontal: 30),
                    child: InkWell(
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>charts(say1: 2)));
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 20,horizontal: 10),
                        width: double.infinity,
                        child:
                        Column(
                          children:<Widget> [
                            Align(child: Text("Ethereum",style: TextStyle(color: Colors.grey.shade200),),alignment: Alignment.centerLeft,),
                            Padding(padding: EdgeInsets.fromLTRB(0,10,0,0),child:
                            Row(
                              children: [
                                Padding(padding: EdgeInsets.symmetric(horizontal: 10),child:
                                Container(
                                  width: 30,height: 30,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage("lib/img/eth.png"),
                                          fit: BoxFit.cover
                                      ),shape: BoxShape.circle
                                  ),
                                ),
                                ),
                                Padding(padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: Text("ETH/USD",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),),

                                ),
                                Padding(padding: EdgeInsets.symmetric(horizontal: 10),child:
                                Text(NumberFormat.simpleCurrency(locale: "en_US",decimalDigits: 2).format(1417),
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white
                                  ),),
                                )
                              ],
                            ),
                            ),
                          ],),


                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color.fromRGBO(37, 41, 76, 1.0),
                          //border: Border.all(color: Colors.white),
                        ),
                      ),
                    )
                ),
                Padding(padding: EdgeInsets.symmetric(vertical: 5,horizontal: 30),
                    child: InkWell(
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>charts(say1: 3)));
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 20,horizontal: 10),
                        width: double.infinity,
                        child:
                        Column(
                          children:<Widget> [
                            Align(child: Text("Binance Coin",style: TextStyle(color: Colors.grey.shade200),),alignment: Alignment.centerLeft,),
                            Padding(padding: EdgeInsets.fromLTRB(0,10,0,0),child:
                            Row(
                              children: [
                                Padding(padding: EdgeInsets.symmetric(horizontal: 10),child:
                                Container(
                                  width: 30,height: 30,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage("lib/img/bnb.png"),
                                          fit: BoxFit.cover
                                      ),shape: BoxShape.circle
                                  ),
                                ),
                                ),
                                Padding(padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: Text("BNB/USD",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),),

                                ),
                                Padding(padding: EdgeInsets.symmetric(horizontal: 10),child:
                                Text(NumberFormat.simpleCurrency(locale: "en_US",decimalDigits: 2).format(278),
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white
                                  ),),
                                )
                              ],
                            ),
                            ),
                          ],),


                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color.fromRGBO(37, 41, 76, 1.0),
                          //border: Border.all(color: Colors.white),
                        ),
                      ),
                    )
                ),
                Padding(padding: EdgeInsets.symmetric(vertical: 5,horizontal: 30),
                    child: InkWell(
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>charts(say1: 4)));
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 20,horizontal: 10),
                        width: double.infinity,
                        child:
                        Column(
                          children:<Widget> [
                            Align(child: Text("Tether",style: TextStyle(color: Colors.grey.shade200),),alignment: Alignment.centerLeft,),
                            Padding(padding: EdgeInsets.fromLTRB(0,10,0,0),child:
                            Row(
                              children: [
                                Padding(padding: EdgeInsets.symmetric(horizontal: 10),child:
                                Container(
                                  width: 30,height: 30,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage("lib/img/tether.png"),
                                          fit: BoxFit.cover
                                      ),shape: BoxShape.circle
                                  ),
                                ),
                                ),
                                Padding(padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: Text("USDT/TRY",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),),

                                ),
                                Padding(padding: EdgeInsets.symmetric(horizontal: 10),child:
                                Text(NumberFormat.simpleCurrency(locale: "en_US",decimalDigits: 2).format(18.5),
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white
                                  ),),
                                )
                              ],
                            ),
                            ),
                          ],),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color.fromRGBO(37, 41, 76, 1.0),
                          //border: Border.all(color: Colors.white),
                        ),
                      ),
                    )
                ),

                Padding(padding: EdgeInsets.symmetric(vertical: 5,horizontal: 30),
                    child: InkWell(
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>charts(say1: 5)));
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 20,horizontal: 10),
                        width: double.infinity,
                        child:
                        Column(
                          children:<Widget> [
                            Align(child: Text("Binance Dollar",style: TextStyle(color: Colors.grey.shade200),),alignment: Alignment.centerLeft,),
                            Padding(padding: EdgeInsets.fromLTRB(0,10,0,0),child:
                            Row(
                              children: [
                                Padding(padding: EdgeInsets.symmetric(horizontal: 10),child:
                                Container(
                                  width: 30,height: 30,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage("lib/img/busd.png"),
                                          fit: BoxFit.cover
                                      ),shape: BoxShape.circle
                                  ),
                                ),
                                ),
                                Padding(padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: Text("BUSD/TRY",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),),

                                ),
                                Padding(padding: EdgeInsets.symmetric(horizontal: 10),child:
                                Text(NumberFormat.simpleCurrency(locale: "en_US",decimalDigits: 2).format(18.3),
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white
                                  ),),
                                )
                              ],
                            ),
                            ),



                          ],),


                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color.fromRGBO(37, 41, 76, 1.0),
                          //border: Border.all(color: Colors.white),
                        ),
                      ),
                    )
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
          ),
        )
    );
  }
}





