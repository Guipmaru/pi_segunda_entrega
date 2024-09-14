import 'package:flutter/material.dart';
import 'package:pi_segunda_entrega/controllers/user_controller.dart';
import 'package:pi_segunda_entrega/data/database_helper.dart';
import 'package:pi_segunda_entrega/views/home/homepage.dart';

class ConfereAgendamento extends StatefulWidget {
  const ConfereAgendamento({super.key});

  @override
  ConfereAgendamentoState createState() => ConfereAgendamentoState();
}

class ConfereAgendamentoState extends State<ConfereAgendamento> {
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  String appointmentLocation = '';
  final UserController _userController = UserController();
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  @override
  void initState() {
    super.initState();
    _loadAppointmentData();
  }

  Future<void> _loadAppointmentData() async {
    var user = await _userController.getUsuarioLogado();
    if (user != null) {
      var nextAppointment = await _databaseHelper.getAgendamento(user.id);
      if (nextAppointment != null) {
        setState(() {
          selectedDate = DateTime.parse(nextAppointment['data']);
          selectedTime = TimeOfDay.fromDateTime(DateTime.parse(nextAppointment['hora']));
          appointmentLocation = nextAppointment['local'];
        });
      } else {
        _showNoAppointmentMessage();
      }
    }
  }

  Future<void> _updateAppointment(DateTime newDate, TimeOfDay newTime, String newLocation) async {
    if (newLocation.isEmpty) {
      _showMessage('Por favor, informe o novo local.', false);
      return;
    }

    // Formata a data no formato DD-MM-YYYY
    String formattedDate = '${newDate.day.toString().padLeft(2, '0')}-${newDate.month.toString().padLeft(2, '0')}-${newDate.year}';
    //print('Data selecionada: $formattedDate'); // Verifica a data no console

    var user = await _userController.getUsuarioLogado();
    if (user != null) {
      await _databaseHelper.updateAgendamento(
        user.id,
        formattedDate, // Usa a data formatada no padrão DD-MM-YYYY
        newTime.format(context), // Formata a hora no formato HH:mm
        newLocation,
      );
      _showMessage('Seu agendamento foi alterado com sucesso!', true);
    }
  }

  Future<void> _cancelAppointment() async {
    var user = await _userController.getUsuarioLogado();
    if (user != null) {
      await _databaseHelper.deleteAgendamento(user.id);
      _showMessage('Seu agendamento foi cancelado!', true);
    }
  }

  void _showMessage(String message, bool redirectToHome) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
                if (redirectToHome) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const Homepage()),
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }

  void _showNoAppointmentMessage() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: const Text('Nenhum agendamento encontrado.'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const Homepage()),
                );
              },
            ),
          ],
        );
      },
    );
  }

  void _confirmCancel() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: const Text('Tem certeza que deseja cancelar seu agendamento?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Não'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Sim'),
              onPressed: () {
                Navigator.of(context).pop();
                _cancelAppointment();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _selectDate() async {
    DateTime initialDate = selectedDate ?? DateTime.now();
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null && pickedDate != initialDate) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  Future<void> _selectTime() async {
    TimeOfDay initialTime = selectedTime ?? TimeOfDay.now();
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: initialTime,
    );
    if (pickedTime != null && pickedTime != initialTime) {
      setState(() {
        selectedTime = pickedTime;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width * 0.8;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 190, 228, 191),
      appBar: AppBar(
        title: const Text('Trocar ou Cancelar Agendamento'),
        backgroundColor: const Color.fromARGB(255, 81, 177, 84),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: screenWidth,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Sua doação será marcada para: ${selectedDate?.toLocal().toString().split(' ')[0] ?? ''} ${selectedTime?.format(context) ?? ''}\nLocal: $appointmentLocation',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _selectDate,
                    child: const Text('Selecionar Nova Data'),
                  ),
                  ElevatedButton(
                    onPressed: _selectTime,
                    child: const Text('Selecionar Novo Horário'),
                  ),
                  _buildTextField('Novo Local'),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          if (selectedDate != null && selectedTime != null && appointmentLocation.isNotEmpty) {
                            _updateAppointment(
                              selectedDate!,
                              selectedTime!,
                              appointmentLocation,
                            );
                          } else {
                            _showMessage('Por favor, selecione uma data, hora e local.', false);
                          }
                        },
                        child: const Text('Trocar'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 81, 177, 84),
                          foregroundColor: Colors.white,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: _confirmCancel,
                        child: const Text('Desmarcar'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextField(
        onChanged: (value) {
          setState(() {
            appointmentLocation = value;
          });
        },
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}
