import 'package:flutter/material.dart';
import 'package:pi_segunda_entrega/confere_agendamento.dart';
import 'package:pi_segunda_entrega/data/database_helper.dart';
import 'formulario.dart';
import 'perfil.dart';
import 'confere_agendamento.dart';
import 'buscar_ponto.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  HomepageState createState() => HomepageState();
}

class HomepageState extends State<Homepage> {
  String firstName = '';
  String lastName = '';

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    var user = await DatabaseHelper().getUsuarioLogado();
    if (user != null) {
      setState(() {
        firstName = user['first_name'] ?? '';
        lastName = user['last_name'] ?? '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Pega a largura da tela e aplica 80%
    double screenWidth = MediaQuery.of(context).size.width * 0.8;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 190, 228, 191),
      appBar: AppBar(
        title: const Text('Bem-vindo'),
        backgroundColor: const Color.fromARGB(255, 81, 177, 84),
      ),
      body: Center( // Usando o Center para centralizar o conteúdo
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Centraliza verticalmente
          crossAxisAlignment: CrossAxisAlignment.center, // Centraliza horizontalmente
          children: [
            const SizedBox(height: 20),
            //texto de boas vindas
            Text.rich(
              TextSpan(
                text: 'Como é bom te ver aqui,', 
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                children: <TextSpan>[
                  const TextSpan(text: '\n'), // Quebra de linha
                  TextSpan(
                    text: '$firstName $lastName', // Nome e sobrenome puxados do database
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20), // Espaçamento entre o título e o texto

            // Registro de doação
            Container(
              width: screenWidth, // Largura ajustável - 80% da tela
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 217, 235, 206),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('Registro da sua última doação:',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  Text('Próxima doação prevista:',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            const SizedBox(height: 20), // Espaçamento entre o texto e os botões

            // Botões de navegação das telas
            Container(
              width: screenWidth, // Largura ajustável - 80% da tela
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  _buildButton(context, 'Atualizar meus Dados para doação de sangue', TelaPerfil(), screenWidth),
                  _buildButton(context, 'Agendar minha doação de sangue', TelaFormulario(), screenWidth),
                  _buildButton(context, 'Trocar o agendamento da doação de sangue', ConfereAgendamento(), screenWidth),
                  _buildButton(context, 'Buscar pontos para doação de sangue', TelaFormulario(), screenWidth),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Modificação do botão para ajustar largura dinamicamente
  Widget _buildButton(BuildContext context, String label, Widget page, double width) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: SizedBox(
        width: width, // Largura ajustável
        child: MaterialButton(
          color: const Color.fromARGB(255, 81, 177, 84),
          textColor: Colors.white,
          child: Text(label),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => page,
              ),
            );
          },
        ),
      ),
    );
  }
}