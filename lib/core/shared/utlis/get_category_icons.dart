import 'package:flutter/material.dart';

IconData getCategoryIcon(String category) {
  switch (category.toLowerCase()) {
    case 'food':
    case 'food & dining':
      return Icons.restaurant;

    case 'shopping':
      return Icons.shopping_bag;

    case 'bills':
    case 'bills & utilities':
      return Icons.bolt;

    case 'transport':
    case 'transportation':
      return Icons.directions_car;

    case 'entertainment':
      return Icons.movie;

    case 'health':
      return Icons.health_and_safety;

    case 'education':
      return Icons.school;

    default:
      return Icons.category;
  }
}
