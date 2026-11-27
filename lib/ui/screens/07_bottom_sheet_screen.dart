import 'package:material_ui/material_ui.dart';
import 'package:test_project/api/api_service.dart';
import 'package:test_project/model/list_model.dart';
import 'package:test_project/reusable_widgets/core/app_colors.dart';
import 'package:test_project/reusable_widgets/core/app_spacing.dart';
import 'package:test_project/reusable_widgets/core/app_text_styles.dart';
import 'package:test_project/reusable_widgets/shared/app_container.dart';
import 'package:test_project/ui/screens/08_dashboard_stats_screen.dart';

class BottomSheetScreen extends StatefulWidget {
  const BottomSheetScreen({super.key});

  @override
  State<BottomSheetScreen> createState() => _BottomSheetScreenState();
}

class _BottomSheetScreenState extends State<BottomSheetScreen> {
  CallListModel? callList;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchList();
  }

  Future<void> _fetchList() async {
    setState(() => isLoading = true);
    final result = await ApiService.getList();
    if (!mounted) return;
    setState(() {
      callList = result;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final String listName = (callList != null && callList!.name.isNotEmpty)
        ? callList!.name
        : 'Test List';
    final String listId = (callList != null && callList!.id.isNotEmpty)
        ? callList!.id
        : '68626f9497757cb741f449b0';

    return Scaffold(
      backgroundColor: Colors.grey,
      body: Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: AppContainer(
            color: AppColors.darkBlue,
            border: Border.all(color: AppColors.darkBlue),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(22)),
            padding: EdgeInsets.zero,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Text(
                    'CALLING LISTS',
                    style: AppTextStyles.b1black.copyWith(
                      color: AppColors.white,
                      fontSize: 15,
                    ),
                  ),
                ),
                AppContainer(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(22),
                  ),
                  padding: const EdgeInsets.fromLTRB(18, 22, 18, 30),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFEEF5FF),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Select Calling List',
                              style: AppTextStyles.b1black.copyWith(
                                fontSize: 15,
                              ),
                            ),
                            GestureDetector(
                              onTap: isLoading ? null : _fetchList,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 14,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.blue,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.refresh_rounded,
                                      color: AppColors.white,
                                      size: 18,
                                    ),
                                    AppSpacing.w5,
                                    Text(
                                      isLoading ? 'Loading...' : 'Refresh',
                                      style: AppTextStyles.b1black.copyWith(
                                        color: AppColors.white,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      AppSpacing.h15,

                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DashboardStatsScreen(
                                listId: listId,
                                listName: listName,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 16,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFEEF5FF),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                isLoading ? 'Loading list...' : listName,
                                style: AppTextStyles.b1black.copyWith(
                                  fontSize: 15,
                                ),
                              ),
                              Container(
                                height: 26,
                                width: 26,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black87,
                                    width: 1.5,
                                  ),
                                  borderRadius: BorderRadius.circular(7),
                                ),
                                child: const Icon(
                                  Icons.arrow_forward_rounded,
                                  size: 16,
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
