import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<void> datos() async {
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
    final user = FirebaseAuth.instance.currentUser;
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text("Pantalla principal")),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("usuarios")
            // .where("userId", isEqualTo: user!.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          final datos = snapshot.data!.docs;
          return Column(
            children: [
              Flexible(
                child: ListView.builder(
                  itemCount: datos.length,
                  itemBuilder: (context, index) => Container(
                    width: width * 0.9,
                    child: Center(
                      child: Card(
                        child: SizedBox(
                          width: width * 0.9,
                          height: height * 0.05,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            spacing: width * 0.1,
                            children: [
                              // Text(
                              //   "dato: ${datos[index]["nombre"]} ${datos[index]["edad"]}\nDatos generales\n ${datos[index]}",
                              // ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [Icon(Icons.person)],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                spacing: width * 0.02,
                                children: [
                                  Text(
                                    "Nombre:",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: width * 0.04,
                                    ),
                                  ),
                                  Text(
                                    "${datos[index]["nombre"]}",
                                    style: TextStyle(fontSize: width * 0.04),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                spacing: width * 0.02,
                                children: [
                                  Text(
                                    "Edad:",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: width * 0.04,
                                    ),
                                  ),
                                  Text(
                                    "${datos[index]["nombre"]}",
                                    style: TextStyle(fontSize: width * 0.04),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  final user = FirebaseAuth.instance.currentUser;

                  if (user == null) {
                    // No hay usuario autenticado
                    return;
                  }

                  final uid = user.uid;
                  await FirebaseFirestore.instance.collection('usuarios').add({
                    'nombre': 'A',
                    'edad': '20',
                    'userId': uid,
                    // 'fecha': FieldValue.serverTimestamp(),
                  });
                },
                child: Text("___"),
              ),
            ],
          );
        },
      ),
    );
  }
}
