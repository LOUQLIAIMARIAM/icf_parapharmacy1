import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:icf_parapharmacy1/notification/firebase_api.dart';
import 'package:icf_parapharmacy1/phoneVerification.dart';
import 'homepage.dart';
import 'homescreen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
        apiKey: 'AIzaSyCB5XaTaKfXeFXO-ovZ-r0B3DURctO0uEo',
        appId: '1:523363079393:android:824c2bc934b844855e93a0',
        messagingSenderId: '523363079393',
        projectId: 'icfp-30f1f'),
  );

  // await FirebaseApi().initNotification();

  runApp(MaterialApp(
    initialRoute: 'phone',
    debugShowCheckedModeBanner: false,
    routes: {
      'phone': (context) => MyPhone(),
      'verify': (context) => MyVerify(),
      'home': (context) => HomeScreen(),

    },
  ));
}




