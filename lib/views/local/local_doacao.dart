import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:pi_segunda_entrega/data/database_helper.dart';
/*
class LocalDoacaoPage extends StatefulWidget {
  @override
  _LocalDoacaoPageState createState() => _LocalDoacaoPageState();
}

class _LocalDoacaoPageState extends State<LocalDoacaoPage> {
  DatabaseHelper _dbHelper = DatabaseHelper();
  Map<String, dynamic>? _usuarioLogado;
  Map<String, dynamic>? _perfilUsuario;
  List<Map<String, dynamic>> _hemocentros = [];
  String _mensagemErro = '';

  @override
  void initState() {
    super.initState();
    _carregarDados();
  }

  // Função que carrega dados do usuário logado e seu perfil
  Future<void> _carregarDados() async {
    // Verifica o usuário logado
    Map<String, dynamic>? usuario = await _dbHelper.getUsuarioLogado();
    if (usuario == null) {
      setState(() {
        _mensagemErro = "Nenhum usuário logado.";
      });
      return;
    }

    setState(() {
      _usuarioLogado = usuario;
    });

    // Verifica o perfil do usuário
    Map<String, dynamic>? perfil = await _dbHelper.getUserProfile(usuario['id']);
    if (perfil == null || perfil['cidade'] == null) {
      setState(() {
        _mensagemErro = "Você precisa completar o seu cadastro.";
      });
      return;
    }

    setState(() {
      _perfilUsuario = perfil;
    });

    // Busca hemocentros pela cidade do perfil do usuário
    List<Map<String, dynamic>> hemocentros = await _dbHelper.getHemocentrosByCidade(perfil['cidade']);
    setState(() {
      _hemocentros = hemocentros;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Local de Doação"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _mensagemErro.isNotEmpty
            ? Center(child: Text(_mensagemErro, style: TextStyle(color: Colors.red)))
            : _hemocentros.isNotEmpty
                ? ListView.builder(
                    itemCount: _hemocentros.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(_hemocentros[index]['nome']),
                        subtitle: Text(_hemocentros[index]['endereco']),
                      );
                    },
                  )
                : Center(child: CircularProgressIndicator()),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _mostrarFormularioHemocentro(context),
        child: Icon(Icons.add),
        tooltip: 'Adicionar Hemocentro',
      ),
    );
  }

  // Exibe formulário para adicionar novo hemocentro
  void _mostrarFormularioHemocentro(BuildContext context) {
    TextEditingController nomeController = TextEditingController();
    TextEditingController cidadeController = TextEditingController();
    TextEditingController enderecoController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Adicionar Hemocentro"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: nomeController,
                decoration: InputDecoration(labelText: "Nome"),
              ),
              TextField(
                controller: cidadeController,
                decoration: InputDecoration(labelText: "Cidade"),
              ),
              TextField(
                controller: enderecoController,
                decoration: InputDecoration(labelText: "Endereço"),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text("Cancelar"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("Salvar"),
              onPressed: () async {
                String nome = nomeController.text;
                String cidade = cidadeController.text;
                String endereco = enderecoController.text;

                if (nome.isNotEmpty && cidade.isNotEmpty && endereco.isNotEmpty) {
                  await _dbHelper.insertHemocentro(nome, cidade, endereco);
                  _carregarDados(); // Recarrega os dados
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }
}

        ],
      ),
    );
  }
}
*/
