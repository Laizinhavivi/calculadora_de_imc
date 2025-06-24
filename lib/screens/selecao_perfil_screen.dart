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
      appBar: AppBar(title: const Text('Selecione um Usuário')),
      body: FutureBuilder<List<Perfil>>(
        future: _carregarPerfis(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final perfis = snapshot.data!;
          if (perfis.isEmpty) {
            return const Center(child: Text('Nenhum usuário cadastrado.'));
          }
          return ListView.builder(
            itemCount: perfis.length,
            itemBuilder: (context, index) {
              final perfil = perfis[index];
              return ListTile(
                title: Text(perfil.nome),
                subtitle: Text('Altura: ${perfil.altura} m'),
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/home',
                    arguments: perfil,
                  );
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CadastroPerfilScreen()),
          );
          setState(() {}); // Atualiza a lista após cadastrar novo usuário
        },
        child: const Icon(Icons.person_add),
        tooltip: 'Novo Usuário',
      ),
    );
  }
}