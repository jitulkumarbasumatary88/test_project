import 'package:material_ui/material_ui.dart';
import 'package:test_project/api/api_service.dart';
import 'package:test_project/reusable_widgets/core/app_colors.dart';
import 'package:test_project/reusable_widgets/core/app_spacing.dart';
import 'package:test_project/reusable_widgets/core/app_text_styles.dart';
import 'package:test_project/reusable_widgets/shared/app_button.dart';
import 'package:test_project/reusable_widgets/shared/app_container.dart';
import 'package:test_project/ui/screens/06_load_number_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class WelcomeVideoScreen extends StatelessWidget {
  const WelcomeVideoScreen({super.key});

  final String youtubeUrl = 'https://www.youtube.com/watch?v=bP4U-L4EHcg';
  final String videoId = 'bP4U-L4EHcg';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              AppContainer(
                color: AppColors.blue,
                border: Border.all(color: AppColors.blue),
                borderRadius: BorderRadius.circular(18),
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 16,
                ),
                child: Row(
                  children: [
                    Image.asset('assets/profile.png', width: 45),

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
                          'Calley Personal',
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

              AppSpacing.h20,

              AppContainer(
                color: AppColors.darkBlue,
                border: Border.all(color: AppColors.darkBlue),
                borderRadius: BorderRadius.circular(20),
                padding: EdgeInsets.zero,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 16,
                      ),
                      child: Text(
                        'If you are here for the first time then ensure that you have uploaded the list to call from calley Web Panel hosted on https://app.getcalley.com',
                        textAlign: TextAlign.center,
                        style: AppTextStyles.b1black.copyWith(
                          color: AppColors.white,
                          fontSize: 13,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        await launchUrl(
                          Uri.parse(youtubeUrl),
                          mode: LaunchMode.externalApplication,
                        );
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Image.network(
                              'https://img.youtube.com/vi/$videoId/hqdefault.jpg',
                              width: double.infinity,
                              height: 220,
                              fit: BoxFit.cover,
                            ),
                            Container(
                              height: 45,
                              width: 65,
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Icon(
                                Icons.play_arrow_rounded,
                                color: AppColors.white,
                                size: 32,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const Spacer(),

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
                              builder: (context) => const LoadNumberScreen(),
                            ),
                          );
                        },
                        text: 'Start Calling Now',
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
