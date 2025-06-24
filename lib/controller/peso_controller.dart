import '../database/db_helper.dart';
import '../models/peso.dart';

class PesoController {
  final DBHelper _dbHelper = DBHelper();

  Future<void> registrarPeso(Peso peso) async {
    await _dbHelper.inserirPeso(peso.toMap());
  }

  Future<List<Peso>> listarPesosDoPerfil(int perfilId) async {
    final listaMap = await _dbHelper.listarPesosPorPerfil(perfilId);
    return listaMap.map<Peso>((map) => Peso.fromMap(map)).toList();
  }

  Future<void> apagarPesosDoPerfil(int perfilId) async {
    await _dbHelper.apagarPesosDoPerfil(perfilId);
  }
}