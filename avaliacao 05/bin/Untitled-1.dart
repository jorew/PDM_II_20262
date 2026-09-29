import 'dart:convert';
import 'dart:io';

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_router/shelf_router.dart';

class Aluno {
  final int id;
  final String nome;
  final String email;
  final String curso;
  final int idade;
  final double media;
  final bool ativo;
  final String disciplina;
  final int faltas;

  const Aluno({
    required this.id,
    required this.nome,
    required this.email,
    required this.curso,
    required this.idade,
    required this.media,
    required this.ativo,
    required this.disciplina,
    required this.faltas,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'email': email,
      'curso': curso,
      'idade': idade,
      'media': media,
      'ativo': ativo,
      'disciplina': disciplina,
      'faltas': faltas,
    };
  }

  static Aluno fromJson(Map<String, dynamic> json) {
    return Aluno(
      id: json['id'] as int,
      nome: json['nome'] as String,
      email: json['email'] as String,
      curso: json['curso'] as String,
      idade: json['idade'] as int,
      media: (json['media'] as num).toDouble(),
      ativo: json['ativo'] as bool? ?? true,
      disciplina: json['disciplina'] as String,
      faltas: json['faltas'] as int,
    );
  }
}

final List<Aluno> alunos = [
  const Aluno(
    id: 1,
    nome: 'Ana Souza',
    email: 'ana.souza@example.com',
    curso: 'Engenharia de Computação',
    idade: 21,
    media: 8.7,
    ativo: true,
    disciplina: 'Programação',
    faltas: 5,
  ),
  const Aluno(
    id: 2,
    nome: 'Bruno Lima',
    email: 'bruno.lima@example.com',
    curso: 'Engenharia Mecânica',
    idade: 23,
    media: 5.0,
    ativo: true,
    disciplina: 'Física',
    faltas: 10,
  ),
  const Aluno(
    id: 3,
    nome: 'Carla Mendes',
    email: 'carla.mendes@example.com',
    curso: 'Sistemas de Informação',
    idade: 20,
    media: 9.2,
    ativo: true,
    disciplina: 'Banco de Dados',
    faltas: 25,
  ),
  const Aluno(
    id: 4,
    nome: 'Diego Alves',
    email: 'diego.alves@example.com',
    curso: 'Engenharia Civil',
    idade: 25,
    media: 4.5,
    ativo: false,
    disciplina: 'Cálculo',
    faltas: 30,
  ),
  const Aluno(
    id: 5,
    nome: 'Elena Costa',
    email: 'elena.costa@example.com',
    curso: 'Ciência da Computação',
    idade: 19,
    media: 6.0,
    ativo: true,
    disciplina: 'Banco de Dados',
    faltas: 15,
  ),
];

Response jsonResponse(
  Object body, {
  int status = HttpStatus.ok,
}) {
  return Response(
    status,
    body: jsonEncode(body),
    headers: {
      HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
    },
  );
}

Response listarAlunos(Request request) {
  final query = request.url.queryParameters;
  final curso = query['curso']?.toLowerCase();
  final nome = query['nome']?.toLowerCase();
  final ativo = query['ativo'];

  final resultado = alunos.where((aluno) {
    final correspondeCurso =
        curso == null || aluno.curso.toLowerCase().contains(curso);

    final correspondeNome =
        nome == null || aluno.nome.toLowerCase().contains(nome);

    final correspondeAtivo =
        ativo == null || aluno.ativo.toString() == ativo.toLowerCase();

    return correspondeCurso && correspondeNome && correspondeAtivo;
  }).toList();

  return jsonResponse({
    'total': resultado.length,
    'dados': resultado.map((aluno) => aluno.toJson()).toList(),
  });
}

Response listarAprovados(Request request) {
  final aprovados = alunos.where((aluno) {
    return aluno.media >= 6.0 && aluno.faltas <= 20;
  }).toList();

  return jsonResponse({
    'total': aprovados.length,
    'dados': aprovados.map((aluno) => aluno.toJson()).toList(),
  });
}

Response listarReprovados(Request request) {
  final reprovados = alunos.where((aluno) {
    return aluno.media < 6.0 || aluno.faltas > 20;
  }).toList();

  return jsonResponse({
    'total': reprovados.length,
    'dados': reprovados.map((aluno) => aluno.toJson()).toList(),
  });
}

Response buscarAlunoPorId(Request request, String id) {
  final idNumerico = int.tryParse(id);

  if (idNumerico == null) {
    return jsonResponse(
      {'erro': 'O ID deve ser um número inteiro.'},
      status: HttpStatus.badRequest,
    );
  }

  Aluno? alunoEncontrado;

  for (final aluno in alunos) {
    if (aluno.id == idNumerico) {
      alunoEncontrado = aluno;
      break;
    }
  }

  if (alunoEncontrado == null) {
    return jsonResponse(
      {'erro': 'Aluno não encontrado.'},
      status: HttpStatus.notFound,
    );
  }

  return jsonResponse(alunoEncontrado.toJson());
}

Future<Response> criarAluno(Request request) async {
  try {
    final body = await request.readAsString();
    final dados = jsonDecode(body) as Map<String, dynamic>;

    final novoAluno = Aluno.fromJson({
      ...dados,
      'id': alunos.isEmpty ? 1 : alunos.last.id + 1,
    });

    alunos.add(novoAluno);

    return jsonResponse(
      novoAluno.toJson(),
      status: HttpStatus.created,
    );
  } on FormatException {
    return jsonResponse(
      {'erro': 'JSON inválido.'},
      status: HttpStatus.badRequest,
    );
  } catch (_) {
    return jsonResponse(
      {
        'erro':
            'Dados inválidos. Informe nome, email, curso, idade, media, disciplina e faltas.',
      },
      status: HttpStatus.badRequest,
    );
  }
}

Response health(Request request) {
  return jsonResponse({
    'status': 'ok',
    'servico': 'api-alunos',
    'timestamp': DateTime.now().toUtc().toIso8601String(),
  });
}

Router createRouter() {
  final router = Router()
    ..get('/health', health)

    // Lista todos os alunos.
    ..get('/api/alunos', listarAlunos)

    // Lista alunos aprovados e reprovados.
    ..get('/api/alunos/aprovados', listarAprovados)
    ..get('/api/alunos/reprovados', listarReprovados)

    // Busca individual: /api/alunos/id/1
    ..get('/api/alunos/id/<id>', buscarAlunoPorId)

    // Cadastra um novo aluno.
    ..post('/api/alunos', criarAluno);

  return router;
}

Future<void> main() async {
  final port = int.tryParse(Platform.environment['PORT'] ?? '') ?? 8080;

  final handler = const Pipeline()
      .addMiddleware(logRequests())
      .addHandler(createRouter().call);

  final server = await shelf_io.serve(
    handler,
    InternetAddress.anyIPv4,
    port,
  );

  server.autoCompress = true;

  print('Servidor iniciado em http://${server.address.host}:${server.port}');
  print('Todos:      http://localhost:$port/api/alunos');
  print('Aprovados:  http://localhost:$port/api/alunos/aprovados');
  print('Reprovados: http://localhost:$port/api/alunos/reprovados');
}