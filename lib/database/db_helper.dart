class DBHelper {
  static final List<Map<String, dynamic>> _perfis = [];
  static final List<Map<String, dynamic>> _pesos = [];
  static int _perfilIdCounter = 1;
  static int _pesoIdCounter = 1;

  Future<void> inserirPerfil(Map<String, dynamic> perfil) async {
    perfil['id'] = _perfilIdCounter++;
    _perfis.add(Map<String, dynamic>.from(perfil));
    print('Perfil salvo: $perfil');
  }

  Future<List<Map<String, dynamic>>> listarPerfis() async {
    return List<Map<String, dynamic>>.from(_perfis);
  }

  Future<void> inserirPeso(Map<String, dynamic> peso) async {
    peso['id'] = _pesoIdCounter++;
    _pesos.add(Map<String, dynamic>.from(peso));
    print('Peso salvo: $peso');
  }

  Future<List<Map<String, dynamic>>> listarPesosPorPerfil(int perfilId) async {
    return _pesos.where((peso) => peso['perfilId'] == perfilId).toList();
  }

  Future<void> apagarPesosDoPerfil(int perfilId) async {
  _pesos.removeWhere((peso) => peso['perfilId'] == perfilId);
}

Future<void> apagarPerfil(int perfilId) async {
  _perfis.removeWhere((perfil) => perfil['id'] == perfilId);
  await apagarPesosDoPerfil(perfilId);
}

}

