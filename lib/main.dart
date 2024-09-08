// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

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
        backgroundColor: const Color.fromARGB(255, 208, 241, 209),
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
              
                  SizedBox(
                    height: 30,
                  ),
              
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

                  SizedBox(
                    height: 30,
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 100),
                    child: MaterialButton(
                      minWidth: double.infinity,
                      onPressed: () {},
                      color: const Color.fromARGB(255, 81, 177, 84),
                      textColor: Colors.white,
                      child: Text('Entrar'),
                    
                      ),
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
