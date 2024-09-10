import 'package:flutter/material.dart';

class SegundaTela extends StatelessWidget {
  const SegundaTela({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 208, 241, 209),
      appBar: AppBar(
        title: const Text('Esqueceu sua senha?'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context); // Voltar para a tela de login
          },
          child: const Text('Voltar para login'),
        ),
      ),
    );
  }
}