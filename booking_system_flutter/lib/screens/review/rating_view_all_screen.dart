import 'package:booking_system_flutter/main.dart';
import 'package:booking_system_flutter/model/service_detail_response.dart';
import 'package:booking_system_flutter/network/rest_apis.dart';
import 'package:booking_system_flutter/screens/review/components/review_widget.dart';
import 'package:booking_system_flutter/screens/review/shimmer/review_shimmer.dart';
import 'package:booking_system_flutter/utils/constant.dart';
import 'package:booking_system_flutter/utils/model_keys.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../component/base_scaffold_widget.dart';
import '../../component/empty_error_state_widget.dart';

class RatingViewAllScreen extends StatefulWidget {
  final List<RatingData>? ratingData;
  final int? serviceId;
  final int? handymanId;

  RatingViewAllScreen({this.ratingData, this.serviceId, this.handymanId});

  @override
  State<RatingViewAllScreen> createState() => _RatingViewAllScreenState();
}

class _RatingViewAllScreenState extends State<RatingViewAllScreen> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBarTitle: language.review,
      child: SnapHelperWidget<List<RatingData>>(
        future: widget.serviceId != null ? serviceReviews({CommonKeys.serviceId: widget.serviceId}) : handymanReviews({CommonKeys.handymanId: widget.handymanId}),
        loadingWidget: ReviewShimmer(),
        onSuccess: (data) {
          return AnimatedListView(
            slideConfiguration: sliderConfigurationGlobal,
            shrinkWrap: true,
            listAnimationType: ListAnimationType.FadeIn,
            fadeInConfiguration: FadeInConfiguration(duration: 2.seconds),
            padding: const EdgeInsets.all(16),
            itemCount: data.length,
            physics: const AlwaysScrollableScrollPhysics(),
            itemBuilder: (context, index) => ReviewWidget(data: data[index], isCustomer: widget.serviceId == null),
            emptyWidget: NoDataWidget(
              title: language.lblNoServiceRatings,
              imageWidget: const EmptyStateWidget(),
            ),
            onSwipeRefresh: () async {
              setState(() {});

              return await 2.seconds.delay;
            },
          );
        },
        errorBuilder: (error) {
          return NoDataWidget(
            title: error,
            imageWidget: const ErrorStateWidget(),
            retryText: language.reload,
            onRetry: () {
              appStore.setLoading(true);

              setState(() {});
            },
          );
        },
      ),
    );
  }
}
