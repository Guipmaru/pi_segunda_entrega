import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; 
import 'package:pi_segunda_entrega/models/user_model.dart';
import 'package:pi_segunda_entrega/controllers/user_controller.dart';
import 'package:pi_segunda_entrega/views/profile/perfil.dart'; 
import 'package:pi_segunda_entrega/views/date/confere_agendamento.dart'; 
import 'package:pi_segunda_entrega/views/date/agendamento_doacao.dart'; 
import 'package:pi_segunda_entrega/views/local/local_doacao.dart'; 
import 'package:pi_segunda_entrega/data/database_helper.dart'; 
import 'package:pi_segunda_entrega/views/home/homepage.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  HomepageState createState() => HomepageState();
}

class HomepageState extends State<Homepage> {
  String firstName = '';
  String lastName = '';
  String nextDonationDate = 'Você não possui doação agendada';
  final UserController _userController = UserController();
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    User? user = await _userController.getUsuarioLogado();
    if (user != null) {
      setState(() {
        firstName = user.firstName;
        lastName = user.lastName;
      });

      var nextAppointment = await _databaseHelper.getAgendamento(user.id);
      
      if (nextAppointment != null) {
        setState(() {
          try {
            // formato da data dia/mês/ano
            DateFormat inputFormat = DateFormat('dd-MM-yyyy');
            DateTime dateTime = inputFormat.parse(nextAppointment['data']);
            
            DateFormat outputFormat = DateFormat('dd-MM-yyyy');
            String formattedDate = outputFormat.format(dateTime);
            
            // Incluindo o local no texto
            nextDonationDate = 'Próxima doação prevista: $formattedDate às ${nextAppointment['hora']} no local: ${nextAppointment['local']}';
          } catch (e) {
            print('Error parsing date: $e');
            nextDonationDate = 'Erro ao formatar a data do agendamento';
          }
        });
      } else {
        setState(() {
          nextDonationDate = 'Você não possui doação agendada';
        });
      }
    }
  }
void _logout() {
  Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
}

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width * 0.8;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 238, 159, 155),
      appBar: AppBar(
        title: const Text('Bem-vindo'),
        backgroundColor: const Color.fromARGB(255, 212, 14, 14),
        
      ),
      body: Center(
        child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 10),

            // logo do projeto
            Image.asset(
              'lib/assets/images/logotipo-semfundo.png', // Caminho da imagem
              width: 200, // Largura da imagem
              height: 200, // Altura da imagem
            ),
            const SizedBox(height: 0),

            // Texto de boas-vindas
            Text.rich(
              textAlign: TextAlign.center,
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
                color: const Color.fromARGB(85, 253, 253, 253),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Registro da sua última doação:',
                  textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold,)),
                  const SizedBox(height: 10),
                  Text(nextDonationDate,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: screenWidth,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Color.fromARGB(85, 253, 253, 253),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildButton(context, 'Atualizar meus Dados para doação de sangue', const TelaPerfil(), screenWidth),
                  _buildButton(context, 'Agendar minha doação de sangue', AgendamentoScreen(), screenWidth),
                  _buildButton(context, 'Trocar ou cancelar um agendamento', const ConfereAgendamento(), screenWidth),
                  _buildButton(context, 'Buscar pontos para doação de sangue', LocalDoacaoPage(), screenWidth),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }

  Widget _buildButton(BuildContext context, String label, Widget page, double width) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: SizedBox(
        width: width,
        child: MaterialButton(
          color: const Color.fromARGB(255, 212, 14, 14),
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