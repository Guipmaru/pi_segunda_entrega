import 'package:flutter/material.dart';
import 'views/auth/login_screen.dart';

void main() {
  runApp(const MyApp());
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