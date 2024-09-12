import 'package:flutter/material.dart';
import 'package:pi_segunda_entrega/data/database_helper.dart';

//Decleração de classe
class TelaFormulario extends StatelessWidget {
  const TelaFormulario({super.key});

//criação do scaffold
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulário de Doação'),
      ),

      //criação do corpo do código
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Preencha seu formulário de doação',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // fazer o formulário de doação
                Navigator.pop(context); // Volta para a tela anterior (Homepage)
              },
              child: const Text('Voltar para a Home'),
            ),
          ],
        ),
      ),
    );
  }
}