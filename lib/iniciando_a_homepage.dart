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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 208, 241, 209),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Como é bom te ver aqui,',
            style: TextStyle(
              fontSize: 35,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20), // Espaçamento entre o título e o texto
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 100),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Registro da sua última doação: 15/12/2023'),
                SizedBox(height: 10),
                Text('Próxima doação prevista: [data da próxima doação]'),
                SizedBox(height: 10),
                Text('O que deseja fazer hoje?'),
              ],
            ),
          ),
          const SizedBox(height: 20), // Espaçamento entre o texto e os botões


          //construção do navegador push para a tela de perfil para atualização de dados  
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 150),
            child: MaterialButton(
              color: const Color.fromARGB(255, 81, 177, 84),
              textColor: Colors.white,
              child: const Text('Atualizar meus Dados para doação de sangue'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TelaPerfil(), 
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 10), // Espaçamento entre os botões

          //navegador push para a tela de formulario de agendamento de doação
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 150),
            child: MaterialButton(
              color: const Color.fromARGB(255, 81, 177, 84),
              textColor: Colors.white,
              child: const Text('Agendar minha doação de sangue'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TelaFormulario(),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 10), // Espaçamento entre os botões

          //Navegação para tela de conferência ou  troca de agendamento
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 150),
            child: MaterialButton(
              color: const Color.fromARGB(255, 81, 177, 84),
              textColor: Colors.white,
              child: const Text('Trocar o agendamento da doação de sangue'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ConfereAgendamento(), 
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 10), // Espaçamento entre os botões


          //Tela para buscar pontos de agendamento
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 150),
            child: MaterialButton(
              color: const Color.fromARGB(255, 81, 177, 84),
              textColor: Colors.white,
              child: const Text('Buscar pontos para doação de sangue'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TelaFormulario(), 
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: Homepage(),
  ));
}