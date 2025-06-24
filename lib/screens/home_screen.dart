import 'package:flutter/material.dart';
import '../models/perfil.dart';
import '../models/peso.dart';
import '../controller/peso_controller.dart';
import '../controller/perfil_controller.dart';
import 'registrar_peso_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final perfil = ModalRoute.of(context)!.settings.arguments as Perfil;
    final PesoController _pesoController = PesoController();
    final PerfilController _perfilController = PerfilController();

    DateTime? data;
    try {
      data = DateTime.tryParse(perfil.dataNascimento);
    } catch (_) {
      data = null;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil e Histórico'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_sweep),
            tooltip: 'Apagar Histórico',
            onPressed: () async {
              final confirm = await showDialog<bool>(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Apagar Histórico'),
                  content: const Text('Tem certeza que deseja apagar TODO o histórico de pesos deste perfil?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: const Text('Cancelar'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context, true),
                      child: const Text('Apagar', style: TextStyle(color: Colors.red)),
                    ),
                  ],
                ),
              );
              if (confirm == true) {
                await _pesoController.apagarPesosDoPerfil(perfil.id!);
                // Atualiza a tela
                (context as Element).reassemble();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Histórico apagado com sucesso!')),
                );
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete_forever),
            tooltip: 'Apagar Perfil',
            onPressed: () async {
              final confirm = await showDialog<bool>(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Apagar Perfil'),
                  content: const Text('Tem certeza que deseja apagar este perfil e todo o histórico?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: const Text('Cancelar'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context, true),
                      child: const Text('Apagar', style: TextStyle(color: Colors.red)),
                    ),
                  ],
                ),
              );
              if (confirm == true) {
                await _perfilController.apagarPerfil(perfil.id!);
                Navigator.popUntil(context, ModalRoute.withName('/'));
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Perfil apagado com sucesso!')),
                );
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nome: ${perfil.nome}'),
            Text('Altura: ${perfil.altura} m'),
            Text('Sexo: ${perfil.sexo}'),
            Text(
              data != null
                  ? 'Nascimento: ${data.day}/${data.month}/${data.year}'
                  : 'Nascimento: ${perfil.dataNascimento}',
            ),
            const SizedBox(height: 20),
            Text('Peso atual: ${perfil.pesoAtual} kg'),
            Text('IMC: ${perfil.imc.toStringAsFixed(2)}'),
            const SizedBox(height: 24),
            const Text(
              'Histórico de Pesos:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: FutureBuilder<List<Peso>>(
                future: _pesoController.listarPesosDoPerfil(perfil.id!),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Text('Nenhum peso registrado.');
                  }
                  final pesos = snapshot.data!;
                  return ListView.builder(
                    itemCount: pesos.length,
                    itemBuilder: (context, index) {
                      final peso = pesos[index];
                      return ListTile(
                        leading: const Icon(Icons.monitor_weight),
                        title: Text('${peso.valor} kg'),
                        subtitle: Text('Data: ${peso.data}'),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (perfil.id != null) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RegistrarPesoScreen(perfilId: perfil.id!),
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('ID do perfil está nulo')),
            );
          }
        },
        child: const Icon(Icons.add),
        tooltip: 'Registrar novo peso',
      ),
    );
  }
}