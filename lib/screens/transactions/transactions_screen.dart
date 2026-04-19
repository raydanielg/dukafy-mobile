import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({super.key});

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  String _selectedFilter = 'All';
  final List<String> _filters = ['All', 'Income', 'Expense'];

  final List<Map<String, dynamic>> _transactions = [
    {
      'name': 'Shopping',
      'category': 'Expense',
      'amount': -25000,
      'date': 'Today, 10:30 AM',
      'icon': Icons.shopping_bag,
      'color': const Color(0xFF00C853),
    },
    {
      'name': 'Salary',
      'category': 'Income',
      'amount': 500000,
      'date': 'Yesterday, 09:00 AM',
      'icon': Icons.account_balance_wallet,
      'color': const Color(0xFF00BFA5),
    },
    {
      'name': 'Food & Drinks',
      'category': 'Expense',
      'amount': -15000,
      'date': 'Yesterday, 01:30 PM',
      'icon': Icons.restaurant,
      'color': Colors.orange,
    },
    {
      'name': 'Transport',
      'category': 'Expense',
      'amount': -5000,
      'date': 'Oct 24, 08:30 AM',
      'icon': Icons.directions_car,
      'color': Colors.blue,
    },
    {
      'name': 'Freelance',
      'category': 'Income',
      'amount': 150000,
      'date': 'Oct 23, 04:00 PM',
      'icon': Icons.work,
      'color': const Color(0xFF00C853),
    },
    {
      'name': 'Electricity',
      'category': 'Expense',
      'amount': -45000,
      'date': 'Oct 22, 11:00 AM',
      'icon': Icons.electric_bolt,
      'color': Colors.yellow,
    },
    {
      'name': 'Water Bill',
      'category': 'Expense',
      'amount': -12000,
      'date': 'Oct 21, 02:30 PM',
      'icon': Icons.water_drop,
      'color': Colors.blue,
    },
    {
      'name': 'Investment',
      'category': 'Income',
      'amount': 75000,
      'date': 'Oct 20, 10:00 AM',
      'icon': Icons.trending_up,
      'color': const Color(0xFF00C853),
    },
  ];

  List<Map<String, dynamic>> get _filteredTransactions {
    if (_selectedFilter == 'All') return _transactions;
    return _transactions.where((t) => t['category'] == _selectedFilter).toList();
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.black87),
                    onPressed: () => context.pop(),
                  ),
                  const Expanded(
                    child: Text(
                      'Transactions',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  const SizedBox(width: 48),
                ],
              ),
            ),

            // Search Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Icon(Icons.search, color: Colors.grey.shade500),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextField(
                        style: const TextStyle(
                          color: Colors.black87,
                          fontSize: 16,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Search transactions...',
                          hintStyle: TextStyle(
                            color: Colors.grey.shade500,
                            fontSize: 16,
                          ),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Filter Chips
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: _filters.map((filter) {
                  final isSelected = filter == _selectedFilter;
                  return Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedFilter = filter;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? const Color(0xFF00C853)
                              : Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Text(
                          filter,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: isSelected ? Colors.white : Colors.grey.shade600,
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 20),

            // Transactions List
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: _filteredTransactions.length,
                itemBuilder: (context, index) {
                  final transaction = _filteredTransactions[index];
                  final isIncome = transaction['amount'] > 0;
                  
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        // Icon
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: transaction['color'].withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            transaction['icon'],
                            color: transaction['color'],
                            size: 24,
                          ),
                        ),
                        const SizedBox(width: 16),
                        
                        // Details
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                transaction['name'],
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                transaction['date'],
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey.shade500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        
                        // Amount
                        Text(
                          '${isIncome ? "+" : ""}TZS ${transaction['amount'].abs().toStringAsFixed(0)}',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: isIncome
                                ? const Color(0xFF00C853)
                                : Colors.red,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
