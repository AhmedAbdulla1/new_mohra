import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/features/booking/presentation/state_m/provider/services_details_screen_notifier.dart';

import 'services_details_screen_content.dart';

class ServicesDetailsScreenParam {
  final int productId;
  final Function? onBack;

  ServicesDetailsScreenParam(this.productId, {this.onBack});
}

class ServicesDetailsScreen extends StatefulWidget {
  static const String routeName = "/ServicesDetailsScreen";

  const ServicesDetailsScreen({Key? key}) : super(key: key);

  @override
  _ServicesDetailsScreenState createState() => _ServicesDetailsScreenState();
}

class _ServicesDetailsScreenState extends State<ServicesDetailsScreen> {
   final ServicesDetailsScreenNotifier sn = ServicesDetailsScreenNotifier();
  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, _) {
        return ChangeNotifierProvider<ServicesDetailsScreenNotifier>.value(
          value: sn,
          child: Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              backgroundColor: AppColors.transparent,
              elevation: 0.0,
              leadingWidth: 66,
              leading: InkWell(
                  onTap: () {
                    Nav.pop();
                  },
                  child: Icon(
                    AppConstants.getIconBack(),
                    color: Colors.white,
                  )),
              actions: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {},
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            SizedBox(
                              height: 60.h,
                              width: 60.h,
                              child: SvgPicture.asset(
                                AppConstants.SVG_SHOP_CART,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Gaps.hGap15,
                      InkWell(
                        onTap: () {
                        },
                        child: SizedBox(
                          height: 60.h,
                          width: 60.h,
                          child: SvgPicture.asset(
                            AppConstants.SVG_SHARE_FILL,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            backgroundColor: AppColors.white,
            body: const ServicesDetailsScreenContent(),
          ),
        );
      },
    );
  }

}
