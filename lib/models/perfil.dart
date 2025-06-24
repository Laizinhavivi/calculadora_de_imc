class Perfil {
  int? id;
  String nome;
  double altura;
  String sexo;
  String dataNascimento; // pode ser String (ex: '2024-06-11')
  double pesoAtual;

  Perfil({
    this.id,
    required this.nome,
    required this.altura,
    required this.sexo,
    required this.dataNascimento,
    required this.pesoAtual,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'altura': altura,
      'sexo': sexo,
      'dataNascimento': dataNascimento,
      'pesoAtual': pesoAtual,
    };
  }

  factory Perfil.fromMap(Map<String, dynamic> map) {
    return Perfil(
      id: map['id'],
      nome: map['nome'],
      altura: map['altura'],
      sexo: map['sexo'],
      dataNascimento: map['dataNascimento'],
      pesoAtual: map['pesoAtual'],
    );
  }

  double get imc => pesoAtual / (altura * altura);
}