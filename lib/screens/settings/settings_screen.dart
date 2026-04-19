import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../bloc/auth/auth_bloc.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_constants.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Mipangilio'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Profile Section
          _buildSectionTitle(context, 'Wasifu'),
          _SettingsCard(
            children: [
              _SettingsTile(
                icon: Icons.store,
                title: 'Wasifu wa Biashara',
                subtitle: 'Duka Langu',
                onTap: () {},
              ),
              _SettingsTile(
                icon: Icons.person,
                title: 'Wasifu Wangu',
                subtitle: 'Admin',
                onTap: () {},
              ),
            ],
          ),
          const SizedBox(height: 16),
          
          // Preferences Section
          _buildSectionTitle(context, 'Mapendeleo'),
          _SettingsCard(
            children: [
              _SettingsTile(
                icon: Icons.language,
                title: 'Lugha',
                subtitle: 'Kiswahili',
                onTap: () {},
              ),
              _SettingsTile(
                icon: Icons.dark_mode,
                title: 'Hali ya Giza',
                subtitle: 'Imezimwa',
                trailing: Switch(
                  value: false,
                  onChanged: (value) {},
                ),
              ),
              _SettingsTile(
                icon: Icons.notifications,
                title: 'Arifa',
                subtitle: 'Imewashwa',
                onTap: () {},
              ),
            ],
          ),
          const SizedBox(height: 16),
          
          // Security Section
          _buildSectionTitle(context, 'Usalama'),
          _SettingsCard(
            children: [
              _SettingsTile(
                icon: Icons.lock,
                title: 'Badili Nenosiri',
                onTap: () {},
              ),
              _SettingsTile(
                icon: Icons.fingerprint,
                title: 'Kuingia kwa Alama ya Kidole',
                subtitle: 'Imezimwa',
                trailing: Switch(
                  value: false,
                  onChanged: (value) {},
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          
          // Data Section
          _buildSectionTitle(context, 'Data'),
          _SettingsCard(
            children: [
              _SettingsTile(
                icon: Icons.backup,
                title: 'Hifadhi Nakala',
                subtitle: 'Mwisho: 18/04/2026',
                onTap: () {},
              ),
              _SettingsTile(
                icon: Icons.restore,
                title: 'Rejesha Data',
                onTap: () {},
              ),
              _SettingsTile(
                icon: Icons.delete_forever,
                title: 'Futa Data Zote',
                textColor: AppColors.error,
                onTap: () {},
              ),
            ],
          ),
          const SizedBox(height: 16),
          
          // About Section
          _buildSectionTitle(context, 'Kuhusu'),
          _SettingsCard(
            children: [
              _SettingsTile(
                icon: Icons.info,
                title: 'Toleo',
                subtitle: AppConstants.appVersion,
              ),
              _SettingsTile(
                icon: Icons.help,
                title: 'Msaada na Maelekezo',
                onTap: () {},
              ),
              _SettingsTile(
                icon: Icons.policy,
                title: 'Masharti ya Huduma',
                onTap: () {},
              ),
              _SettingsTile(
                icon: Icons.privacy_tip,
                title: 'Sera ya Faragha',
                onTap: () {},
              ),
            ],
          ),
          const SizedBox(height: 32),
          
          // Logout Button
          BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              return ElevatedButton.icon(
                onPressed: state.status == AuthStatus.loading
                    ? null
                    : () {
                        context.read<AuthBloc>().add(const AuthLogoutRequested());
                      },
                icon: state.status == AuthStatus.loading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.logout),
                label: const Text('Toka'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.error,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 56),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 32),
          
          // Copyright
          Center(
            child: Text(
              '© 2026 Dukafy. Haki zote zimehifadhiwa.',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.textTertiary,
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 8),
      child: Text(
        title,
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
          color: AppColors.textSecondary,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _SettingsCard extends StatelessWidget {
  final List<Widget> children;

  const _SettingsCard({required this.children});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      child: Column(
        children: children,
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;
  final Color? textColor;

  const _SettingsTile({
    required this.icon,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        color: textColor ?? AppColors.primary,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: textColor,
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle!,
              style: TextStyle(
                color: AppColors.textSecondary,
              ),
            )
          : null,
      trailing: trailing ??
          (onTap != null
              ? const Icon(
                  Icons.arrow_forward_ios,
                  size: 18,
                  color: AppColors.textTertiary,
                )
              : null),
      onTap: onTap,
    );
  }
}
