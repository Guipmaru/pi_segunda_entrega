import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

// Função para limpar o banco de dados
Future<void> resetDatabase() async {
  String path = join(await getDatabasesPath(), 'app_database.db');
  await deleteDatabase(path);
}

// Classe DatabaseHelper para gerenciar conexão com o banco de dados
class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  static Database? _database;

  // Evitar a criação de novas instâncias de DatabaseHelper fora da classe
  DatabaseHelper._internal();

  // Retorna a instância do banco de dados, se foi criada é retornada, caso contrário o banco de dados é inicializado
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
      version: 1, // Colocar a versão corretamente antes do onCreate
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

        // Dados iniciais do hemocentro
        await db.insert('hemocentros', {
          'nome': 'Hemocentro Unicamp',
          'cidade': 'Campinas',
          'endereco': 'Universidade Estadual de Campinas - R. Carlos Chagas, 480 - Cidade Universitária, Campinas - SP, 13083-878',
        });

        await db.insert('hemocentros', {
          'nome': 'Hemocentro da Santa Casa de São Paulo',
          'cidade': 'São Paulo',
          'endereco': 'R. Marquês de Itu, 579 - Vila Buarque, São Paulo - SP, 01223-001',
        });

        await db.insert('hemocentros', {
          'nome': 'Hemorio',
          'cidade': 'Rio de Janeiro',
          'endereco': 'R. Frei Caneca, 8 - Centro, Rio de Janeiro - RJ, 20211-030',
        });

        await db.insert('hemocentros', {
          'nome': 'HemoRGS',
          'cidade': 'Porto Alegre',
          'endereco': 'Av. Bento Gonçalves, nº 3722 - Partenon, Porto Alegre - RS, 90650-001 ',
        });

        await db.insert('hemocentros', {
          'nome': 'FHEMERON',
          'cidade': 'Porto Velho',
          'endereco': ' Rua Benedito de Souza Brito, s/nº - Setor Industrial, Porto Velho - RO, 76.821-080 ',
        });

        await db.insert('hemocentros', {
          'nome': 'HEMORAIMA',
          'cidade': 'Boa Vista',
          'endereco': 'Av. Brigadeiro Eduardo Gomes, 3418 - Campos do Paricarana, Boa Vista - RR, 69.310-005',
        });

        await db.insert('hemocentros', {
          'nome': 'HEMOACRE',
          'cidade': 'Rio Branco',
          'endereco': 'Av. Getúlio Vargas, nº 2787 - Bosque, Rio Branco - AC, 69.900-607',
        });

        await db.insert('hemocentros', {
          'nome': 'HEMOAP',
          'cidade': 'Macapá',
          'endereco': 'Av. Raimundo Álvares da Costa, s/nº - Centro, Macapá - AP, 68908-170',
        });

        await db.insert('hemocentros', {
          'nome': 'HEMOTO',
          'cidade': 'Palmas',
          'endereco': ' Qd. 301 Norte, conj.02, Lt. 01, Palmas - TO, 77.001-214',
        });

        await db.insert('hemocentros', {
          'nome': 'HEMOES',
          'cidade': 'Vitória',
          'endereco': ' Av. Marechal Campos,1468 - Maruípe, Vitória - ES, 29047-105',
        });

        await db.insert('hemocentros', {
          'nome': 'HEMOMINAS',
          'cidade': 'Belo Horizonte',
          'endereco': 'Rua Grão Para, 882 - Santa Efigênia, Belo Horizonte - MG, 30150-341',
        });

        await db.insert('hemocentros', {
          'nome': 'HEMEPAR',
          'cidade': 'Curitiba',
          'endereco': 'Travessa Joao Prosdocimo,145 - Alto da XV, Curitiba - PR, 80.045-145',
        });

        await db.insert('hemocentros', {
          'nome': 'HEMOSC',
          'cidade': 'Florianópolis',
          'endereco': 'Av. Othon Gama D’Eça, 756 - Praça D. Pedro I - Centro, Florianópolis - SC, 88015-240',
        });

        await db.insert('hemocentros', {
          'nome': 'HEMOBA',
          'cidade': 'Salvador',
          'endereco': 'Ladeira do Hospital Geral, s/n - 2º andar - Brotas, Salvador - BA, 40286-240',
        });

        await db.insert('hemocentros', {
          'nome': 'HEMOAL',
          'cidade': 'Maceió',
          'endereco': ' Av. Jorge de Lima, nº 58 - Trapiche da Barra, Maceió - AL, 57010-300',
        });

        await db.insert('hemocentros', {
          'nome': 'HEMOSE',
          'cidade': 'Aracaju  ',
          'endereco': ' Av. Tancredo Neves, s/nº - Capuxo, Aracaju - SE,  49080-470',
        });

        await db.insert('hemocentros', {
          'nome': 'HEMOÍBA',
          'cidade': 'João Pessoa',
          'endereco': 'Av. D. Pedro II, 1119 - Centro, João Pessoa - PB,  58013-420',
        });

        await db.insert('hemocentros', {
          'nome': 'HEMOMAR',
          'cidade': 'São Luis',
          'endereco': 'Rua 5 de Janeiro, s/nº - Jordoá - MA,  65040-450',
        });

        await db.insert('hemocentros', {
          'nome': 'HEMONORTE',
          'cidade': 'Natal',
          'endereco': 'Av. Alexandrino de Alencar, 1.800 - Tirol, Natal - RN,  59015-350',
        });

        await db.insert('hemocentros', {
          'nome': 'HEMOPI',
          'cidade': 'Teresina',
          'endereco': 'Rua 1º de Maio, 235 - Centro/Sul, Teresina - PI,  64.001-430 ',
        });

        await db.insert('hemocentros', {
          'nome': 'HEMOPE',
          'cidade': 'Recife',
          'endereco': 'Av. Ruy Barbosa, 375 - Graças, Recife - PE,  52011-040 ',
        });

        await db.insert('hemocentros', {
          'nome': 'HEMOCE',
          'cidade': 'Fortaleza',
          'endereco': 'Av. José Bastos, 3.390 - Rodolfo Teófilo, Fortaleza - CE, 60.431-086 ',
        });

        await db.insert('hemocentros', {
          'nome': 'Fundação Hemocentro de Brasília - FHB',
          'cidade': 'Brasília',
          'endereco': 'MHN Quadra 03 Conj. A bloco 3, Brasília - DF, 70710-100 ',
        });

        await db.insert('hemocentros', {
          'nome': 'HEMOGO',
          'cidade': 'Goiânia',
          'endereco': 'Av. Anhanguera 5.195 - Setor Coimbra, Goiânia - GO, 74.535-010 ',
        });

        await db.insert('hemocentros', {
          'nome': 'MT-Hemocentro',
          'cidade': 'Cuiabá',
          'endereco': 'Rua 13 de junho nº 1055 - Porto, Cuiabá - MT, 78020- 000 ',
        });

        await db.insert('hemocentros', {
          'nome': 'HEMOSUL',
          'cidade': ' Campo Grande',
          'endereco': 'Av. Fernando Correa da Costa, nº 1304 - Centro, Campo Grande - MS, 79004-310',
        });

        await db.insert('hemocentros', {
          'nome': 'HEMOAM',
          'cidade': 'Manaus',
          'endereco': 'Endereço: AV. Constantino Neri, Nº 4.397 - Chapada, Manaus - AM, 69.050-001',
        });

        // Criação da tabela de agendamentos com a coluna local
        await db.execute(
          '''
          CREATE TABLE agendamentos(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            user_id INTEGER,
            data TEXT,
            hora TEXT,
            local TEXT,
            FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
          )
          '''
        );
      },
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

  // Função para buscar todas as cidades com hemocentros
  Future<List<String>> getCidadesComHemocentros() async {
    final db = await database;
    List<Map<String, dynamic>> res = await db.rawQuery('SELECT DISTINCT cidade FROM hemocentros');
    return res.map((row) => row['cidade'] as String).toList();
  }

  // Função para inserir um agendamento
  Future<int> insertAgendamento(int userId, String data, String hora, String local) async {
    final db = await database;
    return await db.insert('agendamentos', {
      'user_id': userId,
      'data': data,
      'hora': hora,
      'local': local,
    });
  }
  // Função para buscar o próximo agendamento do usuário
  Future<Map<String, dynamic>?> getAgendamento(int userId) async {
    final db = await database;
    
    var res = await db.query(
      'agendamentos',
      columns: ['data', 'hora', 'local'], 
      where: 'user_id = ?',
      whereArgs: [userId],
      orderBy: 'data ASC, hora ASC',
      limit: 1,
    );
    
    if (res.isNotEmpty) {
      return res.first;
    } else {
      return null;
    }
}
  // Função para buscar agendamentos por usuário
  Future<List<Map<String, dynamic>>> getAgendamentosByUser(int userId) async {
    final db = await database;
    return await db.query(
      'agendamentos',
      where: 'user_id = ?',
      whereArgs: [userId],
    );
  }
    // Função para atualizar o agendamento
  Future<int> updateAgendamento(int userId, String newDate, String newTime , String newLocation) async {
    final db = await database;
    return await db.update(
      'agendamentos',
      {
        'data': newDate,
        'hora': newTime,
        'local': newLocation,
      },
      where: 'user_id = ?',
      whereArgs: [userId],
    );
  }
    // Função para deletar o agendamento
  Future<int> deleteAgendamento(int userId) async {
    final db = await database;
    return await db.delete(
      'agendamentos',
      where: 'user_id = ?',
      whereArgs: [userId],
    );
  }
}
