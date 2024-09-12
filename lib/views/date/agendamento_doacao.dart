import 'package:flutter/material.dart';
import 'database_helper.dart'; // Importa a classe de ajuda do banco de dados

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

  final DatabaseHelper _dbHelper = DatabaseHelper();

  // Método fictício para obter o usuário logado
  String _getUserId() {
    // Retornar o ID do usuário logado (substituir por método real)
    return 'user123';
  }

  // Método para selecionar a data usando o showDatePicker
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  // Método para selecionar a hora usando o showTimePicker
  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  // Método para confirmar o agendamento e salvar no banco de dados
  void _confirmAgendamento() async {
    if (_selectedDate != null && _selectedTime != null && _selectedLocation != null) {
      final String dateString = "${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}";
      final String timeString = "${_selectedTime!.hour}:${_selectedTime!.minute.toString().padLeft(2, '0')}";
      final String userId = _getUserId();

      // Inserir agendamento no banco de dados
      await _dbHelper.insertSchedule(userId, dateString, timeString, _selectedLocation!);

      // Exibe um diálogo confirmando os detalhes do agendamento
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Agendamento Confirmado'),
          content: Text('Data: $dateString\nHora: $timeString\nLocal: $_selectedLocation'),
          actions: [
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
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, preencha todos os campos.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width * 0.8;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Agendar Doação de Sangue'),
        backgroundColor: const Color.fromARGB(255, 81, 177, 84),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Seletor de data
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Data:', style: TextStyle(fontSize: 16)),
                TextButton(
                  onPressed: () => _selectDate(context),
                  child: Text(
                    _selectedDate == null
                        ? 'Selecione a data'
                        : "${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}",
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Seletor de hora
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Hora:', style: TextStyle(fontSize: 16)),
                TextButton(
                  onPressed: () => _selectTime(context),
                  child: Text(
                    _selectedTime == null
                        ? 'Selecione a hora'
                        : "${_selectedTime!.hour}:${_selectedTime!.minute.toString().padLeft(2, '0')}",
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Seletor de local de doação (Dropdown)
            const Text('Local de Doação:', style: TextStyle(fontSize: 16)),
            DropdownButton<String>(
              hint: const Text('Selecione o local'),
              value: _selectedLocation,
              isExpanded: true,
              items: _locations.map((String location) {
                return DropdownMenuItem<String>(
                  value: location,
                  child: Text(location),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedLocation = newValue;
                });
              },
            ),
            const SizedBox(height: 40),

            // Botão de confirmação
            Center(
              child: SizedBox(
                width: screenWidth,
                child: MaterialButton(
                  color: const Color.fromARGB(255, 81, 177, 84),
                  textColor: Colors.white,
                  padding: const EdgeInsets.all(15),
                  child: const Text('Confirmar Agendamento', style: TextStyle(fontSize: 16)),
                  onPressed: _confirmAgendamento,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

        ),
      ),
    );
  }
}
