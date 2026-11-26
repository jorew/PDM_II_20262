class Viagem {
  final int id;
  final String viacao;
  final String origem;
  final String destino;
  final String horarioSaida;
  final String horarioChegada;
  final String classe;
  final double preco;
  final int assentosDisponiveis;

  Viagem({
    required this.id,
    required this.viacao,
    required this.origem,
    required this.destino,
    required this.horarioSaida,
    required this.horarioChegada,
    required this.classe,
    required this.preco,
    required this.assentosDisponiveis,
  });

  factory Viagem.fromJson(Map<String, dynamic> json) {
    return Viagem(
      id: json['id'] ?? 0,
      viacao: json['viacao'] ?? '',
      origem: json['origem'] ?? '',
      destino: json['destino'] ?? '',
      horarioSaida: json['horarioSaida'] ?? '',
      horarioChegada: json['horarioChegada'] ?? '',
      classe: json['classe'] ?? 'Convencional',
      preco: (json['preco'] as num?)?.toDouble() ?? 0.0,
      assentosDisponiveis: json['assentosDisponiveis'] ?? 0,
    );
  }
}