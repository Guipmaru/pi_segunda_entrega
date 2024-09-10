// importar os pacotes para acessar e manipular os bancos de dados
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

// Declaração da classe DatabaseHelper para gerenciar conexão com o banco de dados
class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  static Database? _database;
  // evitar a criação de novas instâncias de DatabaseHelper fora da classe
  DatabaseHelper._internal();

  // retorna a instância do banco de dados, se foi criada é retornada, caso contrário o banco de dados é inicializado
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  // Função que inicia o banco de dados, define o caminho e a versão
  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'login.db');
    return await openDatabase(
      path,
      onCreate: (db, version) {
        return db.execute(
          '''
          CREATE TABLE users(
            id INTEGER PRIMARY KEY, 
            first_name TEXT, 
            last_name TEXT, 
            email TEXT, 
            password TEXT
          )
          ''',
        );
      },
      version: 1,
    );
  }

  // Função para inserir um novo usuário no banco de dados com nome, sobrenome, email e senha como parâmetros
  Future<int> insertUser(String firstName, String lastName, String email, String password) async {
    final db = await database;
    return await db.insert('users', {
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'password': password,
    });
  }

  // Função para buscar o usuário com o email e senha fornecidos, se não houver, retorna null
  Future<Map<String, dynamic>?> getUser(String email, String password) async {
    final db = await database;
    var res = await db.query(
      'users',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );
    return res.isNotEmpty ? res.first : null;
  }
}