import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../models/viagem.dart';

class PassagemService {
  // 10.0.2.2 aponta para o localhost do PC no Emulador Android.
  // Para iOS Simulator use http://localhost:3000/api
  // Para celular físico use o IP da sua máquina na rede Wi-Fi (ex: http://192.168.1.10:3000/api)
  static const String _baseUrl = 'http://localhost:3000/api';

  Future<List<Viagem>> buscarViagens({String? destino}) async {
    try {
      final uri = Uri.parse('$_baseUrl/viagens').replace(
        queryParameters: (destino != null && destino.isNotEmpty)
            ? {'destino': destino}
            : null,
      );

      final response = await http.get(uri).timeout(const Duration(seconds: 8));

      if (response.statusCode == 200) {
        final List<dynamic> listaJson = jsonDecode(utf8.decode(response.bodyBytes));
        return listaJson.map((item) => Viagem.fromJson(item)).toList();
      } else {
        throw Exception('Falha ao carregar horários (HTTP ${response.statusCode})');
      }
    } on SocketException {
      throw Exception('Não foi possível conectar ao servidor. Verifique se a API está rodando.');
    } on TimeoutException {
      throw Exception('Tempo de conexão esgotado.');
    }
  }

  Future<String> comprarPassagem(int viagemId) async {
    final response = await http
        .post(Uri.parse('$_baseUrl/viagens/$viagemId/comprar'))
        .timeout(const Duration(seconds: 8));

    final body = jsonDecode(utf8.decode(response.bodyBytes));
    if (response.statusCode == 200) {
      return 'Bilhete ${body['bilhete']['codigo']} confirmado!';
    } else {
      throw Exception(body['erro'] ?? 'Erro ao comprar passagem.');
    }
  }
}