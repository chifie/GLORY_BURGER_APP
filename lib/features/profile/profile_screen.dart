import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_constants.dart';
import '../../core/widgets/custom_button.dart';
import '../../core/widgets/custom_text_field.dart';
import '../../providers/profile_provider.dart';

/// Profile screen displaying user information with edit functionality.
/// Shows name, email, phone, and address with an edit toggle.
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  bool _initialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      final profile = context.read<ProfileProvider>().profile;
      _nameController.text = profile.name;
      _emailController.text = profile.email;
      _phoneController.text = profile.phone;
      _addressController.text = profile.address;
      _initialized = true;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.offWhite,
      appBar: AppBar(
        title: const Text('My Profile'),
        backgroundColor: AppColors.primaryRed,
        foregroundColor: AppColors.white,
      ),
      body: Consumer<ProfileProvider>(
        builder: (context, profileProvider, _) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // ── Avatar Section ─────────────────────────────
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.darkCharcoal.withValues(alpha: 0.06),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      // Avatar circle
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [AppColors.primaryRed, AppColors.darkRed],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color:
                                  AppColors.primaryRed.withValues(alpha: 0.3),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            _getInitials(profileProvider.profile.name),
                            style: const TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.w800,
                              color: AppColors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        profileProvider.profile.name,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: AppColors.darkCharcoal,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        profileProvider.profile.email,
                        style: const TextStyle(
                          fontSize: 13,
                          color: AppColors.mediumGrey,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // ── Profile Fields ─────────────────────────────
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.darkCharcoal.withValues(alpha: 0.06),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Personal Information',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: AppColors.darkCharcoal,
                            ),
                          ),
                          // Edit toggle button
                          GestureDetector(
                            onTap: () {
                              if (profileProvider.isEditing) {
                                // Save changes
                                profileProvider.updateProfile(
                                  name: _nameController.text.trim(),
                                  email: _emailController.text.trim(),
                                  phone: _phoneController.text.trim(),
                                  address: _addressController.text.trim(),
                                );
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Profile updated successfully'),
                                    duration: AppConstants.snackbarDuration,
                                  ),
                                );
                              } else {
                                profileProvider.toggleEditing();
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              decoration: BoxDecoration(
                                color: profileProvider.isEditing
                                    ? AppColors.successGreen
                                        .withValues(alpha: 0.1)
                                    : AppColors.primaryRed
                                        .withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    profileProvider.isEditing
                                        ? Icons.check
                                        : Icons.edit,
                                    size: 14,
                                    color: profileProvider.isEditing
                                        ? AppColors.successGreen
                                        : AppColors.primaryRed,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    profileProvider.isEditing
                                        ? 'Save'
                                        : 'Edit',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                      color: profileProvider.isEditing
                                          ? AppColors.successGreen
                                          : AppColors.primaryRed,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // Name field
                      CustomTextField(
                        label: 'Full Name',
                        hint: 'Enter your full name',
                        controller: _nameController,
                        enabled: profileProvider.isEditing,
                        prefixIcon:
                            const Icon(Icons.person_outline, size: 20),
                      ),
                      const SizedBox(height: 16),

                      // Email field
                      CustomTextField(
                        label: 'Email Address',
                        hint: 'Enter your email',
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        enabled: profileProvider.isEditing,
                        prefixIcon:
                            const Icon(Icons.email_outlined, size: 20),
                      ),
                      const SizedBox(height: 16),

                      // Phone field
                      CustomTextField(
                        label: 'Phone Number',
                        hint: 'Enter your phone number',
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                        enabled: profileProvider.isEditing,
                        prefixIcon:
                            const Icon(Icons.phone_outlined, size: 20),
                      ),
                      const SizedBox(height: 16),

                      // Address field
                      CustomTextField(
                        label: 'Delivery Address',
                        hint: 'Enter your delivery address',
                        controller: _addressController,
                        maxLines: 2,
                        enabled: profileProvider.isEditing,
                        prefixIcon:
                            const Icon(Icons.location_on_outlined, size: 20),
                      ),

                      // Cancel button (only visible in edit mode)
                      if (profileProvider.isEditing) ...[
                        const SizedBox(height: 16),
                        CustomButton(
                          label: 'Cancel',
                          isOutlined: true,
                          onPressed: () {
                            // Reset controllers to original values
                            final profile = profileProvider.profile;
                            _nameController.text = profile.name;
                            _emailController.text = profile.email;
                            _phoneController.text = profile.phone;
                            _addressController.text = profile.address;
                            profileProvider.cancelEditing();
                          },
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // ── App Info Section ────────────────────────────
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.darkCharcoal.withValues(alpha: 0.06),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      _buildInfoTile(
                        icon: Icons.payment,
                        title: 'Payment Methods',
                        subtitle: 'M-Pesa, HaloPesa, Airtel Money & more',
                      ),
                      const Divider(height: 24),
                      _buildInfoTile(
                        icon: Icons.info_outline,
                        title: 'App Version',
                        subtitle: '1.0.0',
                      ),
                      const Divider(height: 24),
                      _buildInfoTile(
                        icon: Icons.star_outline,
                        title: 'Rate Us',
                        subtitle: 'Love Glory Burger? Give us a star!',
                      ),
                      const Divider(height: 24),
                      _buildInfoTile(
                        icon: Icons.privacy_tip_outlined,
                        title: 'Privacy Policy',
                        subtitle: 'Read our privacy policy',
                      ),
                      const Divider(height: 24),
                      _buildInfoTile(
                        icon: Icons.description_outlined,
                        title: 'Terms of Service',
                        subtitle: 'Read our terms and conditions',
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // ── Logout Button ───────────────────────────────
                CustomButton(
                  label: 'Log Out',
                  isOutlined: true,
                  backgroundColor: AppColors.errorRed,
                  textColor: AppColors.errorRed,
                  icon: Icons.logout,
                  onPressed: () {
                    _showLogoutDialog(context);
                  },
                ),
                const SizedBox(height: 40),
              ],
            ),
          );
        },
      ),
    );
  }

  /// Builds a single info row in the app info section
  Widget _buildInfoTile({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: AppColors.offWhite,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: AppColors.darkCharcoal, size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.darkCharcoal,
                ),
              ),
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.mediumGrey,
                ),
              ),
            ],
          ),
        ),
        const Icon(
          Icons.chevron_right,
          color: AppColors.mediumGrey,
          size: 20,
        ),
      ],
    );
  }

  /// Extracts initials from a full name for the avatar
  String _getInitials(String name) {
    final parts = name.trim().split(' ');
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return parts[0][0].toUpperCase();
  }

  /// Shows a confirmation dialog before logging out
  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: const Text('Log Out'),
        content: const Text(
          'Are you sure you want to log out of Glory Burger?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              // In a real app, this would clear auth state
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Logged out successfully'),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.errorRed,
              foregroundColor: AppColors.white,
            ),
            child: const Text('Log Out'),
          ),
        ],
      ),
    );
  }
}
