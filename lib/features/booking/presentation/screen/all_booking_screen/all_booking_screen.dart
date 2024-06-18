import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/features/booking/presentation/state_m/provider/all_booking_screen_notifier.dart';

import 'all_booking_screen_content.dart';
class AllBookingsScreen extends StatefulWidget {
  static const routeName = "/AllBookingsScreen";
  const AllBookingsScreen({Key? key}) : super(key: key);
  @override
  _AllBookingsScreenState createState() => _AllBookingsScreenState();
}

class _AllBookingsScreenState extends State<AllBookingsScreen> {
  final sn = AllBookingsScreenNotifier();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AllBookingsScreenNotifier>.value(
      value: sn,
      child: Scaffold(
        backgroundColor: AppColors.mansourLightGreyColor_6,
        body: AllBookingsScreenContent(),
      ),
    );
  }

  /// Widget

  /// Logic

}
