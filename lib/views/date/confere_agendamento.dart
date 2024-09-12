import 'package:flutter/material.dart'; 
import 'package:pi_segunda_entrega/data/database_helper.dart';

class ConfereAgendamento extends StatelessWidget {
  const ConfereAgendamento({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agendamentos'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Agendamentos',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Aqui vai ser salvo os dados do formulário
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