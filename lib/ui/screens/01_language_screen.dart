import 'package:material_ui/material_ui.dart';
import 'package:test_project/reusable_widgets/core/app_colors.dart';
import 'package:test_project/reusable_widgets/core/app_text_styles.dart';
import 'package:test_project/reusable_widgets/shared/app_button.dart';
import 'package:test_project/reusable_widgets/shared/app_container.dart';
import 'package:test_project/ui/screens/02_sign_up_screen.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  String selectedLang = 'English';

  final languages = [
    {'name': 'English', 'native': 'Hi'},
    {'name': 'Hindi', 'native': 'नमस्ते'},
    {'name': 'Bengali', 'native': 'হ্যালো'},
    {'name': 'Kannada', 'native': 'ನಮಸ್ಕಾರ'},
    {'name': 'Punjabi', 'native': 'ਸਤ ਸ੍ਰੀ ਅਕਾਲ'},
    {'name': 'Tamil', 'native': 'வணக்கம்'},
    {'name': 'Telugu', 'native': 'హలో'},
    {'name': 'French', 'native': 'Bonjour'},
    {'name': 'Spanish', 'native': 'Hola'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Center(
                child: Text('Choose Your Language', style: AppTextStyles.h1),
              ),

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 10,
                    right: 10,
                    top: 10,
                    bottom: 30,
                  ),
                  child: AppContainer(
                    borderRadius: BorderRadius.circular(25),
                    child: ListView.builder(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      itemCount: languages.length,
                      itemBuilder: ((context, index) {
                        final lang = languages[index];
                        final isSelected = selectedLang == lang['name'];
                        return ListTile(
                          onTap: () {
                            setState(() {
                              selectedLang = lang['name']!;
                            });
                          },
                          title: Text(
                            lang['name']!,
                            style: AppTextStyles.b1black,
                          ),
                          subtitle: Text(
                            lang['native']!,
                            style: AppTextStyles.b2grey,
                          ),
                          trailing: Icon(
                            isSelected
                                ? Icons.radio_button_checked_rounded
                                : Icons.radio_button_off_rounded,
                            color: isSelected
                                ? AppColors.black
                                : AppColors.grey,
                          ),
                        );
                      }),
                    ),
                  ),
                ),
              ),

              AppButton(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignUpScreen()),
                  );
                },
                text: 'Select',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
