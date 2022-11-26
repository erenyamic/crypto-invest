

import 'package:cryptoinvest/create_account.dart';
import 'package:cryptoinvest/google_sign_in.dart';
import 'package:cryptoinvest/home_page.dart';
import 'package:cryptoinvest/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());

}

class MyApp extends StatelessWidget {
   MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) =>ChangeNotifierProvider(
      create: (context)=> GoogleSignInProvider(),
    child: MaterialApp(
      title: 'Crypto Invest',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  MyHomePage(title: 'Crypto Invest'),
      debugShowCheckedModeBanner: false,
    ),
   );

}

class MyHomePage extends StatefulWidget {
   MyHomePage({Key? key, required this.title}) : super(key: key);



  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late FirebaseAuth _auth;
  var home=home_page();
  var create_account=CreateAccount();
  @override
  void initState() {
    // TODO: implement initState
    _auth=FirebaseAuth.instance;
    /*try{
      if(_auth.currentUser!=null)
        Navigator.push( context,MaterialPageRoute(builder: (context)=>home));
    }on Exception catch(exception){

    }*/
    _auth.authStateChanges().listen((User? user){
      if(user!=null)
        Navigator.push(context, MaterialPageRoute(builder: (context)=>home_page()));
    });

  }

  void signInWithGoogle(){
    final provider=Provider.of<GoogleSignInProvider>(context,listen: false);
    provider.googleLogin(context);

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar(
        title: Text("Merhaba"),
      ),*/
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(padding: EdgeInsets.fromLTRB(50.0, 5.0, 50.0, 5.0),
              child: ElevatedButton(
                onPressed: signInWithGoogle,
                child: Row(mainAxisAlignment: MainAxisAlignment.center,children: [
                  Image.network(
                      'http://pngimg.com/uploads/google/google_PNG19635.png',
                    width: 50,
                    height: 50,
                  ),
                  Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 50)),
                  Text("Sign In with Google"),
                ],),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.white),
                  //padding: MaterialStateProperty.all(EdgeInsets.fromLTRB(10, 5, 10, 5)),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  )),
                  foregroundColor: MaterialStateProperty.all(Color.fromRGBO(1, 101, 223,1.0)),
                ),
              ),),

            Padding(padding: EdgeInsets.fromLTRB(50.0, 5.0, 50.0, 5.0),
              child: ElevatedButton(
                onPressed: (){Navigator.push(context, MaterialPageRoute(builder:(context)=>create_account));},
                child: Row(mainAxisAlignment: MainAxisAlignment.center,children: [
                  Icon(Icons.account_circle,color: Colors.black,size:40),
                  Padding(padding: EdgeInsets.fromLTRB(0, 0, 5, 10)),
                  Text("Create Account"),
                ],),
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(EdgeInsets.fromLTRB(0, 5, 0,5 )),
                  backgroundColor: MaterialStateProperty.all(Colors.white),
                  //padding: MaterialStateProperty.all(EdgeInsets.fromLTRB(75, 22, 75, 22)),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0))),
                  foregroundColor: MaterialStateProperty.all(Color.fromRGBO(1, 101, 223, 1.0)),
                ),
              ),),
            Padding(padding: EdgeInsets.symmetric(vertical: 5,horizontal: 36),child: TextButton(
              child: Text("Log In"),
              onPressed: (){Navigator.push(context,MaterialPageRoute(builder:(context)=>easy_login()));},
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all(Colors.white),
                textStyle: MaterialStateProperty.all(TextStyle(decoration: TextDecoration.underline))
              ),
            ),),
          ],
        ),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("lib/img/bg2.png"),
            fit: BoxFit.cover,
          ),
        ),
      )
    );
  }
}
/*class home_page extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final user=FirebaseAuth.instance.currentUser;
    // TODO: implement build
    return Scaffold(
      body: Center(
        child: Text(user!.email.toString()),
      ),
    );
  }

}*/
