import 'package:material_ui/material_ui.dart';
import 'package:test_project/api/api_service.dart';
import 'package:test_project/reusable_widgets/core/app_colors.dart';
import 'package:test_project/reusable_widgets/core/app_spacing.dart';
import 'package:test_project/reusable_widgets/core/app_text_styles.dart';
import 'package:test_project/reusable_widgets/shared/app_button.dart';
import 'package:test_project/reusable_widgets/shared/app_container.dart';
import 'package:test_project/reusable_widgets/shared/app_text_field.dart';
import 'package:test_project/ui/screens/03_verify_screen.dart';
import 'package:test_project/ui/screens/04_sign_in_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  bool isAgreed = false;
  bool isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _handleSignUp() async {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final phone = _phoneController.text.trim();

    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all required fields')),
      );
      return;
    }

    if (!isAgreed) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please agree to Terms and Conditions')),
      );
      return;
    }

    setState(() => isLoading = true);

    final otpResult = await ApiService.sendOtp(email: email);

    if (!mounted) return;
    setState(() => isLoading = false);

    if (otpResult['success'] == true) {
      ApiService.userName = name;
      ApiService.userEmail = email;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(otpResult['message'] ?? 'OTP sent to your email'),
        ),
      );

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => VerifyScreen(
            email: email,
            phone: phone.isNotEmpty ? '+91$phone' : '+91 7676286822',
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(otpResult['message'] ?? 'Failed to send OTP')),
      );
    }
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
                  const Spacer(),

                  Center(child: Image.asset('assets/h_logo.png')),

                  const Spacer(),

                  AppContainer(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(25),
                    ),
                    child: Column(
                      children: [
                        AppSpacing.h20,

                        Text('Welcome!', style: AppTextStyles.h3),

                        Text(
                          'Please register to continue',
                          style: AppTextStyles.b2grey,
                        ),

                        AppSpacing.h20,

                        AppTextField(
                          controller: _nameController,
                          hintText: 'Name',
                          suffixIcon: const Icon(Icons.person_outline_rounded),
                        ),

                        AppSpacing.h20,

                        AppTextField(
                          controller: _emailController,
                          hintText: 'Email Address',
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

                        AppSpacing.h20,

                        AppTextField(
                          hintText: '+91',
                          readOnly: true,
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Image.asset(
                              'assets/india_flag_logo.png',
                              width: 22,
                            ),
                          ),
                          suffixIcon: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Image.asset(
                              'assets/whatsapp_logo.png',
                              width: 22,
                            ),
                          ),
                        ),

                        AppSpacing.h20,

                        AppTextField(
                          controller: _phoneController,
                          hintText: 'Mobile number',
                          keyboardType: TextInputType.phone,
                          suffixIcon: const Icon(Icons.phone_android_outlined),
                        ),

                        AppSpacing.h20,

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() => isAgreed = !isAgreed);
                              },
                              child: Icon(
                                isAgreed
                                    ? Icons.check_box_rounded
                                    : Icons.check_box_outline_blank_rounded,
                                color: isAgreed
                                    ? AppColors.blue
                                    : AppColors.grey,
                                size: 22,
                              ),
                            ),
                            AppSpacing.w5,
                            Text(
                              'I agree to the ',
                              style: AppTextStyles.b1black.copyWith(
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              'Terms and Conditions',
                              style: AppTextStyles.b1black.copyWith(
                                color: AppColors.blue,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),

                        AppSpacing.h30,

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Already have an account? ',
                              style: AppTextStyles.b1black,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const SignInScreen(),
                                  ),
                                );
                              },
                              child: Text(
                                'Sign In',
                                style: AppTextStyles.b1black.copyWith(
                                  color: AppColors.blue,
                                ),
                              ),
                            ),
                          ],
                        ),

                        AppSpacing.h10,

                        AppButton(
                          onTap: isLoading ? () {} : _handleSignUp,
                          text: isLoading ? 'Please wait...' : 'Sign Up',
                        ),
                      ],
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
