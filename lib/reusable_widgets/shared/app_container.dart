import 'package:material_ui/material_ui.dart';
import 'package:test_project/reusable_widgets/core/app_colors.dart';

class AppContainer extends StatelessWidget {
  final double? height;
  final double? width;
  final EdgeInsetsGeometry? padding;
  final Color? color;
  final BorderRadius? borderRadius;
  final Border? border;
  final Widget? child;

  const AppContainer({
    super.key,
    this.height,
    this.width,
    this.padding,
    this.color,
    this.borderRadius,
    this.border,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: padding ?? EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color ?? AppColors.white,
        borderRadius: borderRadius ?? BorderRadius.circular(10),
        border: border ?? Border.all(color: AppColors.grey300, width: 1.5),
      ),
      child: child,
    );
  }
}
