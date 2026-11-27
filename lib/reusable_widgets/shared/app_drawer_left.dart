import 'package:material_ui/material_ui.dart';
import 'package:test_project/api/api_service.dart';
import 'package:test_project/reusable_widgets/core/app_colors.dart';
import 'package:test_project/reusable_widgets/core/app_spacing.dart';
import 'package:test_project/reusable_widgets/core/app_text_styles.dart';

class AppDrawerLeft extends StatelessWidget {
  const AppDrawerLeft({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFFEEF5FF),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            color: AppColors.blue,
            padding: const EdgeInsets.fromLTRB(20, 45, 20, 20),
            child: Row(
              children: [
                Image.asset('assets/profile.png', width: 52),
                AppSpacing.w15,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            ApiService.userName,
                            style: AppTextStyles.b1black.copyWith(
                              color: AppColors.white,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            '  •  Personal',
                            style: AppTextStyles.b2grey.copyWith(
                              color: Colors.amber,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                      AppSpacing.h5,
                      Text(
                        ApiService.userEmail,
                        style: AppTextStyles.b2grey.copyWith(
                          color: AppColors.white,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 10),
              children: [
                _drawerItem(Icons.rocket_launch_outlined, 'Getting Started'),
                _drawerItem(Icons.cloud_sync_outlined, 'Sync Data'),
                _drawerItem(Icons.grid_view_outlined, 'Gamification'),
                _drawerItem(Icons.phone_in_talk_outlined, 'Send Logs'),
                _drawerItem(Icons.settings_outlined, 'Settings'),
                _drawerItem(Icons.headset_mic_outlined, 'Help?'),
                _drawerItem(
                  Icons.person_remove_outlined,
                  'Cancel Subscription',
                ),

                const Divider(),

                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 8,
                  ),
                  child: Text(
                    'App Info',
                    style: AppTextStyles.b1black.copyWith(
                      color: AppColors.blue,
                      fontSize: 16,
                    ),
                  ),
                ),

                _drawerItem(Icons.assignment_outlined, 'About Us'),
                _drawerItem(Icons.privacy_tip_outlined, 'Privacy Policy'),
                _drawerItem(Icons.copy_all_outlined, 'Version 1.01.52'),
                _drawerItem(Icons.share_outlined, 'Share App'),
                _drawerItem(Icons.logout_rounded, 'Logout'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _drawerItem(IconData icon, String title) {
    return ListTile(
      leading: Container(
        height: 36,
        width: 48,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Icon(icon, size: 18, color: Colors.black87),
      ),
      title: Text(title, style: AppTextStyles.b1black.copyWith(fontSize: 14)),
      onTap: () {},
    );
  }
}
