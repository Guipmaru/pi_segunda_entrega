import 'package:flutter/material.dart';
import 'iniciando_a_homepage.dart'; 
import 'package:pi_segunda_entrega/data/database_helper.dart';

class TelaPerfil extends StatelessWidget {
  const TelaPerfil({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Dados pessoais',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // salvar os dados do formulário (falta implementar)
                Navigator.pop(context); // Volta para a tela anterior (Homepage)
              },
              child: const Text('voltar'),
            ),
          ],
        ),
      ),
    );
  }
}