import 'package:material_ui/material_ui.dart';
import 'package:test_project/reusable_widgets/core/app_colors.dart';

class AppButton extends StatelessWidget {
  final double? width;
  final BorderRadius? borderRadius;
  final Border? border;
  final String? text;
  final VoidCallback? onTap;

  const AppButton({
    super.key,
    this.width,
    this.borderRadius,
    this.border,
    this.text,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
      child: GestureDetector(
        onTap: onTap,

        child: Container(
          width: width ?? double.infinity,
          decoration: BoxDecoration(
            color: AppColors.blue,
            borderRadius: borderRadius ?? BorderRadius.circular(10),
          ),

          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 14),
            child: Center(
              child: Text(
                text!,
                style: TextStyle(
                  color: AppColors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
