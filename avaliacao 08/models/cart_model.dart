import 'dart:collection';
import 'package:flutter/foundation.dart';
import 'item.dart';

class CartModel extends ChangeNotifier {
  // Lista privada contendo os itens internos do carrinho
  final List<Item> _items = [];

  // Visualização imutável dos itens para evitar modificações diretas fora da classe
  UnmodifiableListView<Item> get items => UnmodifiableListView(_items);

  // Calcula o preço total somando o valor de cada item
  double get totalPrice =>
      _items.fold(0.0, (total, current) => total + current.price);

  // Adiciona um item e notifica os ouvintes
  void add(Item item) {
    _items.add(item);
    notifyListeners();
  }

  // Remove um item e notifica os ouvintes
  void remove(Item item) {
    _items.remove(item);
    notifyListeners();
  }

  // Limpa todo o carrinho
  void clear() {
    _items.clear();
    notifyListeners();
  }
}