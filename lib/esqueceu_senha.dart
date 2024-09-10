import 'package:flutter/material.dart';
//definição de nome de tela para chamada
class SegundaTela extends StatefulWidget {
  const SegundaTela({super.key});

  @override
  _SegundaTelaState createState() => _SegundaTelaState();
}

class _SegundaTelaState extends State<SegundaTela> {
  final _emailController = TextEditingController();

  void _showRecoveryDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confira sua caixa de entrada'),
          content: const Text('Instruções de recuperação de senha foram enviadas para o seu email.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Fecha o diálogo
                Navigator.pop(context); // Volta para a tela de login
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 208, 241, 209),
      appBar: AppBar(
        title: const Text('Esqueceu sua senha?'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Digite seu email para recuperação de senha',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: 'Digite seu Email',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, insira seu email';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            MaterialButton(
              minWidth: double.infinity,
              color: const Color.fromARGB(255, 81, 177, 84),
              textColor: Colors.white,
              child: const Text('Confirmar'),
              onPressed: () {
                if (_emailController.text.isNotEmpty) {
                  _showRecoveryDialog();
                } else {
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}