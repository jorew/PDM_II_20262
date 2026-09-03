# Anotações das Aulas abaixo:

>PDM II com prof: Taveira>


---
## Dia 04/08/2026:

- "final" no dart é o mesmo de const no python - variável definida, mas não mutável.
- Linguagem parecida com python, porém possui regras parecidas com javaScript ao lembrar do ";" no final de cada linha de código.
- Estudar mais sobre Dart, mais simples e mais proveitoso ao utilizar o Gemini para auxiliar na codagem.


### sites usados:

-  1- [(https://dart.dev/#try-dart)]
-  2- Homebrew para a instalação do Flutter (infelizmente, não efetivada).

  
---
## Dia 06/08/2026:

Tudo da linguagem
link [
(https://github.com/ricdtaveira/mobdev-parte-01/tree/master)]
- Repositório do Prof Ricardo Taveira.


- Dart tem princípios de diversas linguagens fazendo com que a própria linguagem seja bem versátil;

- Multiplataforma;

- Usa classes como base para os apps;

- *Variaveis de ambiente:* valores dinâmicos salvos fora do código de um programa que servem para configurar o comportamento de sistemas e aplicativos. Elas armazenam dados sensíveis como senhas, chaves de API e endereços de bancos de dados, permitindo mudar configurações entre o seu computador e o servidor sem alterar o código-fonte.

- comando "set", existe a pasta path que diz *aonde* todos os programas foram instalados;

- set: mostrar todos os diretórios da máquina;

- SDK: serve para dar run no programa, sua instalação é necessária;

- Tradução de "path" = "caminho";

- $ no dart = concatenação de strings;

- ${} = intercolação;


### B+A = BA

- criar diretório, entrar no diretório, "dart create nome_projeto", entrar no nome_projeto, ls e code .;

- code . = abrir vscode (IDE);

---

## Dia 11/08/2026:

#### Operadores Bit a Bit:

- Trabalhando com número hexedecimal: 0x01; A notação 'x' já define que o valor é hexadecimal;

- A notação '&' = AND, ou seja 'e';

- Álgebra Booleana: 1 com 1 = 1, se tiver um 0 na jogada o número final é 0.

- (x.toRadixString), a lingaugem Dart trabalha como se toda linha de código fosse uma classe (supostamente), e as classes possuem métodos e o toRadix é um deles;

- toRadix: usa a conversão do número em hexadecimal para fazer suas operações;

- Operação em cascata usando StringBuffer(), função que junta palavras ou valores numa mesma variável;

- ~ esta notação é usada para alterar os bits ao contrário demonstrando um novo valor binário, 0 vira 1 e 1 vira 0;

- Se a variável não foi inicializada o seu valor é nulo;

- ? e ?? são operadores de nulidade, ? = "pode ser nulo" e ?? = "Se for nulo";

- .bitLength = Quantos bits são necessários para representar tal valor;
---

## Dia 13/08/2026:

### Testando Mecânicas do Dart

- >> andar para direita e << andar para esquerda;

- Deslocamento(<< >>);

- Entender o comportamento do for, switch-case, while e do-while.


## Dia 18/08/2026:

#### Anotações:

- late: uma variável que será inicializada tardiamente;
- 'dynamic' no lugar do 'var' significa que o valor da variável pode mudar um número significativo de vezes;
- inferencia: atribuição de tipo, uma variável assume o tipo da última atribuição;


> Dart, também possui tipos double, num e int;>
> num, pode assumir valor de tipos double e int, diferente dos outros. Por exemplo: int não pode ser igual à double;>

#### Buffer:
> Buffer: concatena strings numa mesma frase; > 
> String: pode assumir diferentes valores; >
> Quando ocorre a mudança de valor numa variável string - na prática, acontece que a String muda de destino para um outro valor;>

#### Listas:

- List = [] (estrutura principal);
- Colocar tipos da lista usando List<tipo_da_lista>;
- também existe remove;
- {} = objeto;
- Dicionário -> lista de objetos;
- map -> objeto + tipo.

#### Set:
> Set = conjunto;>
- Em conjunto, não há repetição de elementos e ambos os componentes de um conjunto tem tipos semelhantes/iguais;
- Para acessar um valor específico de um set de string se usa elementAt();

#### Queue:
> Fila;>

- Declarada a partir de uma lista

#### Funções:
-> O de sempre;

---

## 20/08/2026:

### Anotações: 
#### POO: os mesmos conceitos vistos na linguagem de programação java;
- Classe -> modularização com membros (variáveis e métodos da própria classe);
- Membros -> elementos compositores da classe;
- Métodos -> funções da classe;


##### Em Dart:

- Private ('_' inicial): - no começo dos atributos + encapsulamento;
- Get (acessador): mesma coisa do Java;
- Set: mesma coisa do java;
- Late: sem valor, equivalente ao null em java;

- this -> acessa a referência do atributo (valor dos atributos);

- Static:
> Atributos Static: todos veem, é visível para todos. > 

- Método Construtor:
> Inicializar atributos e métodos da classe. >

- Getters e Setters:
> Métodos da interface da classe, permitem a modificação de atributos da classe/objeto. >

---

## 27/08/2026:

### Mixin:
- Classe acoplada: usa as funcionalidades de uma classe sem precisar de herança;

### Enum:
- Pendente, completado, rejeitado. Enumeração que, em outras linguagens (exemplo: UML) é usada para representar status de algo ou alguém;
- Em Dart, se usa switchcase como forma de IF/ELSE quando vai se tratar de enumeração;

### Object .json:
- Json: representar um objeto e suas dependências (atributos) na forma de json, geralmente em um arquivo: package.json;
- JSON: javascript object notation, dados da internet;
- map -> transforma em um arquivo.json;
- jsonEncode(): transforma strings em json;
- Object Json: mapa (mapa.dart -> tópico coleções do github)
  >revisão: mapa (map) é um conjunto de elementos e seus respectivos valores>

---

## 03/09/2026:

### Vocabulário:
- assync = assincrona (algo que não acontece no mesmo tempo);



### Anotações de IA
> O tratamento de exceções evita que o seu aplicativo feche sozinho quando ocorre um erro. >

- throw (Lançar): Dispara o alerta de erro quando algo dá errado (ex: idade negativa).

- try (Tentar): Isola o trecho de código que tem risco de falhar.

- catch (Capturar): Pega o erro disparado pelo try (armazenado na variável e) para que você possa tratá-lo com segurança, como exibindo um print(e).

> Em resumo: o try tenta rodar o código, o throw acusa a falha e o catch resolve o problema sem deixar o programa quebrar. >


### Dart:io
> Biblioteca que possui funções para manipular Io = I/O>

### pubspec.yaml
> Dependências requeridas para o projeto. >
- exemplificação: package.json;
- Existem códigos que são necessários a implementação da dependência do http.

### Parse:
> Ler dados ou códigos e transformá-los em um formato que o sistema consiga entender e usar. >




























