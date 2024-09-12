import 'package:flutter/material.dart';
import 'views/auth/login_screen.dart';
import 'package:pi_segunda_entrega/data/database_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Chama a função para resetar o banco de dados (exclui o banco atual, comentar depois de usar)
 // await resetDatabase(); 

  runApp(MyApp());
}
// Tela inicial configurada para LoginScreen
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: LoginScreen(), 
    );
  }
}