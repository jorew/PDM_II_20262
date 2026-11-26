import 'package:flutter/material.dart';
import '../models/viagem.dart';
import '../services/passagem_service.dart';

class PassagensScreen extends StatefulWidget {
  const PassagensScreen({super.key});

  @override
  State<PassagensScreen> createState() => _PassagensScreenState();
}

class _PassagensScreenState extends State<PassagensScreen> {
  final PassagemService _service = PassagemService();
  final TextEditingController _buscaController = TextEditingController();
  late Future<List<Viagem>> _viagensFuture;

  @override
  void initState() {
    super.initState();
    _viagensFuture = _service.buscarViagens();
  }

  Future<void> _recarregar() async {
    setState(() {
      _viagensFuture = _service.buscarViagens(destino: _buscaController.text);
    });
    await _viagensFuture;
  }

  Future<void> _confirmarCompra(Viagem viagem) async {
    try {
      final mensagem = await _service.comprarPassagem(viagem.id);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(mensagem), backgroundColor: Colors.green.shade700),
      );
      _recarregar(); // Atualiza a contagem de assentos na tela
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString().replaceAll('Exception: ', '')),
          backgroundColor: Colors.red.shade700,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CearáBus • Passagens'),
        backgroundColor: Colors.green.shade800,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          // Campo de filtro por cidade de destino
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: _buscaController,
              decoration: InputDecoration(
                hintText: 'Buscar destino (ex: Sobral, Jericoacoara...)',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _buscaController.clear();
                    _recarregar();
                  },
                ),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onSubmitted: (_) => _recarregar(),
            ),
          ),

          // Lista dinâmica consumindo a API
          Expanded(
            child: FutureBuilder<List<Viagem>>(
              future: _viagensFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.directions_bus_outlined, size: 64, color: Colors.grey),
                          const SizedBox(height: 12),
                          Text(
                            snapshot.error.toString().replaceAll('Exception: ', ''),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton.icon(
                            onPressed: _recarregar,
                            icon: const Icon(Icons.refresh),
                            label: const Text('Tentar Novamente'),
                          ),
                        ],
                      ),
                    ),
                  );
                }

                final viagens = snapshot.data ?? [];
                if (viagens.isEmpty) {
                  return const Center(child: Text('Nenhuma rota encontrada para esse destino.'));
                }

                return RefreshIndicator(
                  onRefresh: _recarregar,
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    itemCount: viagens.length,
                    itemBuilder: (context, index) {
                      final v = viagens[index];
                      final semVagas = v.assentosDisponiveis <= 0;

                      return Card(
                        elevation: 3,
                        margin: const EdgeInsets.only(bottom: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    v.viacao,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green.shade800,
                                      fontSize: 15,
                                    ),
                                  ),
                                  Chip(
                                    label: Text(v.classe, style: const TextStyle(fontSize: 12)),
                                    visualDensity: VisualDensity.compact,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text('${v.horarioSaida} • ${v.origem}'),
                              const Icon(Icons.arrow_downward, size: 16, color: Colors.grey),
                              Text(
                                '${v.horarioChegada} • ${v.destino}',
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                              const Divider(height: 24),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'R\$ ${v.preco.toStringAsFixed(2).replaceAll('.', ',')}',
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        semVagas
                                            ? 'Esgotado'
                                            : '${v.assentosDisponiveis} poltronas livres',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: semVagas ? Colors.red : Colors.grey.shade700,
                                        ),
                                      ),
                                    ],
                                  ),
                                  FilledButton(
                                    onPressed: semVagas ? null : () => _confirmarCompra(v),
                                    style: FilledButton.styleFrom(
                                      backgroundColor: Colors.green.shade700,
                                    ),
                                    child: const Text('Comprar'),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}