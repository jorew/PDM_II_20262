import 'package:flutter/material.dart';

class Item {
  final int id;
  final String name;
  final double price;
  final Color color;

  const Item({
    required this.id,
    required this.name,
    required this.price,
    required this.color,
  });
}