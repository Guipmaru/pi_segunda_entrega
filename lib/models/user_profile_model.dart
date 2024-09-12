// user_profile_model.dart

class UserProfile {
  final int userId;
  final int idade;
  final String endereco;
  final String cidade;
  final String rg;
  final String cpf;
  final String carteiraDoador;
  final String telefone;
  final String tipoSanguineo;
  final String deficiencia;
  final String doenca;

  UserProfile({
    required this.userId,
    required this.idade,
    required this.endereco,
    required this.cidade,
    required this.rg,
    required this.cpf,
    required this.carteiraDoador,
    required this.telefone,
    required this.tipoSanguineo,
    required this.deficiencia,
    required this.doenca,
  });

  Map<String, dynamic> toMap() {
    return {
      'user_id': userId,
      'idade': idade,
      'endereco': endereco,
      'cidade': cidade,
      'rg': rg,
      'cpf': cpf,
      'carteira_doador': carteiraDoador,
      'telefone': telefone,
      'tipo_sanguineo': tipoSanguineo,
      'deficiencia': deficiencia,
      'doenca': doenca,
    };
  }
// salva userprofife no banco
  factory UserProfile.fromMap(Map<String, dynamic> map) {
    return UserProfile(
      userId: map['user_id'],
      idade: map['idade'],
      endereco: map['endereco'],
      cidade: map['cidade'],
      rg: map['rg'],
      cpf: map['cpf'],
      carteiraDoador: map['carteira_doador'],
      telefone: map['telefone'],
      tipoSanguineo: map['tipo_sanguineo'],
      deficiencia: map['deficiencia'],
      doenca: map['doenca'],
    );
  }
}