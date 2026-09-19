import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_pal/core/shared/widgets/common_dialog.dart';
import 'package:pocket_pal/features/home/cubit/transaction_cubit.dart';
import 'package:pocket_pal/features/profile/cubit/profile_cubit.dart';
import 'package:pocket_pal/features/profile/screens/about/about_screen.dart';
import 'package:pocket_pal/features/profile/screens/about/privacy_screen.dart';
import 'package:pocket_pal/features/profile/screens/edit_profile.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FF),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF7F7F8),
        elevation: 0,
        title: const Text(
          'Profile',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('ACCOUNT'),

            const SizedBox(height: 10),

            _buildSettingsCard(
              children: [
                BlocBuilder<ProfileCubit, ProfileState>(
                  builder: (context, state) {
                    final profile = state is ProfileSuccess
                        ? state.profileModel
                        : context.read<ProfileCubit>().profile;
                    return _buildSettingsTile(
                      icon: Icons.person_outline,
                      title: 'Name',
                      subtitle:
                          (profile?.name != null && profile!.name.isNotEmpty)
                          ? profile.name
                          : 'Not set',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const EditProfile(),
                          ),
                        );
                      },
                    );
                  },
                ),

                const Divider(height: 1),

                BlocBuilder<ProfileCubit, ProfileState>(
                  builder: (context, state) {
                    final profile = state is ProfileSuccess
                        ? state.profileModel
                        : context.read<ProfileCubit>().profile;
                    return _buildSettingsTile(
                      icon: Icons.email_outlined,
                      title: 'Email',
                      subtitle:
                          (profile?.email != null && profile!.email.isNotEmpty)
                          ? profile.email
                          : 'Not set',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const EditProfile(),
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),

            const SizedBox(height: 24),

            _buildSectionTitle('PREFERENCES'),

            const SizedBox(height: 10),

            _buildSettingsCard(
              children: [
                _buildSettingsTile(
                  icon: Icons.currency_rupee,
                  title: 'Currency',
                  subtitle: 'Indian Rupee (₹)',
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return CommonDialog(
                          title: 'Currency',
                          message: 'No other options Avaliable yet.',
                          confirmText: 'Ok',
                          onConfirm: () {},
                        );
                      },
                    );
                  },
                ),

                const Divider(height: 1),

                _buildSettingsTile(
                  icon: Icons.notifications_none_outlined,
                  title: 'Notifications',
                  subtitle: 'Manage your notifications',
                  onTap: () {},
                ),
              ],
            ),

            const SizedBox(height: 24),

            _buildSectionTitle('DATA'),

            const SizedBox(height: 10),

            _buildSettingsCard(
              children: [
                _buildSettingsTile(
                  icon: Icons.download_outlined,
                  title: 'Export Transactions',
                  subtitle: 'Export your transaction data',
                  onTap: () {},
                ),

                const Divider(height: 1),

                _buildSettingsTile(
                  icon: Icons.delete_outline,
                  title: 'Clear All Data',
                  subtitle: 'Delete all your transactions',
                  iconColor: Colors.red,
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return CommonDialog(
                          title: 'Delete All Transactions?',
                          message:
                              'Are you sure you want to delete all your transactions?',
                          confirmText: 'Delete',
                          onConfirm: () {
                            context.read<TransactionCubit>().clearAllData();
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('All data cleared')),
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ],
            ),

            const SizedBox(height: 24),

            _buildSectionTitle('ABOUT'),

            const SizedBox(height: 10),

            _buildSettingsCard(
              children: [
                _buildSettingsTile(
                  icon: Icons.info_outline,
                  title: 'About Pocket Pal',
                  subtitle: 'Version 1.0.0',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AboutScreen()),
                    );
                  },
                ),

                const Divider(height: 1),

                _buildSettingsTile(
                  icon: Icons.privacy_tip_outlined,
                  title: 'Privacy Policy',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PrivacyPolicyScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),

            const SizedBox(height: 30),

            const Center(
              child: Text(
                'Pocket Pal',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

            const SizedBox(height: 6),

            const Center(
              child: Text(
                'Your simple money manager',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w700,
        color: Colors.grey,
        letterSpacing: 0.8,
      ),
    );
  }

  Widget _buildSettingsCard({required List<Widget> children}) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      clipBehavior: Clip.antiAlias,
      child: Column(children: children),
    );
  }

  Widget _buildSettingsTile({
    required IconData icon,
    required String title,
    String? subtitle,
    required VoidCallback onTap,
    Color? iconColor,
    Color? titleColor,
    bool showArrow = true,
  }) {
    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      leading: Container(
        padding: const EdgeInsets.all(9),
        decoration: BoxDecoration(
          color: (iconColor ?? Colors.black).withAlpha(15),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: iconColor ?? Colors.black87, size: 21),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: titleColor ?? Colors.black,
        ),
      ),
      subtitle: subtitle == null
          ? null
          : Padding(
              padding: const EdgeInsets.only(top: 3),
              child: Text(
                subtitle,
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ),
      trailing: showArrow
          ? const Icon(Icons.chevron_right, color: Colors.grey)
          : null,
    );
  }
}
