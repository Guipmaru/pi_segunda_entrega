import 'package:flutter/material.dart';
import 'package:pi_segunda_entrega/data/database_helper.dart';

class Homepage extends StatefulWidget{
  const Homepage({super.key});

  @override
  HomepageState createState() => HomepageState();
}
  
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 208, 241, 209),
        body: Column(
           mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
        )
        title: const Text(
          'Como é bom te ver aqui,'
          style: TextStyle(
            fontSize: 35,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
          ), // título da homepage
        ),

         Padding(
          padding: const EdgeInsets.symetric(horizontal: 100),
          child: Text(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('Registro da sua última doação: 15/12/2023'),
            SizedBox(height: 10),
            Text('Próxima doação prevista: [data da próxima doação'),
            SizedBox(height: 10),
            Text('O que deseja fazer hoje?'),
          ], //informações do paciente e texto para o menu de botões
        ),
      ),

           Padding(
            padding: const EdgeInsets.symetric(horizontal: 150),
            child: MaterialButton(
            mainAnxisAlignment: MainAxisAlignment.center,
            color: const Color.fromARGB(255, 81, 177, 84),
            textColor: Colors.white,
            child: const Text('Atualizar meus Dados para doação de sangue'),
              onPressed: () {
               Navigator.push(
                context,
               MaterialPageRoute(
                builder: (context) => TelaFormulario(), // inserir a tela correta
              ), // botão de atualizar os dados para a doação de sangue
            );
          },
        ),
      ),
            Padding(
             padding: const EdgeInsets.symetric(horizontal: 150),
             child: MaterialButton(
             mainAnxisAlignment: MainAxisAlignment.center,
             color: const Color.fromARGB(255, 81, 177, 84),
             textColor: Colors.white,
             child: const Text('Agendar minha doação de sangue'),
               onPressed: () {
                Navigator.push(
                 context,
                MaterialPageRoute(
                 builder: (context) => TelaAgendamento(), // inserir a tela correta
              ), // botão para agendamento da doação
            );
          },
        ),
      ),

            Padding(
             padding: const EdgeInsets.symetric(horizontal: 150),
             child: MaterialButton(
             mainAnxisAlignment: MainAxisAlignment.center,
             color: const Color.fromARGB(255, 81, 177, 84),
             textColor: Colors.white,
             child: const Text('Trocar o agendamento da doação de sangue'),
              onPressed: () {
               Navigator.push(
                context,
               MaterialPageRoute(
                builder: (context) => TelaTrocadeAgendamento(), // inserir a tela correta
              ), // botão de trocar agendamento da doação de sangue
            );
          },
        ),
      ),

            Padding(
             padding: const EdgeInsets.symetric(horizontal: 150),
             child: MaterialButton(
             mainAnxisAlignment: MainAxisAlignment.center,
             color: const Color.fromARGB(255, 81, 177, 84),
             textColor: Colors.white,
             child: const Text('Buscar pontos para doação de sangue'),
              onPressed: () {
               Navigator.push(
                context,
               MaterialPageRoute(
                builder: (context) => TelaFormulario(), // inserir a tela correta
              ), // botão para mostrar os pontos de doações
            );
          },
        ),
      ),

void main() {
  runApp(const MaterialApp(
    home: Homepage(),
  ));
}
