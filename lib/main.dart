import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_practica/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // FirebaseFirestore.instance.collection("usuarios")
  // .add({
  //   "nombre":"prueba",
  //   "edad":"1"
  // });
  // FirebaseAuth.instance.createUserWithEmailAndPassword(email: "zackxzaft@gmail.com", password: "123456789");
  final a = await FirebaseAuth.instance.signInWithEmailAndPassword(email: "zackxzaft@gmail.com", password: "123456789");
  print(a.user!);
  

  

  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home: HomeScreen()
    );
  }
}
