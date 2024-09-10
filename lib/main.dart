import 'package:flutter/material.dart';
import 'esqueceu_senha.dart'; 
import 'iniciando_a_homepage.dart';
import 'package:pi_segunda_entrega/data/database_helper.dart'; 
import 'cadastro_aluno.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //nome da tela de login definida como tela inicial
      home: LoginScreen(), 
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Controlador para o campo de email
  final _emailController = TextEditingController(); 
  // Controlador para o campo de senha
  final _passwordController = TextEditingController(); 
  // Chave para o formulário
  final _formKey = GlobalKey<FormState>(); 
  // Armazena a mensagem de erro
  String _errorMessage = ''; 

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
      // Limpa a mensagem de erro
      _errorMessage = ''; 
      // Limpa o campo de email
      _emailController.clear(); 
      // Limpa o campo de senha
      _passwordController.clear(); 
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
                        //texto que indica para digitar email
                        hintText: 'Digite seu Email',
                        prefixIcon: Icon(Icons.email),
                        border: OutlineInputBorder(),

                        filled: true,
                        fillColor: Colors.white,
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
                      // Para ocultar a senha
                      obscureText: true, 
                      decoration: InputDecoration(
                        labelText: 'Senha',
                        hintText: 'Digite sua senha',
                        prefixIcon: Icon(Icons.password),
                        border: OutlineInputBorder(),

                        filled: true,
                        fillColor: Colors.white,
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
                      onPressed: _login, 
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
                              // tela de Esqueceu sua senha?
                              builder: (context) => SegundaTela(), 
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
                              // tela de cadastro
                              builder: (context) => CadastroAluno(), 
                            ),
                          );
                        },
                        child: Text(
                          'Cadastre-se',
                          style: TextStyle(color: Color.fromARGB(255, 81, 177, 84)), 
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