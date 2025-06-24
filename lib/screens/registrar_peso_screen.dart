import 'package:flutter/material.dart';
import '../models/peso.dart';
import '../controller/peso_controller.dart';

class RegistrarPesoScreen extends StatefulWidget {
  final int perfilId;

  const RegistrarPesoScreen({super.key, required this.perfilId});

  @override
  State<RegistrarPesoScreen> createState() => _RegistrarPesoScreenState();
}

class _RegistrarPesoScreenState extends State<RegistrarPesoScreen> {
  final pesoController = TextEditingController();
  String? dataSelecionada;
  final PesoController _pesoController = PesoController();

  @override
  void dispose() {
    pesoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Registrar Novo Peso')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: pesoController,
              decoration: const InputDecoration(labelText: 'Peso (kg)'),
              keyboardType: TextInputType.number,
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    dataSelecionada == null
                        ? 'Data não selecionada'
                        : 'Data: $dataSelecionada',
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    final data = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime.now(),
                    );
                    if (data != null) {
                      setState(() {
                        dataSelecionada =
                            "${data.year.toString().padLeft(4, '0')}-${data.month.toString().padLeft(2, '0')}-${data.day.toString().padLeft(2, '0')}";
                      });
                    }
                  },
                  child: const Text('Selecionar Data'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                if (pesoController.text.isEmpty || dataSelecionada == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Preencha todos os campos!')),
                  );
                  return;
                }
                final peso = Peso(
                  perfilId: widget.perfilId,
                  valor: double.tryParse(pesoController.text) ?? 0,
                  data: dataSelecionada!,
                );
                await _pesoController.registrarPeso(peso);
                Navigator.pop(context);
              },
              child: const Text('Salvar Peso'),
            ),
          ],
        ),
      ),
    );
  }
}