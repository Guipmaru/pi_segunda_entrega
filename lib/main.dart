// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'esqueceu_senha.dart'; 
import 'iniciando_a_homepage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginScreen(), //nome da tela de login definida como tela inicial
    );
  }
}

//construção da scaffold 
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 208, 241, 209),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Login',
            style: TextStyle(
              fontSize: 35,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),


          //Campo para email
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: Form(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        hintText: 'Digite seu Email',
                        prefixIcon: Icon(Icons.email),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),

                  //Espaço entre componentes
                  SizedBox(height: 30),

                  //Campo para senha
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: TextFormField(
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        labelText: 'Senha',
                        hintText: 'Digite sua senha',
                        prefixIcon: Icon(Icons.password),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),

                  //Espaço entre componentes
                  SizedBox(height: 30),

                  //Botão para confirmar login
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 100),
                    child: MaterialButton(
                      minWidth: double.infinity,
                      onPressed: () {
                        //Navega para homepage
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: 
                          (context)=> Homepage())
                          );
                      },
                      color: const Color.fromARGB(255, 81, 177, 84),
                      textColor: Colors.white,
                      child: Text('Entrar'),
                    ),
                  ),
                  SizedBox(height: 20),
               

                  //Texto clicável para ir para outra tela
                  TextButton(
                    onPressed: () {
                      // Navega para a SegundaTela (Esqueceu a Senha)
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SegundaTela(),
                        ),
                      );
                    },
                    child: Text('Esqueceu sua senha?'),
                  ),


                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}