import 'package:flutter/material.dart';
import '../models/perfil.dart';

class PerfilDetalhesScreen extends StatelessWidget {
  const PerfilDetalhesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final perfil = ModalRoute.of(context)!.settings.arguments as Perfil;

    // Tenta converter a data de nascimento para DateTime para exibir formatado
    DateTime? data;
    try {
      data = DateTime.tryParse(perfil.dataNascimento);
    } catch (_) {
      data = null;
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Detalhes do Perfil')),
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
          ],
        ),
      ),
    );
  }
}