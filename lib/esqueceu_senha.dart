import 'package:flutter/material.dart';

class SegundaTela extends StatelessWidget{
  const SegundaTela({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Esqueceu sua senha?'),
        actions: [
          ElevatedButton(
            onPressed: (){
              Navigator.pop(context);
            },
            child: const Text('Voltar para login', 
            style: TextStyle(color: Colors.white),
            ),
            )
        ],
      ),
    );
  }
}