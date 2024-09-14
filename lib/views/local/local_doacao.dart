import 'package:flutter/material.dart';
import 'package:pi_segunda_entrega/data/database_helper.dart';

class LocalDoacaoPage extends StatefulWidget {
  @override
  _LocalDoacaoPageState createState() => _LocalDoacaoPageState();
}

class _LocalDoacaoPageState extends State<LocalDoacaoPage> {
  DatabaseHelper _dbHelper = DatabaseHelper();
  Map<String, dynamic>? _usuarioLogado;
  Map<String, dynamic>? _perfilUsuario;
  Map<String, dynamic>? _agendamento;
  String _mensagemErro = '';
  List<Map<String, dynamic>> _hemocentrosCidadeSelecionada = [];
  String _cidadeSelecionada = '';
  
  @override
  void initState() {
    super.initState();
    _carregarDados();
  }

  Future<void> _carregarDados() async {
    try {
      Map<String, dynamic>? usuario = await _dbHelper.getUsuarioLogado();
      if (usuario == null) {
        setState(() {
          _mensagemErro = "Nenhum usuário logado.";
        });
        return;
      }

      Map<String, dynamic>? perfil = await _dbHelper.getUserProfile(usuario['id']);
      if (perfil == null || perfil['cidade'] == null) {
        setState(() {
          _mensagemErro = "Complete seu cadastro.";
        });
        return;
      }

      List<Map<String, dynamic>> hemocentros = await _dbHelper.getHemocentrosByCidade(perfil['cidade']);
      Map<String, dynamic>? agendamento = await _dbHelper.getAgendamento(usuario['id']);

      setState(() {
        _usuarioLogado = usuario;
        _perfilUsuario = perfil;
        _agendamento = agendamento;
        _hemocentrosCidadeSelecionada = hemocentros;
      });
    } catch (e) {
      setState(() {
        _mensagemErro = "Erro ao carregar os dados: $e";
      });
    }
  }

  Future<void> _mostrarLocalizacao(BuildContext context, String endereco) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Localização do Hemocentro'),
          content: Text(endereco),
          actions: <Widget>[
            TextButton(
              child: Text(
                'OK',
                style: TextStyle(
                                  fontSize: 14,
                                  color: Color.fromARGB(255, 16, 27, 133),
                                  fontWeight: FontWeight.bold
                                ),
                                ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _buscarHemocentros(String cidade) async {
    try {
      List<Map<String, dynamic>> hemocentros = await _dbHelper.getHemocentrosByCidade(cidade);
      setState(() {
        _hemocentrosCidadeSelecionada = hemocentros;
      });

      if (hemocentros.isNotEmpty) {
        String listaHemocentros = hemocentros.map((h) => h['nome']).join(', ');
        _mostrarResultadoBusca(context, listaHemocentros);
      } else {
        _mostrarResultadoBusca(context, 'Nenhum hemocentro encontrado.');
      }
    } catch (e) {
      setState(() {
        _mensagemErro = "Erro ao buscar hemocentros: $e";
      });
    }
  }

  Future<void> _mostrarResultadoBusca(BuildContext context, String resultado) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Resultado da Busca'),
          content: Text(resultado),
          actions: <Widget>[
            TextButton(
              child: Text(
                'OK',
                style: TextStyle(
                                  fontSize: 14,
                                  color: Color.fromARGB(255, 16, 27, 133),
                                  fontWeight: FontWeight.bold
                                ),
                                ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<List<String>> _carregarCidadesHemocentros() async {
    try {
      List<String> cidades = await _dbHelper.getCidadesComHemocentros();
      return cidades;
    } catch (e) {
      setState(() {
        _mensagemErro = "Erro ao carregar cidades: $e";
      });
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 238, 159, 155),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 212, 14, 14),
        title: Text('Local de Doação'),
      ),
      body: Center( //Centraliza tudo
        child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: _mensagemErro.isNotEmpty
              ? Center(child: Text(_mensagemErro, style: TextStyle(color: Colors.black)))
              : _perfilUsuario != null
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center, // Centraliza os elementos verticalmente
                      crossAxisAlignment: CrossAxisAlignment.center, // Centraliza os elementos horizontalmente
                      children: [
                        // Primeira caixa branca
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 5)],
                          ),
                          padding: EdgeInsets.all(16),
                          margin: EdgeInsets.only(bottom: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "${_usuarioLogado?['first_name']} ${_usuarioLogado?['last_name']}",
                                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "${_perfilUsuario?['cidade']}",
                                style: TextStyle(fontSize: 18),
                              ),
                              SizedBox(height: 20),
                              Text(
                                "Este é o seu ponto de doação",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 10),
                              Container(
                                padding: EdgeInsets.all(10),
                                color: Colors.green[300],
                                child: Text(
                                  _hemocentrosCidadeSelecionada.isNotEmpty
                                      ? _hemocentrosCidadeSelecionada.first['nome'] // Exibe o nome do hemocentro
                                      : "Nenhum hemocentro disponível",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              SizedBox(height: 10),
                              ElevatedButton(
                                onPressed: _hemocentrosCidadeSelecionada.isNotEmpty
                                    ? () {
                                        _mostrarLocalizacao(context, _hemocentrosCidadeSelecionada.first['endereco']);
                                      }
                                    : null,
                                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                                child: Text("Ver Localização", style: TextStyle(color: Colors.white)),
                              ),
                            ],
                          ),
                        ),
                        // Segunda caixa branca
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 5)],
                          ),
                          padding: EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Buscar outros pontos de doação",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              FutureBuilder<List<String>>(
                                future: _carregarCidadesHemocentros(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState == ConnectionState.waiting) {
                                    return CircularProgressIndicator();
                                  } else if (snapshot.hasError) {
                                    return Text('Erro ao carregar cidades');
                                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                                    return Text('Nenhuma cidade encontrada');
                                  } else {
                                    return DropdownButton<String>(
                                      hint: Text("Selecione outra cidade"),
                                      value: _cidadeSelecionada.isEmpty ? null : _cidadeSelecionada,
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          _cidadeSelecionada = newValue!;
                                        });
                                      },
                                      items: snapshot.data!
                                          .map<DropdownMenuItem<String>>((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                    );
                                  }
                                },
                              ),
                              SizedBox(height: 10),
                              ElevatedButton(
                                onPressed: _cidadeSelecionada.isNotEmpty
                                    ? () {
                                        _buscarHemocentros(_cidadeSelecionada);
                                      }
                                    : null,
                                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                                child: Text("Buscar", style: TextStyle(color: Colors.white)),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  : Center(child: CircularProgressIndicator()),
        ),
      ),
    ));
  }
}
