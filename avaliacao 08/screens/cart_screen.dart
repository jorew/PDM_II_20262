import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/cart_model.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meu Carrinho'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_sweep),
            tooltip: 'Esvaziar carrinho',
            onPressed: () {
              Provider.of<CartModel>(context, listen: false).clear();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Consumer<CartModel>(
              builder: (context, cart, child) {
                if (cart.items.isEmpty) {
                  return const Center(
                    child: Text(
                      'Seu carrinho está vazio.',
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: cart.items.length,
                  itemBuilder: (context, index) {
                    final item = cart.items[index];
                    return ListTile(
                      leading: const Icon(Icons.check_circle_outline),
                      title: Text(item.name),
                      subtitle: Text('R\$ ${item.price.toStringAsFixed(2)}'),
                      trailing: IconButton(
                        icon: const Icon(Icons.remove_circle_outline, color: Colors.red),
                        onPressed: () => cart.remove(item),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          const Divider(height: 1),
          _CartTotal(),
        ],
      ),
    );
  }
}

class _CartTotal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Consumer<CartModel>(
            builder: (context, cart, child) {
              return Text(
                'Total: R\$ ${cart.totalPrice.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              );
            },
          ),
          FilledButton(
            onPressed: () {
              final cart = Provider.of<CartModel>(context, listen: false);
              if (cart.items.isEmpty) return;

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Compra finalizada com sucesso!')),
              );
              cart.clear();
              Navigator.pop(context);
            },
            child: const Text('COMPRAR'),
          ),
        ],
      ),
    );
  }
}