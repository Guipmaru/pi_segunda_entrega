import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

// classe DatabaseHelper para gerenciar conexão com o banco de dados
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
    String path = join(await getDatabasesPath(), 'app_database.db');
    return await openDatabase(
      path,
      onCreate: (db, version) async {
        // Criação da tabela de usuários
        await db.execute(
          '''
          CREATE TABLE users(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            first_name TEXT,
            last_name TEXT,
            email TEXT,
            password TEXT
          )
          ''',
        );

        // Criação da tabela de perfil do usuário
        await db.execute(
          '''
          CREATE TABLE user_profile(
            user_id INTEGER,
            idade INTEGER,
            endereco TEXT,
            cidade TEXT,
            rg TEXT,
            cpf TEXT,
            carteira_doador TEXT,
            telefone TEXT,
            tipo_sanguineo TEXT,
            deficiencia TEXT,
            doenca TEXT,
            PRIMARY KEY (user_id),
            FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
          )
          ''',
        );

        // Criação da tabela de hemocentros
        await db.execute(
          '''
          CREATE TABLE hemocentros(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nome TEXT,
            cidade TEXT,
            endereco TEXT
          )
          ''',
        );

        // dados iniciais do hemocentro
        await db.insert('hemocentros', {
          'nome': 'Hemocentro Unicamp',
          'cidade': 'Campinas',
          'endereco': 'Universidade Estadual de Campinas - R. Carlos Chagas, 480 - Cidade Universitária, Campinas - SP, 13083-878'
        });

        await db.insert('hemocentros', {
        'nome': 'Hemocentro da Santa Casa de São Paulo',
        'cidade': 'São Paulo',
        'endereco': 'R. Marquês de Itu, 579 - Vila Buarque, São Paulo - SP, 01223-001'
         });
        
        await db.insert('hemocentros', {
        'nome': 'Hemorio',
        'cidade': 'Rio de Janeiro',
        'endereco': 'R. Frei Caneca, 8 - Centro, Rio de Janeiro - RJ, 20211-030'
      },
      version: 1,
    );
  }

  // Função para inserir um novo usuário no banco de dados
  Future<int> insertUser(String firstName, String lastName, String email, String password) async {
    final db = await database;
    return await db.insert('users', {
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'password': password,
    });
  }

  // Função para buscar um usuário com o email e senha fornecidos
  Future<Map<String, dynamic>?> getUser(String email, String password) async {
    final db = await database;
    var res = await db.query(
      'users',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );
    return res.isNotEmpty ? res.first : null;
  }

  // Função para buscar o último usuário logado no banco de dados
  Future<Map<String, dynamic>?> getUsuarioLogado() async {
    final db = await database;
    var res = await db.query('users', orderBy: 'id DESC', limit: 1);
    return res.isNotEmpty ? res.first : null;
  }

  // Função para atualizar o perfil do usuário
  Future<int> updateUserProfile(int userId, Map<String, dynamic> profileData) async {
    final db = await database;
    return await db.insert('user_profile', {
      'user_id': userId,
      ...profileData,
    }, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // Função para buscar o perfil do usuário
  Future<Map<String, dynamic>?> getUserProfile(int userId) async {
    final db = await database;
    var res = await db.query('user_profile', where: 'user_id = ?', whereArgs: [userId]);
    return res.isNotEmpty ? res.first : null;
  }

  // Função para inserir um novo hemocentro no banco de dados
  Future<int> insertHemocentro(String nome, String cidade, String endereco) async {
    final db = await database;
    return await db.insert('hemocentros', {
      'nome': nome,
      'cidade': cidade,
      'endereco': endereco,
    });
  }

  // Função para buscar hemocentros por cidade
  Future<List<Map<String, dynamic>>> getHemocentrosByCidade(String cidade) async {
    final db = await database;
    return await db.query(
      'hemocentros',
      where: 'cidade = ?',
      whereArgs: [cidade],
    );
  }
}
