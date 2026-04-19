import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../widgets/common/custom_button.dart';
import '../../widgets/common/custom_text_field.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _buyingPriceController = TextEditingController();
  final _sellingPriceController = TextEditingController();
  final _quantityController = TextEditingController();
  final _lowStockAlertController = TextEditingController();
  final _barcodeController = TextEditingController();
  final _skuController = TextEditingController();

  String? _selectedCategory;
  String? _selectedUnit;

  final List<String> _categories = [
    'Vyakula',
    'Vinywaji',
    'Vifaa vya Usafi',
    'Vifaa vya Nyumbani',
    'Viatu',
    'Nguo',
    'Dawa',
    'Vinginevyo',
  ];

  final List<String> _units = [
    'Piece',
    'Kilogram',
    'Litre',
    'Box',
    'Pack',
    'Bottle',
    'Carton',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _buyingPriceController.dispose();
    _sellingPriceController.dispose();
    _quantityController.dispose();
    _lowStockAlertController.dispose();
    _barcodeController.dispose();
    _skuController.dispose();
    super.dispose();
  }

  void _onSave() {
    if (_formKey.currentState?.validate() ?? false) {
      // Save product
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Ongeza Bidhaa'),
        actions: [
          TextButton(
            onPressed: _onSave,
            child: const Text('Hifadhi'),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image Upload
              Center(
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: AppColors.surfaceDark,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.camera_alt,
                          size: 40,
                          color: AppColors.textTertiary,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Weka Picha',
                          style: TextStyle(
                            color: AppColors.textTertiary,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              
              // Product Name
              CustomTextField(
                label: 'Jina la Bidhaa',
                hint: 'mfano: Sabuni ya Ushaji',
                controller: _nameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Jina la bidhaa linahitajika';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              
              // Category & Unit
              Row(
                children: [
                  Expanded(
                    child: _buildDropdown(
                      label: 'Kategoria',
                      value: _selectedCategory,
                      items: _categories,
                      onChanged: (value) {
                        setState(() {
                          _selectedCategory = value;
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildDropdown(
                      label: 'Kizio',
                      value: _selectedUnit,
                      items: _units,
                      onChanged: (value) {
                        setState(() {
                          _selectedUnit = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              
              // Prices
              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      label: 'Bei ya Kununua',
                      hint: '0',
                      controller: _buyingPriceController,
                      keyboardType: TextInputType.number,
                      prefixIcon: Icons.attach_money,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: CustomTextField(
                      label: 'Bei ya Kuuzia',
                      hint: '0',
                      controller: _sellingPriceController,
                      keyboardType: TextInputType.number,
                      prefixIcon: Icons.sell,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              
              // Stock
              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      label: 'Stock',
                      hint: '0',
                      controller: _quantityController,
                      keyboardType: TextInputType.number,
                      prefixIcon: Icons.inventory_2,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: CustomTextField(
                      label: 'Arifa ya Stock Chache',
                      hint: '10',
                      controller: _lowStockAlertController,
                      keyboardType: TextInputType.number,
                      prefixIcon: Icons.warning_amber,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              
              // Barcode & SKU
              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      label: 'Barcode (Hiari)',
                      hint: 'Scan au andika',
                      controller: _barcodeController,
                      prefixIcon: Icons.qr_code,
                      suffixIcon: Icons.qr_code_scanner,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: CustomTextField(
                      label: 'SKU (Hiari)',
                      hint: 'Mfano: PRD-001',
                      controller: _skuController,
                      prefixIcon: Icons.tag,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              
              // Save Button
              CustomButton(
                text: 'Hifadhi Bidhaa',
                onPressed: _onSave,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDropdown({
    required String label,
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: AppColors.surfaceDark,
            borderRadius: BorderRadius.circular(12),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              isExpanded: true,
              hint: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Chagua',
                  style: TextStyle(color: AppColors.textTertiary),
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              borderRadius: BorderRadius.circular(12),
              items: items.map((item) {
                return DropdownMenuItem(
                  value: item,
                  child: Text(item),
                );
              }).toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }
}
