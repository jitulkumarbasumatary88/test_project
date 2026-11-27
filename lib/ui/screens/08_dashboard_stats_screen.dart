import 'package:fl_chart/fl_chart.dart';
import 'package:material_ui/material_ui.dart';
import 'package:test_project/api/api_service.dart';
import 'package:test_project/model/list_model.dart';
import 'package:test_project/reusable_widgets/core/app_colors.dart';
import 'package:test_project/reusable_widgets/core/app_spacing.dart';
import 'package:test_project/reusable_widgets/core/app_text_styles.dart';
import 'package:test_project/reusable_widgets/shared/app_button.dart';
import 'package:test_project/reusable_widgets/shared/app_container.dart';
import 'package:test_project/reusable_widgets/shared/app_drawer_left.dart';

class DashboardStatsScreen extends StatefulWidget {
  final String listId;
  final String listName;

  const DashboardStatsScreen({
    super.key,
    this.listId = '68626f9497757cb741f449b0',
    this.listName = 'Test List',
  });

  @override
  State<DashboardStatsScreen> createState() => _DashboardStatsScreenState();
}

class _DashboardStatsScreenState extends State<DashboardStatsScreen> {
  ListDetailsModel? listDetails;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchDetails();
  }

  Future<void> _fetchDetails() async {
    setState(() => isLoading = true);
    final result = await ApiService.getListDetails(widget.listId);
    if (!mounted) return;
    setState(() {
      listDetails = result;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final int pending = listDetails?.pending ?? 28;
    final int called = listDetails?.called ?? 22;
    final int rescheduled = listDetails?.rescheduled ?? 9;
    final int totalCalls = pending + called;

    final String firstLetter = ApiService.userName.isNotEmpty
        ? ApiService.userName[0].toUpperCase()
        : 'S';

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FB),
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
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  AppContainer(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: Colors.grey.shade200),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 18,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.listName,
                              style: AppTextStyles.b1black.copyWith(
                                fontSize: 15,
                              ),
                            ),
                            AppSpacing.h5,
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              textBaseline: TextBaseline.alphabetic,
                              children: [
                                Text(
                                  '$totalCalls',
                                  style: AppTextStyles.b1black.copyWith(
                                    color: AppColors.blue,
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                AppSpacing.w5,
                                Text(
                                  'CALLS',
                                  style: AppTextStyles.b2grey.copyWith(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Container(
                          height: 54,
                          width: 54,
                          decoration: BoxDecoration(
                            color: AppColors.blue,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            firstLetter,
                            style: AppTextStyles.b1black.copyWith(
                              color: AppColors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const Spacer(),

                  SizedBox(
                    height: 260,
                    width: 260,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          height: 112,
                          width: 112,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200.withValues(alpha: 0.7),
                            shape: BoxShape.circle,
                          ),
                        ),
                        PieChart(
                          PieChartData(
                            startDegreeOffset: -90,
                            sectionsSpace: 7,
                            centerSpaceRadius: 72,
                            sections: [
                              PieChartSectionData(
                                value: called > 0 ? called.toDouble() : 1,
                                color: AppColors.blue,
                                radius: 34,
                                showTitle: false,
                              ),
                              PieChartSectionData(
                                value: rescheduled > 0
                                    ? rescheduled.toDouble()
                                    : 1,
                                color: const Color(0xFF8B5CF6),
                                radius: 42,
                                showTitle: false,
                              ),
                              PieChartSectionData(
                                value: pending > 0 ? pending.toDouble() : 1,
                                color: const Color(0xFFF59E0B),
                                radius: 34,
                                showTitle: false,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const Spacer(),

                  Row(
                    children: [
                      Expanded(
                        child: _statCard(
                          title: 'Pending',
                          count: pending.toString().padLeft(2, '0'),
                          bgColor: const Color(0xFFFEF3E2),
                          barColor: const Color(0xFFF59E0B),
                        ),
                      ),
                      AppSpacing.w10,
                      Expanded(
                        child: _statCard(
                          title: 'Done',
                          count: called.toString().padLeft(2, '0'),
                          bgColor: const Color(0xFFE4F8E8),
                          barColor: AppColors.green,
                        ),
                      ),
                      AppSpacing.w10,
                      Expanded(
                        child: _statCard(
                          title: 'Schedule',
                          count: rescheduled.toString().padLeft(2, '0'),
                          bgColor: const Color(0xFFF1EBFE),
                          barColor: const Color(0xFF8B5CF6),
                        ),
                      ),
                    ],
                  ),

                  AppSpacing.h20,

                  AppButton(onTap: () {}, text: 'Start Calling Now'),

                  AppSpacing.h15,
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

  Widget _statCard({
    required String title,
    required String count,
    required Color bgColor,
    required Color barColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            height: 44,
            width: 4,
            decoration: BoxDecoration(
              color: barColor,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          AppSpacing.w10,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: AppTextStyles.b1black.copyWith(fontSize: 13)),
              AppSpacing.h5,
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    count,
                    style: AppTextStyles.b1black.copyWith(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'Calls',
                    style: AppTextStyles.b2grey.copyWith(fontSize: 11),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
