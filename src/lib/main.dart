import 'package:flutter/material.dart';
import 'package:food_feup/controller/local_storage/app_user_database.dart';
import 'package:food_feup/view/login_page_view.dart';
import 'package:food_feup/model/user.dart';
import 'dart:async';


Future<void> main() async {
  runApp(const MyApp());
  AppUserDatabase userDatabase = AppUserDatabase();
  await userDatabase.initializeDatabase();
  User u = User(userNumber: "00", passWord: "00");
  print("here4");
  userDatabase.insertUser(u);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food FEUP',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.red,
      ),
      home: const LogInPage(title: 'Food Feup'),
    );
  }
}
