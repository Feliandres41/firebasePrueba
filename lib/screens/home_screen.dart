import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget{
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<void> datos ()async{
    final snapshot = await FirebaseFirestore.instance
    .collection("usuarios")
    .get();


    for (var doc in snapshot.docs) {

      print(doc.data());
      print(doc.id);

    }
  }

//   Future<void> registrarUsuario() async {

//   UserCredential resultado =
//       await FirebaseAuth.instance
//           .createUserWithEmailAndPassword(
            
//             email: "andres@gmail.com",

//             password: "12345678",
//           );


//   User usuario = resultado.user!;


//   await FirebaseFirestore.instance
//       .collection("usuarios")
//       .doc(usuario.uid)
//       .set({

//         "nombre": "Andres",

//         "edad": 20,

//         "email": usuario.email,

//       });


// }
  @override
  Widget build(BuildContext context) {
    // datos();
    // registrarUsuario();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Pantalla principal"),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.
        collection("usuarios").snapshots(), 
        builder: (context, snapshot) {
          if(!snapshot.hasData){
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final datos = snapshot.data!.docs;
          return ListView.builder(
            itemCount: datos.length,
            itemBuilder: (context, index) => 
            Text(
              "dato: ${datos[index]["nombre"]} ${datos[index]["edad"]}\nDatos generales\n ${datos[index]}"
            ),
          );
        },),
    );
  }
}