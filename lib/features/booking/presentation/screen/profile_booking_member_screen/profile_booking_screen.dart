import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/ui/custom_map/logic/custom_map_model.dart';
import 'package:starter_application/features/booking/presentation/state_m/provider/profile_booking_screen_notifier.dart';

import 'porfile_booking_screen_content.dart';
class ProfileBookingScreen extends StatefulWidget {
  static const routeName = "/ProfileBookingScreen";
  const ProfileBookingScreen({Key? key}) : super(key: key);
  @override
  _ProfileBookingScreenState createState() => _ProfileBookingScreenState();
}

class _ProfileBookingScreenState extends State<ProfileBookingScreen>  {
  final sn = ProfileBookingScreenNotifier();
  final customMapModel = CustomMapModel();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ProfileBookingScreenNotifier>.value(
          value: sn,
        ),
        ChangeNotifierProvider.value(
          value: customMapModel,
        ),
      ],
      child: Scaffold(
        backgroundColor: AppColors.mansourLightGreyColor_6,
        body: ProfileBookingScreenContent(),
      ),
    );
  }

  /// Widget

  /// Logic

}
