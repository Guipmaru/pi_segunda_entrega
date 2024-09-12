class User {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String password;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
  });

  // Método para converter um mapa do banco de dados para um objeto User
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      firstName: map['first_name'],
      lastName: map['last_name'],
      email: map['email'],
      password: map['password'],
    );
  }

  // Método para converter o objeto User para um mapa para salvar no banco
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'password': password,
    };
  }
}