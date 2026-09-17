import 'dart:ui';

Color getCategoryColor(String category) {
  switch (category.toLowerCase()) {
    case 'food':
    case 'food & dining':
      return const Color(0xFF0D2538);

    case 'shopping':
      return const Color(0xFF006C4A);

    case 'bills':
    case 'bills & utilities':
      return const Color(0xFF4B6176);

    case 'transport':
    case 'transportation':
      return const Color(0xFF82F5C1);

    case 'entertainment':
      return const Color(0xFFD3E4FE);

    case 'health':
      return const Color(0xFF8B5CF6);

    case 'education':
      return const Color(0xFFF59E0B);

    default:
      return const Color(0xFF73777D);
  }
}
