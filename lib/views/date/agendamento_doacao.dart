import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pi_segunda_entrega/data/database_helper.dart';
import 'package:pi_segunda_entrega/views/home/homepage.dart';

class AgendamentoScreen extends StatefulWidget {
  @override
  _AgendamentoScreenState createState() => _AgendamentoScreenState();
}

class _AgendamentoScreenState extends State<AgendamentoScreen> {
  final _formKey = GlobalKey<FormState>();
  final _heightController = TextEditingController();
  final _weightController = TextEditingController();
  final _illnessController = TextEditingController();
  final _tattoosController = TextEditingController();
  final _surgeryController = TextEditingController();
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  final _locationController = TextEditingController();
  final _databaseHelper = DatabaseHelper();
  String? _userName;
  String? _selectedIllness;
  String? _selectedTattoos;
  String? _selectedCirurgia;
  String? _selectedLocation;

  @override
  void initState() {
    super.initState();
    _getUserInfo();
    _checkExistingAppointment();
  }

  Future<void> _getUserInfo() async {
    final user = await _databaseHelper.getUsuarioLogado();
    if (user != null) {
      setState(() {
        _userName = '${user['first_name']} ${user['last_name']}';
      });
    }
  }

  Future<void> _checkExistingAppointment() async {
    final user = await _databaseHelper.getUsuarioLogado();
    if (user != null) {
      final appointments = await _databaseHelper.getAgendamentosByUser(user['id']);
      if (appointments.isNotEmpty) {
        _showMessage('Você já possui um agendamento marcado, caso queira alterar a data ou cancelar, utilize a tela de troca e cancelamento na página inicial');
      }
    }
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime() async {
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

  Future<void> _confirmAppointment() async {
    if (_formKey.currentState?.validate() ?? false) {
      final user = await _databaseHelper.getUsuarioLogado();
      if (user != null) {
        final illness = _illnessController.text.trim().toLowerCase();
        if (illness.contains('sim')) {
          _showMessage('Não é possível agendar nesse momento pois você ficou doente recentemente');
          return;
        }
        final date = DateFormat('dd-MM-yyyy').format(_selectedDate!);
        final time = _selectedTime?.format(context) ?? '';
        final location = _locationController.text.trim();

        await _databaseHelper.insertAgendamento(user['id'], date, time, location);
        _showConfirmationDialog();
      }
    }
  }

  Future<void> _showConfirmationDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Agendamento Confirmado'),
          content: Text('Seu agendamento foi confirmado, você será redirecionado para a página inicial'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(); // Fecha o diálogo de confirmação
                Navigator.of(context).pushNamedAndRemoveUntil('/homepage', (route) => false); // Redireciona para a Homepage
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showMessage(String message) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Aviso'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(); // Fecha o diálogo
                Navigator.of(context).pushNamedAndRemoveUntil('/homepage', (route) => false); // Redireciona para a Homepage
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 212, 14, 14),
        title: Text('Agendamento de Doação'),
      ),
      resizeToAvoidBottomInset: true, 
      body: Container(
        color: const Color.fromARGB(255, 255, 255, 255),
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (_userName != null)
              Text(
                'Bem-vindo, $_userName!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            const SizedBox(height: 16.0),
            
            Row(
              children: [
                Expanded(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    controller: _heightController,
                                    decoration: InputDecoration(
                                      labelText: 'Altura',
                                      labelStyle: TextStyle(fontSize: 14), // Tamanho do título do campo
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Campo obrigatório';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                const SizedBox(width: 16.0),
                                Expanded(
                                  child: TextFormField(
                                    controller: _weightController,
                                    decoration: InputDecoration(
                                      labelText: 'Peso',
                                      labelStyle: TextStyle(fontSize: 14), // Tamanho do título do campo
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Campo obrigatório';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16.0),

                            Row(
                              children: [
                                Expanded(
                            child: DropdownButtonFormField<String>(
                              value: _selectedIllness,
                              decoration: InputDecoration(
                                labelText: 'Ficou doente recentemente?',
                                labelStyle: TextStyle(fontSize: 14), // Tamanho do título do campo
                              ),
                              items: const[
                                DropdownMenuItem(value: 'Sim', child: Text('Sim')),
                                DropdownMenuItem(value: 'Não', child: Text('Não')),
                              ],
                              onChanged: (String? newValue) {
                               setState(() {
                                  _selectedIllness = newValue;
                                });
                              }
                            ),
                            ),
                            ],),
                            const SizedBox(height: 16.0),

                            Row(
                              children: [
                                Expanded(
                            child: DropdownButtonFormField<String>(
                              value: _selectedTattoos,
                              decoration: InputDecoration(
                                labelText: 'Possui tatuagens? (Sim ou Não)',
                                labelStyle: TextStyle(fontSize: 14), // Tamanho do título do campo
                              ),
                              items: [
                                DropdownMenuItem(value: 'Sim', child: Text('Sim')),
                                DropdownMenuItem(value: 'Não', child: Text('Não')),
                              ],
                              onChanged: (String? newValue){
                                setState(() {
                                  _selectedTattoos = newValue;
                                });
                              },
                            ),
                            ),
                            ],
                            ),                          
                            const SizedBox(height: 16.0),
                            TextFormField(
                              controller: _surgeryController,
                              decoration: InputDecoration(
                                labelText: 'Fez alguma cirurgia no último ano? Se sim, qual?',
                                labelStyle: TextStyle(fontSize: 14), // Tamanho do título do campo
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Campo obrigatório';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16.0),

                            Row(
                              children: [
                              Expanded(
                                child: TextButton(
                              onPressed: _selectDate,
                              child: Text(
                                _selectedDate == null
                                    ? 'Selecionar Data'
                                    : 'Data Selecionada: ${DateFormat('yyyy-MM-dd').format(_selectedDate!)}',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color.fromARGB(255, 16, 27, 133),
                                  fontWeight: FontWeight.bold
                                ), // Tamanho do texto do botão
                              ),
                            ),)
                            ],),                           
                            const SizedBox(height: 16.0),

                            Row(
                              children: [
                              Expanded(child: TextButton(
                              onPressed: _selectTime,
                              child: Text(
                                _selectedTime == null
                                    ? 'Selecionar Hora'
                                    : 'Hora Selecionada: ${_selectedTime?.format(context)}',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color.fromARGB(255, 16, 27, 133),
                                  fontWeight: FontWeight.bold,
                                  ), // Tamanho do texto do botão
                              ),
                            ),)
                            ],),
                            const SizedBox(height: 16.0),

                            Row(
                              children: [
                              Expanded(
                                child: DropdownButtonFormField<String>(
                              value: _selectedLocation,
                              decoration: InputDecoration(
                                labelText: 'Local de Doação',
                                labelStyle: TextStyle(fontSize: 14), // Tamanho do título do campo
                              ),
                              items: [
                                DropdownMenuItem(value: 'Campinas', child: Text('Campinas')),
                                DropdownMenuItem(value: 'Rio de Janeiro', child: Text('Rio de Janeiro')),
                                DropdownMenuItem(value: 'São Paulo', child: Text('São Paulo')),
                              ],
                              onChanged: (String? newValue){
                                setState(() {
                                  _selectedLocation = newValue;
                                });
                              }
                            ),)
                            ],),                           
                            const SizedBox(height: 16.0),

                            Row(
                              children: [
                              Expanded(
                                child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                minimumSize: Size(200, 50), // Tamanho do botão
                                backgroundColor: Color.fromARGB(255, 212, 14, 14),// Cor de fundo do botão
                                foregroundColor: Colors.white, // Cor do texto do botão
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10), // Bordas arredondadas
                                ),
                              ),
                              onPressed: _confirmAppointment,
                              child: Text(
                                'Confirmar Agendamento',
                                style: TextStyle(fontSize: 16), // Tamanho do texto do botão
                              ),
                            ),)
                            ],),                         
                          ],
                        )
                ),
              ),
            ),
              ],
            ),
            
          ],
        ),
      ),
    ));
  }
}
