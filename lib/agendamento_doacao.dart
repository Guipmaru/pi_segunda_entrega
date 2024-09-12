import 'package:flutter/material.dart';

// Tela de Agendamento de Doação
class TelaAgendamentoDoacao extends StatefulWidget {
  const TelaAgendamentoDoacao({super.key});

  @override
  _TelaAgendamentoDoacaoState createState() => _TelaAgendamentoDoacaoState();
}

class _TelaAgendamentoDoacaoState extends State<TelaAgendamentoDoacao> {
  // Variáveis para armazenar data, hora e local selecionados
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  String? _selectedLocation;

  // Lista fictícia de locais de doação
  final List<String> _locations = [
    'Hemocentro São Paulo',
    'Hemocentro Campinas',
    'Hemocentro Rio de Janeiro',
  ];

  // Método para selecionar a data usando o showDatePicker
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(), // Data inicial é a atual
      firstDate: DateTime.now(), // Não permite selecionar datas passadas
      lastDate: DateTime(2101), // Limita a data futura
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked; // Atualiza a data selecionada
      });
    }
  }

  // Método para selecionar a hora usando o showTimePicker
  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(), // Hora inicial é a atual
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked; // Atualiza a hora selecionada
      });
    }
  }

  // Método para confirmar o agendamento
  void _confirmAgendamento() {
    // Verifica se todos os campos foram preenchidos
    if (_selectedDate != null && _selectedTime != null && _selectedLocation != null) {
      // Formata a data e hora selecionadas
      final String dateString = "${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}";
      final String timeString = "${_selectedTime!.hour}:${_selectedTime!.minute.toString().padLeft(2, '0')}";

      // Exibe um diálogo confirmando os detalhes do agendamento
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Agendamento Confirmado'),
          content: Text('Data: $dateString\nHora: $timeString\nLocal: $_selectedLocation'),
          actions: [
            // Botão para fechar o diálogo
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } else {
      // Exibe uma mensagem de erro se algum campo não for preenchido
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor, preencha todos os campos.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Define a largura da tela com 80% da largura disponível
    double screenWidth = MediaQuery.of(context).size.width * 0.8;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Agendar Doação de Sangue'),
        backgroundColor: const Color.fromARGB(255, 81, 177, 84),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Define o espaçamento interno da tela
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Centraliza o conteúdo verticalmente
          crossAxisAlignment: CrossAxisAlignment.start, // Alinha à esquerda
          children: [
            // Seletor de data
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Data:', style: TextStyle(fontSize: 16)),
                TextButton(
                  onPressed: () => _selectDate(context), // Chama o seletor de data
                  child: Text(
                    _selectedDate == null
                        ? 'Selecione a data' // Texto exibido se não houver data selecionada
                        : "${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}", // Exibe a data selecionada
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20), // Espaçamento entre os componentes

            // Seletor de hora
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Hora:', style: TextStyle(fontSize: 16)),
                TextButton(
                  onPressed: () => _selectTime(context), // Chama o seletor de hora
                  child: Text(
                    _selectedTime == null
                        ? 'Selecione a hora' // Texto exibido se não houver hora selecionada
                        : "${_selectedTime!.hour}:${_selectedTime!.minute.toString().padLeft(2, '0')}", // Exibe a hora selecionada
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20), // Espaçamento entre os componentes

            // Seletor de local de doação (Dropdown)
            const Text('Local de Doação:', style: TextStyle(fontSize: 16)),
            DropdownButton<String>(
              hint: const Text('Selecione o local'),
              value: _selectedLocation, // Local selecionado
              isExpanded: true, // Expande o dropdown para preencher a largura disponível
              items: _locations.map((String location) {
                return DropdownMenuItem<String>(
                  value: location,
                  child: Text(location), // Exibe cada local na lista
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedLocation = newValue; // Atualiza o local selecionado
                });
              },
            ),
            const SizedBox(height: 40), // Espaçamento entre os componentes

            // Botão de confirmação
            Center(
              child: SizedBox(
                width: screenWidth, // Define a largura do botão
                child: MaterialButton(
                  color: const Color.fromARGB(255, 81, 177, 84), // Cor do botão
                  textColor: Colors.white, // Cor do texto
                  padding: const EdgeInsets.all(15), // Define o padding do botão
                  child: const Text('Confirmar Agendamento', style: TextStyle(fontSize: 16)),
                  onPressed: _confirmAgendamento, // Ação de confirmar o agendamento
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
