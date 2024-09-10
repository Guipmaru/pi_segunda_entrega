import 'package:flutter/material.dart';
import 'esqueceu_senha.dart'; 
import 'iniciando_a_homepage.dart';
import 'package:pi_segunda_entrega/data/database_helper.dart'; // Importa o DatabaseHelper para interação com o banco de dados
import 'cadastro_aluno.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginScreen(), //nome da tela de login definida como tela inicial
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController(); // Controlador para o campo de email
  final _passwordController = TextEditingController(); // Controlador para o campo de senha
  final _formKey = GlobalKey<FormState>(); // Chave para o formulário
  String _errorMessage = ''; // Armazena a mensagem de erro

  Future<void> _login() async {
    String email = _emailController.text;
    String password = _passwordController.text;

    if (_formKey.currentState!.validate()) {
      // Verifica as credenciais no banco de dados
      var user = await DatabaseHelper().getUser(email, password);

      if (user != null) {
        // Usuário encontrado, navega para a homepage
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Homepage()),
        );
      } else {
        // Usuário ou senha incorretos, exibe a mensagem de erro
        setState(() {
          _errorMessage = 'Usuário ou senha incorretos';
        });
      }
    }
  }

  void _clearError() {
    setState(() {
      _errorMessage = ''; // Limpa a mensagem de erro
      _emailController.clear(); // Limpa o campo de email
      _passwordController.clear(); // Limpa o campo de senha
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 208, 241, 209),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Login',
            style: TextStyle(
              fontSize: 35,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),

          //Campo para email
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        hintText: 'Digite seu Email',
                        prefixIcon: Icon(Icons.email),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, insira o email';
                        }
                        return null;
                      },
                    ),
                  ),

                  //Espaço entre componentes
                  SizedBox(height: 30),

                  //Campo para senha
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: TextFormField(
                      controller: _passwordController,
                      obscureText: true, // Para ocultar a senha
                      decoration: InputDecoration(
                        labelText: 'Senha',
                        hintText: 'Digite sua senha',
                        prefixIcon: Icon(Icons.password),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, insira a senha';
                        }
                        return null;
                      },
                    ),
                  ),

                  //Espaço entre componentes
                  SizedBox(height: 30),

                  // Exibe mensagem de erro se houver
                  if (_errorMessage.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: Column(
                        children: [
                          Text(
                            _errorMessage,
                            style: TextStyle(color: Colors.red, fontSize: 16),
                          ),
                          ElevatedButton(
                            onPressed: _clearError,
                            child: Text('OK'),
                          ),
                        ],
                      ),
                    ),

                  //Botão para confirmar login
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 100),
                    child: MaterialButton(
                      minWidth: double.infinity,
                      onPressed: _login, // Chama o método de login
                      color: const Color.fromARGB(255, 81, 177, 84),
                      textColor: Colors.white,
                      child: Text('Entrar'),
                    ),
                  ),

                  //Texto clicável para ir para outra tela
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Texto "Esqueceu sua senha?"
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SegundaTela(), // tela de "Esqueceu sua senha?"
                            ),
                          );
                        },
                        child: Text('Esqueceu sua senha?'),
                      ),
                      
                      // Espaço entre os textos
                      SizedBox(width: 10),

                      // Texto "Cadastre-se"
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CadastroAluno(), // tela de cadastro
                            ),
                          );
                        },
                        child: Text(
                          'Cadastre-se',
                          style: TextStyle(color: Color.fromARGB(255, 81, 177, 84)), // cor do botão "Entrar"
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}