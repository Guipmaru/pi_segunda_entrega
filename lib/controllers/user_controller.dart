import 'package:pi_segunda_entrega/data/database_helper.dart';
import 'package:pi_segunda_entrega/models/user_model.dart';

class UserController {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  // Função para inserir um novo usuário
  Future<void> insertUser(User user) async {
    await _dbHelper.insertUser(user.firstName, user.lastName, user.email, user.password);
  }

  // Função para buscar um usuário pelo email e senha
  Future<User?> getUser(String email, String password) async {
    var userMap = await _dbHelper.getUser(email, password);
    if (userMap != null) {
      return User.fromMap(userMap);
    }
    return null;
  }

  // Função para buscar o último usuário logado
  Future<User?> getUsuarioLogado() async {
    final db = await _dbHelper.database;
    var res = await db.query('users', orderBy: 'id DESC', limit: 1);
    return res.isNotEmpty ? User.fromMap(res.first) : null;
  }
}