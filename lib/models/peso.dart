class Peso {
  int? id;
  int perfilId;
  double valor;
  String data;

  Peso({
    this.id,
    required this.perfilId,
    required this.valor,
    required this.data,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'perfilId': perfilId,
      'valor': valor,
      'data': data,
    };
  }

  factory Peso.fromMap(Map<String, dynamic> map) {
    return Peso(
      id: map['id'],
      perfilId: map['perfilId'],
      valor: map['valor'],
      data: map['data'],
    );
  }
}