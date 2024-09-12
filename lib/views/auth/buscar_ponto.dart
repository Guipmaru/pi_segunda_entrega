import 'package:flutter/material.dart'; 
import 'package:pi_segunda_entrega/views/home/homepage.dart'; 
import 'package:pi_segunda_entrega/data/database_helper.dart';

class BuscarPonto extends StatelessWidget {
  const BuscarPonto({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pontos de doação'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Locais de doação',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Aqui vai ser mostrado os locais de pontos de doação
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