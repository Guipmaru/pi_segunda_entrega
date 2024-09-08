import 'package:flutter/material.dart';

class SegundaTela extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Esqueceu sua senha?'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context); // Voltar para a tela de login
          },
          child: Text('Voltar para login'),
        ),
      ),
    );
  }
}