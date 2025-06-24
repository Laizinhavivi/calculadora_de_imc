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
    final rainbowColors = [
      Colors.red,
      Colors.orange,
      Colors.yellow,
      Colors.green,
      Colors.blue,
      Colors.indigo,
      Colors.purple,
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Registrar Novo Peso', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.purple,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: LinearGradient(
                  colors: rainbowColors,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              padding: const EdgeInsets.all(3),
              child: Card(
                elevation: 6,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      TextField(
                        controller: pesoController,
                        decoration: InputDecoration(
                          labelText: 'Peso (kg)',
                          labelStyle: const TextStyle(color: Colors.purple),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                          prefixIcon: const Icon(Icons.monitor_weight, color: Colors.purple),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              dataSelecionada == null
                                  ? 'Data não selecionada'
                                  : 'Data: $dataSelecionada',
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                          TextButton.icon(
                            icon: const Icon(Icons.calendar_today, color: Colors.purple),
                            label: const Text('Selecionar Data', style: TextStyle(color: Colors.purple)),
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
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.purple,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
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
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            // Faixa arco-íris decorativa
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: rainbowColors
                  .map((color) => Expanded(
                        child: Container(
                          height: 8,
                          color: color,
                        ),
                      ))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}