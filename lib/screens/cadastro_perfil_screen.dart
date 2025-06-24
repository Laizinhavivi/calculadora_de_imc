import 'package:flutter/material.dart';
import '../models/perfil.dart';
import '../controller/perfil_controller.dart';

class CadastroPerfilScreen extends StatefulWidget {
  const CadastroPerfilScreen({super.key});

  @override
  State<CadastroPerfilScreen> createState() => _CadastroPerfilScreenState();
}

class _CadastroPerfilScreenState extends State<CadastroPerfilScreen> {
  final nomeController = TextEditingController();
  final alturaController = TextEditingController();
  final pesoController = TextEditingController();
  String? sexoSelecionado;
  String? dataNascimento;

  final PerfilController _perfilController = PerfilController();

  @override
  void dispose() {
    nomeController.dispose();
    alturaController.dispose();
    pesoController.dispose();
    super.dispose();
  }

  double _parseDouble(String value) {
    return double.tryParse(value.replaceAll(',', '.')) ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastro de Perfil')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nomeController,
              decoration: const InputDecoration(labelText: 'Nome'),
            ),
            TextField(
              controller: alturaController,
              decoration: const InputDecoration(labelText: 'Altura (em metros)'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: pesoController,
              decoration: const InputDecoration(labelText: 'Peso (kg)'),
              keyboardType: TextInputType.number,
            ),
            DropdownButtonFormField<String>(
              value: sexoSelecionado,
              items: const [
                DropdownMenuItem(value: 'Masculino', child: Text('Masculino')),
                DropdownMenuItem(value: 'Feminino', child: Text('Feminino')),
              ],
              onChanged: (value) => setState(() => sexoSelecionado = value),
              decoration: const InputDecoration(labelText: 'Sexo'),
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    dataNascimento == null
                        ? 'Data de nascimento não selecionada'
                        : 'Nascimento: $dataNascimento',
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    final data = await showDatePicker(
                      context: context,
                      initialDate: DateTime(2000),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                    );
                    if (data != null) {
                      setState(() => dataNascimento =
                          "${data.year.toString().padLeft(4, '0')}-${data.month.toString().padLeft(2, '0')}-${data.day.toString().padLeft(2, '0')}");
                    }
                  },
                  child: const Text('Selecionar Data'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                if (nomeController.text.isEmpty ||
                    alturaController.text.isEmpty ||
                    pesoController.text.isEmpty ||
                    sexoSelecionado == null ||
                    dataNascimento == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Preencha todos os campos!')),
                  );
                  return;
                }
                final perfil = Perfil(
                  id: 1, // Garante que o id não será nulo
                  nome: nomeController.text,
                  altura: _parseDouble(alturaController.text),
                  sexo: sexoSelecionado!,
                  dataNascimento: dataNascimento!,
                  pesoAtual: _parseDouble(pesoController.text),
                );
                await _perfilController.salvarPerfil(perfil);
                Navigator.pushReplacementNamed(
                  context,
                  '/home',
                  arguments: perfil,
                );
              },
              child: const Text('Salvar e Continuar'),
            ),
          ],
        ),
      ),
    );
  }
}