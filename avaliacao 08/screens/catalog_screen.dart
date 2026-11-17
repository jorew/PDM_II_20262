import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/cart_model.dart';
import '../models/item.dart';

class CatalogScreen extends StatelessWidget {
  const CatalogScreen({super.key});

  // Lista estática de produtos de exemplo
  static const List<Item> _catalog = [
    Item(id: 1, name: 'Notebook Pro', price: 4500.00, color: Colors.blue),
    Item(id: 2, name: 'Mouse Sem Fio', price: 150.00, color: Colors.green),
    Item(id: 3, name: 'Teclado Mecânico', price: 380.00, color: Colors.orange),
    Item(id: 4, name: 'Monitor 27" 4K', price: 2100.00, color: Colors.purple),
    Item(id: 5, name: 'Headset Gamer', price: 420.00, color: Colors.red),
    Item(id: 6, name: 'Webcam Full HD', price: 290.00, color: Colors.teal),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Catálogo de Produtos'),
        actions: [
          // Consumer apenas no ícone do carrinho para atualizar o contador (Badge)
          Consumer<CartModel>(
            builder: (context, cart, child) {
              return IconButton(
                icon: Badge(
                  label: Text('${cart.items.length}'),
                  isLabelVisible: cart.items.isNotEmpty,
                  child: child,
                ),
                onPressed: () => Navigator.pushNamed(context, '/cart'),
              );
            },
            // O parâmetro 'child' não é reconstruído quando o estado muda
            child: const Icon(Icons.shopping_cart),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: ListView.builder(
        itemCount: _catalog.length,
        itemBuilder: (context, index) {
          final item = _catalog[index];
          return ListTile(
            leading: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: item.color,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            title: Text(item.name, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text('R\$ ${item.price.toStringAsFixed(2)}'),
            trailing: _AddButton(item: item),
          );
        },
      ),
    );
  }
}

class _AddButton extends StatelessWidget {
  final Item item;
  const _AddButton({required this.item});

  @override
  Widget build(BuildContext context) {
    // Escuta apenas se o item específico já está no carrinho
    final isInCart = context.select<CartModel, bool>(
      (cart) => cart.items.contains(item),
    );

    return TextButton(
      onPressed: isInCart
          ? null
          : () {
              // listen: false pois estamos apenas chamando uma ação (não reconstruindo)
              final cart = Provider.of<CartModel>(context, listen: false);
              cart.add(item);

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${item.name} adicionado!'),
                  duration: const Duration(milliseconds: 800),
                ),
              );
            },
      child: isInCart
          ? const Icon(Icons.check, color: Colors.green)
          : const Text('ADICIONAR'),
    );
  }
}