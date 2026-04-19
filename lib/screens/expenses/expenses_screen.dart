import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/utils/formatters.dart';

class ExpensesScreen extends StatelessWidget {
  const ExpensesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final expenses = [
      {'category': 'Kodi', 'description': 'Kodi ya Duka', 'amount': 300000, 'date': '19/04/2026'},
      {'category': 'Mishahara', 'description': 'Mshahara wa Wafanyakazi', 'amount': 450000, 'date': '15/04/2026'},
      {'category': 'Manunuzi', 'description': 'Bidhaa za Duka', 'amount': 850000, 'date': '14/04/2026'},
      {'category': 'Usafiri', 'description': 'Usafiri wa Bidhaa', 'amount': 75000, 'date': '12/04/2026'},
      {'category': 'Huduma', 'description': 'Umeme na Maji', 'amount': 120000, 'date': '10/04/2026'},
      {'category': 'Matengenezo', 'description': 'Matengenezo ya Duka', 'amount': 60000, 'date': '08/04/2026'},
    ];

    final categoryColors = {
      'Kodi': AppColors.primary,
      'Mishahara': AppColors.secondary,
      'Manunuzi': AppColors.accent,
      'Usafiri': AppColors.info,
      'Huduma': AppColors.warning,
      'Matengenezo': AppColors.error,
    };

    final totalExpenses = expenses.fold(0, (sum, e) => sum + (e['amount'] as int));

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Matumizi'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {},
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          // Total Summary
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppColors.error, AppColors.warning],
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: AppColors.error.withOpacity(0.3),
                  blurRadius: 15,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              children: [
                Text(
                  'Jumla ya Matumizi (Mwezi)',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  Formatters.formatCurrency(totalExpenses.toDouble()),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          
          // Expenses List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: expenses.length,
              itemBuilder: (context, index) {
                final expense = expenses[index];
                final color = categoryColors[expense['category']] ?? AppColors.primary;
                
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(12),
                    leading: Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: color.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        _getCategoryIcon(expense['category'] as String),
                        color: color,
                      ),
                    ),
                    title: Text(
                      expense['description'] as String,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: color.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            expense['category'] as String,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: color,
                            ),
                          ),
                        ),
                      ],
                    ),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          Formatters.formatCurrency((expense['amount'] as int).toDouble()),
                          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.error,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          expense['date'] as String,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.textTertiary,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        icon: const Icon(Icons.add),
        label: const Text('Ongeza Matumizi'),
      ),
    );
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'Kodi':
        return Icons.home_work;
      case 'Mishahara':
        return Icons.people;
      case 'Manunuzi':
        return Icons.shopping_cart;
      case 'Usafiri':
        return Icons.local_shipping;
      case 'Huduma':
        return Icons.electrical_services;
      case 'Matengenezo':
        return Icons.build;
      default:
        return Icons.category;
    }
  }
}
