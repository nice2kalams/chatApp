import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:frist_project/homepage.dart';
import 'signup.dart';
import 'login.dart';
import 'package:flutter/material.dart';
import 'compleatprofile.dart';
import 'usermodel.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options:const FirebaseOptions(
        apiKey: "AIzaSyCkdOZb4VojUBCoF9HB0omZJkImIyUx-X0",
        appId: "1:886948523348:android:b11bb82248697c89f0acc1",
        messagingSenderId: "886948523348",
        projectId:"flutter-chat-app-e167e"
    ),
  );
  User? current_user = FirebaseAuth.instance.currentUser;
  if(current_user==null){
    runApp(MyApp());
  }else{
    String userid=current_user.uid;
    DocumentSnapshot data=await FirebaseFirestore.instance.collection("user").
    doc(userid).get();
    UserModel usermodel2=UserModel.fromMap(data.data() as Map<String , dynamic>);
    runApp(MyAppLogged(usermodel: usermodel2,firebaseuser: current_user));
  }


}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:  LoginPage(),
    );
  }
}

class MyAppLogged extends StatelessWidget {
  final UserModel usermodel;
  final User firebaseuser;
  MyAppLogged({required this.usermodel,required this.firebaseuser});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:  homepage(usermodel: usermodel, firebaseuser: firebaseuser),
    );
  }
}



//Image.asset("assets/image/bg.jpg",fit: BoxFit.cover,alignment: Alignment.center,)
