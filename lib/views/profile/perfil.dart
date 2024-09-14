import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pi_segunda_entrega/data/database_helper.dart';
import 'package:pi_segunda_entrega/views/home/homepage.dart';

class TelaPerfil extends StatefulWidget {
  const TelaPerfil({super.key});

  @override
  _TelaPerfilState createState() => _TelaPerfilState();
}

class _TelaPerfilState extends State<TelaPerfil> {
  final _formKey = GlobalKey<FormState>();

  // Controladores para os campos de texto
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _idadeController = TextEditingController();
  final TextEditingController _enderecoController = TextEditingController();
  final TextEditingController _cidadeController = TextEditingController();
  final TextEditingController _rgController = TextEditingController();
  final TextEditingController _cpfController = TextEditingController();
  final TextEditingController _carteiraDoadorController = TextEditingController();
  final TextEditingController _telefoneController = TextEditingController();
  final TextEditingController _tipoSanguineoController = TextEditingController();
  final TextEditingController _deficienciaController = TextEditingController();
  final TextEditingController _doencaController = TextEditingController();
  String? _selectedTipoSanguineo;
  String? _selectedDeficiencia;
  String? _selectedDoenca;
  String? _selectedCidade;

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    var user = await DatabaseHelper().getUsuarioLogado();
    if (user != null) {
      _firstNameController.text = user['first_name'] ?? '';
      _lastNameController.text = user['last_name'] ?? '';

      var profile = await DatabaseHelper().getUserProfile(user['id']);
      if (profile != null) {
        _idadeController.text = profile['idade']?.toString() ?? '';
        _enderecoController.text = profile['endereco'] ?? '';
        _cidadeController.text = profile['cidade'] ?? '';
        _rgController.text = profile['rg'] ?? '';
        _cpfController.text = profile['cpf'] ?? '';
        _carteiraDoadorController.text = profile['carteira_doador'] ?? '';
        _telefoneController.text = profile['telefone'] ?? '';
        _tipoSanguineoController.text = profile['tipo_sanguineo'] ?? '';
        _deficienciaController.text = profile['deficiencia'] ?? '';
        _doencaController.text = profile['doenca'] ?? '';
      }
    }
  }

  Future<void> _updateUserProfile() async {
    var user = await DatabaseHelper().getUsuarioLogado();
    if (user != null) {
      await DatabaseHelper().updateUserProfile(user['id'], {
        'idade': int.tryParse(_idadeController.text),
        'endereco': _enderecoController.text,
        'cidade': _cidadeController.text,
        'rg': _rgController.text,
        'cpf': _cpfController.text,
        'carteira_doador': _carteiraDoadorController.text,
        'telefone': _telefoneController.text,
        'tipo_sanguineo': _tipoSanguineoController.text,
        'deficiencia': _deficienciaController.text,
        'doenca': _doencaController.text,
      });
      _showSuccessDialog();
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: const Text("Dados atualizados com sucesso!"),
          actions: [
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.pop(context); // Fechar o diálogo
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const Homepage()),
                ); // Voltar à homepage
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
        title: const Text('Perfil'),
        backgroundColor: const Color.fromARGB(255, 212, 14, 14),
      ),
      body: Container(
        color: const Color.fromARGB(255, 255, 255, 255), // Cor de fundo
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Dados Pessoais
              const Text(
                'Dados pessoais',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),

              // Primeira linha: Nome, Sobrenome, Idade
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _firstNameController,
                      decoration: const InputDecoration(labelText: 'Nome'),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextFormField(
                      controller: _lastNameController,
                      decoration: const InputDecoration(labelText: 'Sobrenome'),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextFormField(
                      controller: _idadeController,
                      decoration: const InputDecoration(labelText: 'Idade'),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              // Segunda linha: Endereço, Cidade
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _enderecoController,
                      decoration: const InputDecoration(labelText: 'Endereço'),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: _selectedCidade,
                      decoration: const InputDecoration(labelText: 'Cidade'),
                      items: [
                        DropdownMenuItem(value: 'Campinas', child: Text('Campinas')),
                        DropdownMenuItem(value: 'Rio de Janeiro', child: Text('Rio de Janeiro')),
                        DropdownMenuItem(value: 'São Paulo', child: Text('São Paulo')),
                      ],
                      onChanged: (String? newValue){
                        setState(() {
                          _selectedCidade = newValue;
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              // Terceira linha: RG, CPF
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _rgController,
                      decoration: const InputDecoration(labelText: 'RG'),
                      keyboardType: TextInputType.number,
                      maxLength: 9,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextFormField(
                      controller: _cpfController,
                      decoration: const InputDecoration(labelText: 'CPF'),
                      keyboardType: TextInputType.number,
                      maxLength: 11,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              // Quarta linha: Carteira de Doador, Telefone
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _carteiraDoadorController,
                      decoration: const InputDecoration(labelText: 'Carteira de Doador'),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextFormField(
                      controller: _telefoneController,
                      decoration: const InputDecoration(labelText: 'Telefone'),
                      keyboardType: TextInputType.number,
                      maxLength: 11,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Dados Médicos
              const Text(
                'Dados médicos',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),

              // Primeira linha: Tipo Sanguíneo, Deficiência
              Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: _selectedTipoSanguineo,
                      decoration: const InputDecoration(labelText: 'Tipo Sanguíneo'),
                      items: const [
                        DropdownMenuItem(value: 'A+', child: Text('A+')),
                        DropdownMenuItem(value: 'A-', child: Text('A-')),
                        DropdownMenuItem(value: 'B+', child: Text('B+')),
                        DropdownMenuItem(value: 'B-', child: Text('B-')),
                        DropdownMenuItem(value: 'AB+', child: Text('AB+')),
                        DropdownMenuItem(value: 'AB-', child: Text('AB-')),
                        DropdownMenuItem(value: 'O+', child: Text('O+')),
                        DropdownMenuItem(value: 'O-', child: Text('O-')),
                      ],
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedTipoSanguineo = newValue;
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: _selectedDeficiencia,
                      decoration: const InputDecoration(labelText: 'PCD?'),
                      items: const[
                        DropdownMenuItem(value: 'Sim', child: Text('Sim')),
                        DropdownMenuItem(value: 'Não', child: Text('Não')),
                      ], 
                      onChanged: (String? newValue){
                        setState((){
                          _selectedDeficiencia = newValue;
                        });
                      }
                      ),
                      ),
                ],
              ),
              const SizedBox(height: 10),
              // Segunda linha: Doença crônica
              DropdownButtonFormField<String>(
                value: _selectedDoenca,
                decoration: const InputDecoration(labelText: 'Possui doenças crônicas?'),
                items: const[
                        DropdownMenuItem(value: 'Sim', child: Text('Sim')),
                        DropdownMenuItem(value: 'Não', child: Text('Não')),
                      ], 
                      onChanged: (String? newValue){
                        setState((){
                          _selectedDeficiencia = newValue;
                        });
                      }
              ),
              const SizedBox(height: 20),

              // Botão de atualizar
              ElevatedButton(
                onPressed: _updateUserProfile,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 212, 14, 14), // Vermelho mais escuro
                  foregroundColor: Colors.white, // Texto branco
                ),
                child: const Text('Atualizar dados'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
