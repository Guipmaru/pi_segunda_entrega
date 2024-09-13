  import 'package:flutter/material.dart';
  import 'views/auth/login_screen.dart';
  import 'views/home/homepage.dart'; 
  import 'package:pi_segunda_entrega/data/database_helper.dart';

  void main() async {
    WidgetsFlutterBinding.ensureInitialized();

    // Chama a função para resetar o banco de dados (exclui o banco atual, comentar depois de usar)
    //await resetDatabase(); 

    runApp(MyApp());
  }

  class MyApp extends StatelessWidget {
    const MyApp({super.key});

    @override
    Widget build(BuildContext context) {
      return MaterialApp(
        // Define a tela inicial como LoginScreen
        initialRoute: '/',
        routes: {
          '/': (context) => LoginScreen(),
          '/homepage': (context) => Homepage(), // Tela inicial após login
        },
      );
    }
  }