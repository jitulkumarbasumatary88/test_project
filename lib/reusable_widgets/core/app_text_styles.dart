import 'package:material_ui/material_ui.dart';
import 'package:test_project/reusable_widgets/core/app_colors.dart';

class AppTextStyles {
  static const h1 = TextStyle(fontSize: 22, fontWeight: FontWeight.w500);
  static const h2 = TextStyle(fontSize: 22, fontWeight: FontWeight.w500);
  static const h3 = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  static const b1black = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 16,
    color: AppColors.black,
  );
  static const b2grey = TextStyle(color: AppColors.grey, fontSize: 16);
}
