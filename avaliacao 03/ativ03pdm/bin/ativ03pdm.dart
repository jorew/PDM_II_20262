import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

Future<void> main() async {
  // 1. Inicializa o FFI e define a factory global do SQLite
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi; // <--- Definição global obrigatória

  // Caminho do arquivo de banco na raiz do projeto
  final caminhoBanco = p.join(Directory.current.path, 'alunos.db');
  print('Caminho do Banco: $caminhoBanco\n');

  Database? db;

  try {
    // 2. Abre/Cria o banco e a tabela
    db = await abrirBanco(caminhoBanco);

    // 3. Insere os registros
    await inserirAlunos(db);

    // 4. Lista os alunos
    await listarAlunos(db);

  } catch (e) {
    print('[ERRO]: $e');
  } finally {
    if (db != null && db.isOpen) {
      await db.close();
      print('\nConexão encerrada com sucesso.');
    }
  }
}

Future<Database> abrirBanco(String caminho) async {
  try {
    // Usa openDatabase diretamente da biblioteca sqflite_common_ffi
    return await openDatabase(
      caminho,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE tb_alunos (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nome TEXT NOT NULL,
            idade INTEGER NOT NULL
          )
        ''');
        print('[SUCESSO] Tabela "tb_alunos" criada.');
      },
    );
  } catch (e) {
    print('[ERRO AO ABRIR/CRIAR TABELA]: $e');
    rethrow;
  }
}

Future<void> inserirAlunos(Database db) async {
  final alunos = [
    {'nome': 'Ana Silva', 'idade': 20},
    {'nome': 'Carlos Oliveira', 'idade': 22},
    {'nome': 'Mariana Santos', 'idade': 19},
  ];

  try {
    for (var aluno in alunos) {
      final id = await db.insert('tb_alunos', aluno);
      print('[SUCESSO] Inserido aluno ID $id: ${aluno['nome']}');
    }
  } catch (e) {
    print('[ERRO AO INSERIR]: $e');
    rethrow;
  }
}

Future<void> listarAlunos(Database db) async {
  try {
    print('\n--- Alunos Cadastrados ---');
    final List<Map<String, dynamic>> alunos = await db.query('tb_alunos');

    if (alunos.isEmpty) {
      print('Nenhum aluno encontrado.');
      return;
    }

    for (var aluno in alunos) {
      print('ID: ${aluno['id']} | Nome: ${aluno['nome']} | Idade: ${aluno['idade']}');
    }
  } catch (e) {
    print('[ERRO AO CONSULTAR]: $e');
    rethrow;
  }
}