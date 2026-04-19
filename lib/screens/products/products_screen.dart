import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_colors.dart';
import '../../core/utils/formatters.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Bidhaa'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {},
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: 10,
        itemBuilder: (context, index) {
          final products = [
            {'name': 'Sabuni ya Ushaji', 'price': 1500, 'stock': 45, 'category': 'Vifaa vya Usafi'},
            {'name': 'Mchele (1kg)', 'price': 3500, 'stock': 120, 'category': 'Vyakula'},
            {'name': 'Mafuta ya Kupika', 'price': 8500, 'stock': 25, 'category': 'Vyakula'},
            {'name': 'Sukari (1kg)', 'price': 3000, 'stock': 60, 'category': 'Vyakula'},
            {'name': 'Sabuni ya Nguo', 'price': 2000, 'stock': 8, 'category': 'Vifaa vya Usafi'},
            {'name': 'Shampoo', 'price': 4500, 'stock': 30, 'category': 'Vifaa vya Usafi'},
            {'name': 'Vinywaji vya Baridi', 'price': 1500, 'stock': 150, 'category': 'Vinywaji'},
            {'name': 'Maji (1L)', 'price': 1000, 'stock': 200, 'category': 'Vinywaji'},
            {'name': 'Biskuti', 'price': 2000, 'stock': 40, 'category': 'Vyakula'},
            {'name': 'Chai (250g)', 'price': 2500, 'stock': 35, 'category': 'Vyakula'},
          ];
          
          final product = products[index];
          final isLowStock = (product['stock'] as int) <= 10;
          
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              contentPadding: const EdgeInsets.all(12),
              leading: Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.inventory_2,
                  color: AppColors.primary,
                ),
              ),
              title: Text(
                product['name'] as String,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product['category'] as String,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: isLowStock 
                              ? AppColors.error.withOpacity(0.1) 
                              : AppColors.success.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          'Stock: ${product['stock']}',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: isLowStock ? AppColors.error : AppColors.success,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    Formatters.formatCurrency((product['price'] as int).toDouble()),
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
              onTap: () {},
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/products/add'),
        icon: const Icon(Icons.add),
        label: const Text('Ongeza Bidhaa'),
      ),
    );
  }
}
