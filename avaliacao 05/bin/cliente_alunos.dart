import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class Aluno {
  final int id;
  final String nome;
  final String disciplina;
  final double media;
  final int faltas;

  const Aluno({
    required this.id,
    required this.nome,
    required this.disciplina,
    required this.media,
    required this.faltas,
  });

  factory Aluno.fromJson(Map<String, dynamic> json) {
    return Aluno(
      id: json['id'] as int,
      nome: json['nome'] as String,
      disciplina: json['disciplina'] as String,
      media: (json['media'] as num).toDouble(),
      faltas: json['faltas'] as int,
    );
  }
}

String mensagemDoAluno(Aluno aluno) {
  if (aluno.faltas > 20) {
    return 'Reprovado por Faltas';
  }

  if (aluno.media < 6.0) {
    return 'Reprovado';
  }

  return 'Aprovado';
}

Future<List<Aluno>> buscarTodosAlunos() async {
  final url = Uri.parse('http://localhost:8080/api/alunos');

  final response = await http.get(url);

  if (response.statusCode != HttpStatus.ok) {
    throw Exception(
      'Erro ao acessar a API: ${response.statusCode} ${response.reasonPhrase}',
    );
  }

  final resposta = jsonDecode(response.body) as Map<String, dynamic>;

  // No servidor, a lista de alunos está dentro da chave "dados".
  final dados = resposta['dados'] as List<dynamic>;

  return dados
      .map((item) => Aluno.fromJson(item as Map<String, dynamic>))
      .toList();
}

void imprimirCabecalho() {
  print(
    '${'ID'.padRight(5)}'
    '${'NOME'.padRight(22)}'
    '${'DISCIPLINA'.padRight(20)}'
    '${'MEDIA'.padRight(8)}'
    '${'FALTAS'.padRight(8)}'
    'MENSAGEM',
  );

  print('-' * 85);
}

void imprimirAluno(Aluno aluno) {
  final mensagem = mensagemDoAluno(aluno);

  print(
    '${aluno.id.toString().padRight(5)}'
    '${aluno.nome.padRight(22)}'
    '${aluno.disciplina.padRight(20)}'
    '${aluno.media.toStringAsFixed(1).padRight(8)}'
    '${aluno.faltas.toString().padRight(8)}'
    '$mensagem',
  );
}

Future<void> main() async {
  try {
    final alunos = await buscarTodosAlunos();

    imprimirCabecalho();

    for (final aluno in alunos) {
      imprimirAluno(aluno);
    }
  } catch (erro) {
    print('Erro ao consultar alunos: $erro');
    exitCode = 1;
  }
}

