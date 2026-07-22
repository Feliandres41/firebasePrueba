import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import './screens/screens.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // FirebaseFirestore.instance.collection("usuarios")
  // .add({
  //   "nombre":"prueba",
  //   "edad":"1"
  // });
  // FirebaseAuth.instance.createUserWithEmailAndPassword(email: "zackxzaft@gmail.com", password: "123456789");
  // final a = await FirebaseAuth.instance.signInWithEmailAndPassword(email: "zackxzaft@gmail.com", password: "123456789");
  // print(a.user!);

  final user = FirebaseAuth.instance.currentUser;
  // FirebaseFirestore.instance.collection('estado').add({
  //                   'estado': 0,
  //                   'userId': user!.uid,
  //                   // 'fecha': FieldValue.serverTimestamp(),
  //                 });
  print(user?.uid);

  //editar
  // await FirebaseFirestore.instance.collection('estado').doc(user!.uid).update(
  //   {'estado': 1},
  // );
  await FirebaseAuth.instance.signOut();
  runApp(MyApp(id: user?.uid));
}

class MyApp extends StatelessWidget {
  MyApp({super.key, required this.id});
  String? id;

  @override
  Widget build(BuildContext context) {
    Widget principal = LoginScreen();
    try {
      if (id!.isNotEmpty) {
        principal = HomeScreen();
      } else {
        print("bien");
        principal = LoginScreen();
      }
    } catch (e) {
      print("mal");
      principal = LoginScreen();
    }
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      // home: HomeScreen()
      initialRoute: "/",

      routes: {
        '/': (context) => principal,
        '/register': (context) => RegisterScreen(),
        '/home': (context) => HomeScreen(),
      },
    );
  }
}
