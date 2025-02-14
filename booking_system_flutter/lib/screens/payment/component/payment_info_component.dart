import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../component/empty_error_state_widget.dart';
import '../../../component/price_widget.dart';
import '../../../main.dart';
import '../../../model/payment_list_reasponse.dart';
import '../../../network/rest_apis.dart';
import '../../../utils/common.dart';
import '../../../utils/constant.dart';

class PaymentInfoComponent extends StatefulWidget {
  final int bookingId;

  PaymentInfoComponent(this.bookingId);

  @override
  State<PaymentInfoComponent> createState() => _PaymentInfoComponentState();
}

class _PaymentInfoComponentState extends State<PaymentInfoComponent> {
  List<PaymentData> list = [];
  Future<List<PaymentData>>? future;
  int page = 1;
  bool isLastPage = false;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    future = getPaymentList(page, widget.bookingId, list, (p0) {
      isLastPage = p0;
      setState(() {});
    });
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.height() * 0.7,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(language.paymentHistory, style: boldTextStyle()).paddingAll(16),
            SnapHelperWidget<List<PaymentData>>(
              future: future,
              onSuccess: (data) {
                return AnimatedListView(
                  itemCount: list.length,
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(8),
                  physics: const NeverScrollableScrollPhysics(),
                  emptyWidget: NoDataWidget(title: language.noDataAvailable, imageWidget: const EmptyStateWidget()),
                  listAnimationType: ListAnimationType.Scale,
                  itemBuilder: (p0, index) {
                    PaymentData data = list[index];

                    return Container(
                      decoration: boxDecorationDefault(color: context.scaffoldBackgroundColor),
                      padding: const EdgeInsets.all(16),
                      margin: const EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Marquee(child: Text('${language.transactionId} ${data.txnId.validate()}', style: primaryTextStyle())),
                          8.height,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  PriceWidget(price: data.totalAmount.validate()),
                                  8.width,
                                  Text('(${data.paymentMethod.validate().capitalizeFirstLetter()})', style: primaryTextStyle()).expand(),
                                ],
                              ).expand(),
                              8.width,
                              Text(formatDate(data.date.validate().toString(), format: DATE_FORMAT_8), style: secondaryTextStyle()),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
