// import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/features/home_services/presentation/state_m/provider/home_services_screen_notifier.dart';

import 'home_services_screen_content.dart';
class HomeServicesScreen extends StatefulWidget {
  static const routeName = "/HomeServicesScreen";
  const HomeServicesScreen({Key? key}) : super(key: key);
  @override
  _HomeServicesScreenState createState() => _HomeServicesScreenState();
}

class _HomeServicesScreenState extends State<HomeServicesScreen> {
  final sn = HomeServicesScreenNotifier();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeServicesScreenNotifier>.value(
      value: sn,
      child: Scaffold(
        backgroundColor: AppColors.mansourLightGreyColor_6,
        body: Stack(
          children: [
            Container(
              height: 1.sh,
              width: 1.sw,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: 0.3.sh,
                      color: AppColors.mansourLightBlueColor,
                    ),
                    Container(
                      height: 0.7.sh,
                      color: AppColors.mansourLightGreyColor_4,
                    )
                  ],
                ),
              ),
            ),
            HomeServicesScreenContent()
          ],
        ),
      ),
    );
  }

  /// Widget

  /// Logic

}
