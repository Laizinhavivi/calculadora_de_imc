import '../database/db_helper.dart';
import '../models/perfil.dart';

class PerfilController {
  final DBHelper _dbHelper = DBHelper();

  Future<void> salvarPerfil(Perfil perfil) async {
    await _dbHelper.inserirPerfil(perfil.toMap());
  }

  Future<List<Perfil>> listarPerfis() async {
    final listaMap = await _dbHelper.listarPerfis();
    return listaMap.map<Perfil>((map) => Perfil.fromMap(map)).toList();
  }

Future<void> apagarPesosDoPerfil(int perfilId) async {
  await _dbHelper.apagarPesosDoPerfil(perfilId);
}
Future<void> apagarPerfil(int perfilId) async {
  await _dbHelper.apagarPerfil(perfilId);
}
}