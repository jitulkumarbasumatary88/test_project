import 'package:material_ui/material_ui.dart';
import 'package:test_project/api/api_service.dart';
import 'package:test_project/reusable_widgets/core/app_colors.dart';
import 'package:test_project/reusable_widgets/core/app_spacing.dart';
import 'package:test_project/reusable_widgets/core/app_text_styles.dart';
import 'package:test_project/reusable_widgets/shared/app_button.dart';
import 'package:test_project/reusable_widgets/shared/app_container.dart';
import 'package:test_project/reusable_widgets/shared/app_text_field.dart';
import 'package:test_project/ui/screens/02_sign_up_screen.dart';
import 'package:test_project/ui/screens/05_welcome_video_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailController = TextEditingController(
    text: 'dhrubo@yopmail.com',
  );
  final TextEditingController _passwordController = TextEditingController(
    text: '123',
  );

  bool isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleSignIn() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter email and password')),
      );
      return;
    }

    setState(() => isLoading = true);
    await ApiService.login(email: email, password: password);
    if (!mounted) return;
    setState(() => isLoading = false);

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const WelcomeVideoScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.only(bottom: keyboardHeight),
            child: SizedBox(
              height:
                  MediaQuery.of(context).size.height -
                  MediaQuery.of(context).padding.top -
                  MediaQuery.of(context).padding.bottom,
              child: Column(
                children: [
                  AppSpacing.h35,

                  Image.asset('assets/h_logo.png'),

                  AppSpacing.h35,

                  Expanded(
                    child: AppContainer(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(25),
                      ),
                      child: Column(
                        children: [
                          const SizedBox(height: 60),

                          Text('Welcome', style: AppTextStyles.h3),

                          AppSpacing.h5,

                          Text(
                            'Please sign-in to continue',
                            style: AppTextStyles.b2grey,
                          ),

                          AppSpacing.h25,

                          AppTextField(
                            controller: _emailController,
                            hintText: 'Email address',
                            keyboardType: TextInputType.emailAddress,
                            suffixIcon: const Icon(Icons.mail_outline_rounded),
                          ),

                          AppSpacing.h20,

                          AppTextField(
                            controller: _passwordController,
                            hintText: 'Password',
                            obscureText: true,
                            suffixIcon: const Icon(Icons.lock_outline_rounded),
                          ),

                          AppSpacing.h10,

                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              'Forgot Password?',
                              style: AppTextStyles.b1black,
                            ),
                          ),

                          const Spacer(),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Don't have an account? ",
                                style: AppTextStyles.b1black,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const SignUpScreen(),
                                    ),
                                  );
                                },
                                child: Text(
                                  'Sign Up',
                                  style: AppTextStyles.b1black.copyWith(
                                    color: AppColors.blue,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          AppSpacing.h10,

                          AppButton(
                            onTap: isLoading ? () {} : _handleSignIn,
                            text: isLoading ? 'Please wait...' : 'Sign In',
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
