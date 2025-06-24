import 'package:flutter/material.dart';
import '../models/perfil.dart';
import '../controller/perfil_controller.dart';
import 'cadastro_perfil_screen.dart';
import 'home_screen.dart';

class SelecaoPerfilScreen extends StatefulWidget {
  const SelecaoPerfilScreen({super.key});

  @override
  State<SelecaoPerfilScreen> createState() => _SelecaoPerfilScreenState();
}

class _SelecaoPerfilScreenState extends State<SelecaoPerfilScreen> {
  final PerfilController _perfilController = PerfilController();

  Future<List<Perfil>> _carregarPerfis() => _perfilController.listarPerfis();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Selecione um Usuário', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF6C63FF),
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 2,
      ),
      body: FutureBuilder<List<Perfil>>(
        future: _carregarPerfis(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final perfis = snapshot.data!;
          if (perfis.isEmpty) {
            return const Center(
              child: Text(
                'Nenhum usuário cadastrado.',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: perfis.length,
            itemBuilder: (context, index) {
              final perfil = perfis[index];
              return Card(
                elevation: 3,
                margin: const EdgeInsets.symmetric(vertical: 10),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: const Color(0xFF6C63FF),
                    child: const Icon(Icons.person, color: Colors.white),
                  ),
                  title: Text(
                    perfil.nome,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  subtitle: Text('Altura: ${perfil.altura} m'),
                  trailing: const Icon(Icons.arrow_forward_ios, color: Color(0xFF6C63FF)),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/home',
                      arguments: perfil,
                    );
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF6C63FF),
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CadastroPerfilScreen()),
          );
          setState(() {}); // Atualiza a lista após cadastrar novo usuário
        },
        child: const Icon(Icons.person_add, color: Colors.white),
        tooltip: 'Novo Usuário',
      ),
    );
  }
}