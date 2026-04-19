import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Ripoti'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _ReportCard(
            title: 'Ripoti ya Siku',
            subtitle: 'Mauzo, faida na matumizi ya leo',
            icon: Icons.today,
            color: AppColors.primary,
            onTap: () {},
          ),
          const SizedBox(height: 12),
          _ReportCard(
            title: 'Ripoti ya Wiki',
            subtitle: 'Muhtasari wa wiki nzima',
            icon: Icons.date_range,
            color: AppColors.secondary,
            onTap: () {},
          ),
          const SizedBox(height: 12),
          _ReportCard(
            title: 'Ripoti ya Mwezi',
            subtitle: 'Changanua mauzo ya mwezi mzima',
            icon: Icons.calendar_month,
            color: AppColors.accent,
            onTap: () {},
          ),
          const SizedBox(height: 12),
          _ReportCard(
            title: 'Ripoti ya Bidhaa',
            subtitle: 'Bidhaa zinazouzika vizuri',
            icon: Icons.inventory_2,
            color: AppColors.info,
            onTap: () {},
          ),
          const SizedBox(height: 12),
          _ReportCard(
            title: 'Ripoti ya Wateja',
            subtitle: 'Wateja wanaonunua sana',
            icon: Icons.people,
            color: AppColors.success,
            onTap: () {},
          ),
          const SizedBox(height: 12),
          _ReportCard(
            title: 'Ripoti ya Matumizi',
            subtitle: 'Fanya uchanganuzi wa matumizi',
            icon: Icons.pie_chart,
            color: AppColors.warning,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

class _ReportCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _ReportCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 28,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: AppColors.textTertiary,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
