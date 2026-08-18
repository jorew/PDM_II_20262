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













