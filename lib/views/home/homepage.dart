import 'package:flutter/material.dart';
import 'package:pi_segunda_entrega/controllers/user_controller.dart';
import 'package:pi_segunda_entrega/views/profile/perfil.dart'; 
import 'package:pi_segunda_entrega/views/date/confere_agendamento.dart'; 
import 'package:pi_segunda_entrega/views/date/agendamento_doacao.dart'; 
import 'package:pi_segunda_entrega/views/local/local_doacao.dart'; 

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  HomepageState createState() => HomepageState();
}

class HomepageState extends State<Homepage> {
  String firstName = '';
  String lastName = '';

  final UserController _userController = UserController();

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

    Future<void> _loadUserData() async {
      var user = await _userController.getUsuarioLogado();
      if (user != null) {
        setState(() {
          firstName = user.firstName;
          lastName = user.lastName;
        });
      }
    }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width * 0.8;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 190, 228, 191),
      appBar: AppBar(
        title: const Text('Bem-vindo'),
        backgroundColor: const Color.fromARGB(255, 81, 177, 84),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Text.rich(
              TextSpan(
                text: 'Como é bom te ver aqui,',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                children: <TextSpan>[
                  const TextSpan(text: '\n'),
                  TextSpan(
                    text: '$firstName $lastName',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: screenWidth,
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
            // caixa com os botões de navegação para as outras telas 
            const SizedBox(height: 20),
            Container(
              width: screenWidth,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  _buildButton(context, 'Atualizar meus Dados para doação de sangue', const TelaPerfil(), screenWidth),
                  _buildButton(context, 'Agendar minha doação de sangue', const TelaAgendamentoDoacao(), screenWidth),
                  _buildButton(context, 'Trocar o agendamento da doação de sangue', const ConfereAgendamento(), screenWidth),
                  _buildButton(context, 'Buscar pontos para doação de sangue', LocalDoacaoPage(), screenWidth),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(BuildContext context, String label, Widget page, double width) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: SizedBox(
        width: width,
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