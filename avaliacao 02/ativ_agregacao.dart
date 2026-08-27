// 14-agregacao.dart  
// Agregação e Composição
import 'dart:convert';

class Dependente {
  late String _nome;

  Dependente(String nome) {
    this._nome = nome;
  }
}

class Funcionario {
  late String _nome;
  late List<Dependente> _dependentes;

  Funcionario(String nome, List<Dependente> dependentes) {
    this._nome = nome;
    this._dependentes = dependentes;
  }
}

class EquipeProjeto {
  late String _nomeProjeto;
  late List<Funcionario> _funcionarios;

  EquipeProjeto(String nomeprojeto, List<Funcionario> funcionarios) {
    _nomeProjeto = nomeprojeto;
    _funcionarios = funcionarios;
  }
}

void main() {
  // 1. Criar varios objetos Dependentes

  // D1
    Dependente D1 = Dependente('Kléber');

  // D2
    Dependente D2 = Dependente('Milena');
  // D3
    Dependente D3 = Dependente('Mikael');


  // 2. Criar varios objetos Funcionario
  // 3. Associar os Dependentes criados aos respectivos
  //    funcionarios

  // Fun1
    Funcionario Fun1 = Funcionario('Guilhermo', [D1]);

  // Fun2
    Funcionario Fun2 = Funcionario('Osvaldo', [D2]);

  // Fun3
    Funcionario Fun3 = Funcionario('Amélia', [D3]);
  
  // Fun4
    Funcionario Fun4 = Funcionario('Analie', [D1]);



  // 4. Criar uma lista de Funcionarios
    List<String> Funcionarios = [Fun1._nome, Fun2._nome, Fun3._nome];
    Funcionarios.add(Fun4._nome);

    print(Funcionarios);



  // 5. criar um objeto Equipe Projeto chamando o metodo
  //    contrutor que da nome ao projeto e insere uma
  //    coleção de funcionario

  EquipeProjeto equipe1 = EquipeProjeto('PP II', [Fun1, Fun2, Fun3, Fun4]);



  // 6. Printar no formato JSON o objeto Equipe Projeto.
  Map toJson() => {
    'nomeProjeto': equipe1._nomeProjeto,
  'funcionarios': equipe1._funcionarios.map((f) => {
    'nome': f._nome,
    'dependentes': f._dependentes.map((d) => {
      'nome': d._nome
    })
  })
  };

  main() {
    EquipeProjeto equipe1 = EquipeProjeto('PP II', [Fun1, Fun2, Fun3, Fun4]);

  String jsonStu = jsonEncode(equipe1);
  print(jsonStu);
}


}
