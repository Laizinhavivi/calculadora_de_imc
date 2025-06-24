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
      appBar: AppBar(
        title: const Text('Cadastro de Perfil', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF6C63FF),
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 2,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                TextField(
                  controller: nomeController,
                  decoration: InputDecoration(
                    labelText: 'Nome',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    prefixIcon: const Icon(Icons.person, color: Color(0xFF6C63FF)),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: alturaController,
                  decoration: InputDecoration(
                    labelText: 'Altura (em metros)',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    prefixIcon: const Icon(Icons.height, color: Color(0xFF6C63FF)),
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: pesoController,
                  decoration: InputDecoration(
                    labelText: 'Peso (kg)',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    prefixIcon: const Icon(Icons.monitor_weight, color: Color(0xFF6C63FF)),
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: sexoSelecionado,
                  items: const [
                    DropdownMenuItem(value: 'Masculino', child: Text('Masculino')),
                    DropdownMenuItem(value: 'Feminino', child: Text('Feminino')),
                  ],
                  onChanged: (value) => setState(() => sexoSelecionado = value),
                  decoration: InputDecoration(
                    labelText: 'Sexo',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    prefixIcon: const Icon(Icons.wc, color: Color(0xFF6C63FF)),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        dataNascimento == null
                            ? 'Data de nascimento não selecionada'
                            : 'Nascimento: $dataNascimento',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                    TextButton.icon(
                      icon: const Icon(Icons.calendar_today, color: Color(0xFF6C63FF)),
                      label: const Text('Selecionar Data', style: TextStyle(color: Color(0xFF6C63FF))),
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
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6C63FF),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
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
                ),
              ],
            ),            ),
          ),          ),
        ),        ),
      ),      ),
    );    );
  }  }
}