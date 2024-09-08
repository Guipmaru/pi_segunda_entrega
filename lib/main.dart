// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'esqueceu_senha.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 178, 214, 180),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Login',
            style: TextStyle(
              fontSize: 35,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),),

            //Email
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: Form(child: 
              Column(
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
                      onChanged: (String value){
                                  
                      },
                      validator: (value){
                        return value!.isEmpty ? 'Por favor entre com o seu email' : null;
                      },
                    ),
                  ),

                  //Espaçamento
                  SizedBox(
                    height: 30,
                  ),

                  //Caixa de senha
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
                      onChanged: (String value){
                                  
                      },
                      validator: (value){
                        return value!.isEmpty ? 'Por favor entre com sua senha' : null;
                      },
                    ),
                  ),

                  //espaçamento
                  SizedBox(
                    height: 30,
                  ),

                  //Botão para confirmar a entrada no sistema
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 100),
                    child: MaterialButton(
                      minWidth: double.infinity,
                      onPressed: () {},
                      color: const Color.fromARGB(255, 81, 177, 84),
                      textColor: Colors.white,
                      child: Text('Entrar'),
                      )
                  ),
                  //Espaçamento
                  SizedBox(height: 20),

                  //Esqueceu a senha?
                  TextButton(
                    onPressed: () {
                      //Navegador
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SegundaTela()),
                        );
                    },
                    child: Text('Esqueceu sua senha?'),
                  ),
                ],
              )
              ),
            )
          ],
        ),
      ),
    );
  }
}
