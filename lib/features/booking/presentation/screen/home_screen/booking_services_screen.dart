// import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/features/booking/presentation/state_m/provider/booking_services_screen_notifier.dart';

import 'booking_services_screen_content.dart';
class BookingServicesScreen extends StatefulWidget {
  static const routeName = "/BookingServicesScreen";
  const BookingServicesScreen({Key? key}) : super(key: key);
  @override
  _BookingServicesScreenState createState() => _BookingServicesScreenState();
}

class _BookingServicesScreenState extends State<BookingServicesScreen> {
  final sn = BookingServicesScreenNotifier();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BookingServicesScreenNotifier>.value(
      value: sn,
      child: Scaffold(
        backgroundColor: AppColors.mansourLightGreyColor_6,
        body: BookingServicesScreenContent(),
      ),
    );
  }

  /// Widget

  /// Logic

}
