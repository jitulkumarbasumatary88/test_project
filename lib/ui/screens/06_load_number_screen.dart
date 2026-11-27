import 'package:material_ui/material_ui.dart';
import 'package:test_project/api/api_service.dart';
import 'package:test_project/reusable_widgets/core/app_colors.dart';
import 'package:test_project/reusable_widgets/core/app_spacing.dart';
import 'package:test_project/reusable_widgets/core/app_text_styles.dart';
import 'package:test_project/reusable_widgets/shared/app_button.dart';
import 'package:test_project/reusable_widgets/shared/app_container.dart';
import 'package:test_project/reusable_widgets/shared/app_drawer_left.dart';
import 'package:test_project/ui/screens/07_bottom_sheet_screen.dart';

class LoadNumberScreen extends StatelessWidget {
  const LoadNumberScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawerLeft(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(
          'Dashboard',
          style: AppTextStyles.b1black.copyWith(fontSize: 18),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.headset_mic_outlined),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none_rounded),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            AppContainer(
              color: AppColors.blue,
              border: Border.all(color: AppColors.blue),
              borderRadius: BorderRadius.circular(18),
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
              child: Row(
                children: [
                  Image.asset('assets/profile.png', width: 52),
                  AppSpacing.w15,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hello ${ApiService.userName}',
                        style: AppTextStyles.b2grey.copyWith(
                          color: AppColors.white,
                          fontSize: 13,
                        ),
                      ),
                      AppSpacing.h5,
                      Text(
                        'Welcome to Calley!',
                        style: AppTextStyles.b1black.copyWith(
                          color: AppColors.white,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            AppSpacing.h15,

            Expanded(
              child: AppContainer(
                color: AppColors.darkBlue,
                border: Border.all(color: AppColors.darkBlue),
                borderRadius: BorderRadius.circular(20),
                padding: EdgeInsets.zero,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      child: Text(
                        'LOAD NUMBER TO CALL',
                        style: AppTextStyles.b1black.copyWith(
                          color: AppColors.white,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Expanded(
                      child: AppContainer(
                        borderRadius: BorderRadius.circular(20),
                        padding: const EdgeInsets.fromLTRB(0, 20, 20, 0),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  style: AppTextStyles.b1black.copyWith(
                                    fontSize: 16,
                                    height: 1.4,
                                  ),
                                  children: [
                                    const TextSpan(text: 'Visit '),
                                    TextSpan(
                                      text: 'https://app.getcalley.com',
                                      style: AppTextStyles.b1black.copyWith(
                                        color: AppColors.blue,
                                        fontSize: 16,
                                      ),
                                    ),
                                    const TextSpan(
                                      text: ' to upload numbers that you wish to call using Calley Mobile App.',
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const Spacer(),
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: Image.asset(
                                'assets/load_number.png',
                                height: 195,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            AppSpacing.h15,

            Row(
              children: [
                AppContainer(
                  height: 50,
                  width: 50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.green, width: 1.5),
                  child: Image.asset('assets/whatsapp_logo.png', width: 24),
                ),
                AppSpacing.w10,
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: AppButton(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const BottomSheetScreen(),
                          ),
                        );
                      },
                      text: 'Start Calling Now',
                    ),
                  ),
                ),
              ],
            ),

            AppSpacing.h10,
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 65,
        decoration: BoxDecoration(
          color: const Color(0xFFEEF5FF),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(22)),
          border: Border.all(color: Colors.blue.shade100),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Icon(Icons.home_outlined, color: Colors.black87),
            const Icon(Icons.contact_page_outlined, color: Colors.black87),
            Container(
              height: 44,
              width: 60,
              decoration: BoxDecoration(
                color: AppColors.blue,
                borderRadius: BorderRadius.circular(22),
              ),
              child: const Icon(
                Icons.play_arrow_outlined,
                color: AppColors.white,
                size: 28,
              ),
            ),
            const Icon(Icons.phone_callback_outlined, color: Colors.black87),
            const Icon(Icons.calendar_today_outlined, color: Colors.black87),
          ],
        ),
      ),
    );
  }
}
