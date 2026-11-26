import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ceara_bus_app/main.dart';

void main() {
  testWidgets('Verifica se a tela inicial do CearáBus carrega', (WidgetTester tester) async {
    await tester.pumpWidget(const CearaBusApp());

    // Verifica se o título da AppBar e o campo de busca aparecem na tela
    expect(find.text('CearáBus • Passagens'), findsOneWidget);
    expect(find.byType(TextField), findsOneWidget);
  });
}