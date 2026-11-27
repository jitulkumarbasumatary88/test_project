import 'package:flutter/services.dart';
import 'package:material_ui/material_ui.dart';
import 'package:test_project/api/api_service.dart';
import 'package:test_project/reusable_widgets/core/app_colors.dart';
import 'package:test_project/reusable_widgets/core/app_spacing.dart';
import 'package:test_project/reusable_widgets/core/app_text_styles.dart';
import 'package:test_project/reusable_widgets/shared/app_button.dart';
import 'package:test_project/reusable_widgets/shared/app_container.dart';
import 'package:test_project/ui/screens/05_welcome_video_screen.dart';

class VerifyScreen extends StatefulWidget {
  final String email;
  final String phone;

  const VerifyScreen({
    super.key,
    this.email = 'dhrubo@yopmail.com',
    this.phone = '+91 7676286822',
  });

  @override
  State<VerifyScreen> createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  final List<TextEditingController> _otpControllers = List.generate(
    6,
    (_) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());

  bool isLoading = false;

  @override
  void dispose() {
    for (final c in _otpControllers) {
      c.dispose();
    }
    for (final f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  Future<void> _handleVerifyOtp() async {
    final otp = _otpControllers.map((c) => c.text.trim()).join();

    if (otp.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter the 6-digit OTP')),
      );
      return;
    }

    setState(() => isLoading = true);

    final result = await ApiService.verifyOtp(email: widget.email, otp: otp);

    if (!mounted) return;
    setState(() => isLoading = false);

    if (result['success'] == true) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result['message'] ?? 'OTP Verified')),
      );

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const WelcomeVideoScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result['message'] ?? 'Invalid OTP')),
      );
    }
  }

  Future<void> _handleResendOtp() async {
    final result = await ApiService.sendOtp(email: widget.email);
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(result['message'] ?? 'OTP sent! (Test OTP: 229166)'),
      ),
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
                          const SizedBox(height: 50),

                          Text(
                            'Whatsapp OTP\nVerification',
                            textAlign: TextAlign.center,
                            style: AppTextStyles.h3,
                          ),

                          AppSpacing.h15,

                          Text(
                            'Please ensure that the email id mentioned is valid as we have sent an OTP to your email.',
                            textAlign: TextAlign.center,
                            style: AppTextStyles.b2grey,
                          ),

                          AppSpacing.h30,

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: List.generate(6, (index) {
                              return AppContainer(
                                height: 50,
                                width: 50,
                                padding: EdgeInsets.zero,
                                child: TextField(
                                  controller: _otpControllers[index],
                                  focusNode: _focusNodes[index],
                                  textAlign: TextAlign.center,
                                  keyboardType: TextInputType.number,
                                  maxLength: 1,
                                  style: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                  decoration: const InputDecoration(
                                    counterText: '',
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.symmetric(
                                      vertical: 10,
                                    ),
                                  ),
                                  onChanged: (value) {
                                    if (value.isNotEmpty && index < 5) {
                                      _focusNodes[index + 1].requestFocus();
                                    } else if (value.isEmpty && index > 0) {
                                      _focusNodes[index - 1].requestFocus();
                                    }
                                  },
                                ),
                              );
                            }),
                          ),

                          AppSpacing.h20,

                          Text(
                            '${widget.phone}?',
                            style: AppTextStyles.b1black,
                          ),

                          const Spacer(),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Didn't receive OTP code? ",
                                style: AppTextStyles.b1black,
                              ),
                              GestureDetector(
                                onTap: _handleResendOtp,
                                child: Text(
                                  'Resend OTP',
                                  style: AppTextStyles.b1black.copyWith(
                                    color: AppColors.blue,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          AppSpacing.h10,

                          AppButton(
                            onTap: isLoading ? () {} : _handleVerifyOtp,
                            text: isLoading ? 'Verifying...' : 'Verify',
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
