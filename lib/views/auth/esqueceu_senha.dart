import 'package:flutter/material.dart';
import 'package:pi_segunda_entrega/data/database_helper.dart';  

class EsqueceuSenha extends StatefulWidget {
  const EsqueceuSenha({super.key});

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<EsqueceuSenha> {
  final _emailController = TextEditingController();
  final _dbHelper = DatabaseHelper();  

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
                Navigator.pop(context);  // Fecha o diálogo
                Navigator.pop(context);  // Volta para a tela de login
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Erro'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);  // Fecha o diálogo
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _confirmEmail() async {
    String email = _emailController.text.trim();
    
    if (email.isEmpty) {
      _showErrorDialog('Por favor, insira um email.');
      return;
    }

    // Verifica se o email existe no banco de dados
    bool emailExiste = await _dbHelper.emailExists(email);
    
    if (emailExiste) {
      _showRecoveryDialog();
    } else {
      _showErrorDialog('O email não foi encontrado. Verifique e tente novamente.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 238, 159, 155),
      appBar: AppBar(
        title: const Text('Esqueceu sua senha?'),
        backgroundColor: const Color.fromARGB(255, 212, 14, 14),
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
            ),
            const SizedBox(height: 20),
            MaterialButton(
              minWidth: double.infinity,
              color: const Color.fromARGB(255, 212, 14, 14),
              textColor: Colors.white,
              child: const Text('Confirmar'),
              onPressed: _confirmEmail,  // Chama a função de confirmação
            ),
          ],
        ),
      ),
    );
  }
}
