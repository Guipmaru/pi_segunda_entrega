import 'package:flutter/material.dart';
import 'package:pi_segunda_entrega/data/database_helper.dart';

class CadastroUser extends StatefulWidget {
  const CadastroUser({super.key});

  @override
  CadastroUserState createState() => CadastroUserState();
}

// Controles para entradas de dados
class CadastroUserState extends State<CadastroUser> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _sobrenomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();
  final _confirmarSenhaController = TextEditingController();

  final DatabaseHelper _dbHelper = DatabaseHelper(); // Instância do banco de dados

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 238, 159, 155),
      appBar: AppBar(
        title: const Text('Cadastre-se'),
        backgroundColor: const Color.fromARGB(255, 212, 14, 14),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Campo Nome
              const Text('Nome', style: TextStyle(fontSize: 18)),
              const SizedBox(height: 10),
              TextFormField(
                controller: _nomeController,
                decoration: InputDecoration(
                  hintText: 'Digite seu Nome',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira seu nome';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // Campo Sobrenome
              const Text('Sobrenome', style: TextStyle(fontSize: 18)),
              const SizedBox(height: 10),
              TextFormField(
                controller: _sobrenomeController,
                decoration: InputDecoration(
                  hintText: 'Digite seu Sobrenome',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira seu sobrenome';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // Campo Email
              const Text('Email', style: TextStyle(fontSize: 18)),
              const SizedBox(height: 10),
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

              // Campo Senha
              const Text('Senha', style: TextStyle(fontSize: 18)),
              const SizedBox(height: 10),
              TextFormField(
                controller: _senhaController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Digite sua Senha',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira sua senha';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // Campo Confirmar Senha
              const Text('Confirme sua senha', style: TextStyle(fontSize: 18)),
              const SizedBox(height: 10),
              TextFormField(
                controller: _confirmarSenhaController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Confirme sua Senha',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
                validator: (value) {
                  if (value != _senhaController.text) {
                    return 'A confirmação de senha deve ser igual à senha';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),

              // Botão de Cadastrar
              MaterialButton(
                minWidth: double.infinity,
                color: const Color.fromARGB(255, 212, 14, 14),
                textColor: Colors.white,
                child: const Text('Cadastrar'),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    // Insere o usuário no banco de dados
                    await _dbHelper.insertUser(
                      _nomeController.text,
                      _sobrenomeController.text,
                      _emailController.text,
                      _senhaController.text,
                    );

                    // Verifica se o widget ainda está montado antes de usar o BuildContext
                    if (!mounted) return;

                    // Mostra mensagem de sucesso e atrasa a navegação
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Cadastro realizado com sucesso!')),
                    );

                    // Limpa os campos após o cadastro
                    _nomeController.clear();
                    _sobrenomeController.clear();
                    _emailController.clear();
                    _senhaController.clear();
                    _confirmarSenhaController.clear();

                    // Atraso para garantir que o SnackBar seja mostrado antes da navegação
                    await Future.delayed(const Duration(seconds: 2));
                    // Volta para a tela de login
                    Navigator.pop(context);
                  }
                }
              ),
            ],
          ),
        ),
      ),
    );
  }
}
