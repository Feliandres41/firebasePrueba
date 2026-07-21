import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _email = TextEditingController();
  final _password = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _email.dispose();
    _password.dispose();
  }

  @override
  Widget build(context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              'Firebase',
              style: TextStyle(
                fontSize: width * 0.1,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(height: height * 0.05),
          SizedBox(
            width: width * 0.8,
            child: TextField(
              controller: _email,
              onTapOutside: (event) =>
                  FocusManager.instance.primaryFocus?.unfocus(),
              decoration: InputDecoration(
                label: Row(
                  spacing: 10,
                  children: [Icon(Icons.person), Text('Correo electronico')],
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          SizedBox(height: height * 0.05),
          Container(
            width: width * 0.8,
            child: TextField(
              obscureText: true,
              controller: _password,
              onTapOutside: (event) =>
                  FocusManager.instance.primaryFocus?.unfocus(),
              decoration: InputDecoration(
                label: Row(
                  spacing: 10,
                  children: [Icon(Icons.password), Text('Contrasena')],
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          SizedBox(height: height * 0.05),
          ElevatedButton(
            onPressed: () async {
              try {
                UserCredential? respuesta = await FirebaseAuth.instance
                    .signInWithEmailAndPassword(
                      email: _email.text,
                      password: _password.text,
                    );
                if (respuesta != null) {
                  print("Login exitoso");
                }
              } catch (e) {
                print("Credenciales incorrectas");
              }
            },
            style: ButtonStyle(
              elevation: MaterialStatePropertyAll(1),
              backgroundColor: MaterialStateColor.resolveWith(
                (states) => Colors.white,
              ),
            ),
            child: Text(
              "Iniciar sesion",
              style: TextStyle(color: Colors.black),
            ),
          ),
          SizedBox(height: height * 0.02),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "¿No tienes cuenta? ",
                style: TextStyle(color: Colors.black54),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/register');
                },
                child: Text(
                  "Registrate",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
