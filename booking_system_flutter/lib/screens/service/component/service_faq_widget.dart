import 'package:booking_system_flutter/model/service_detail_response.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class ServiceFaqWidget extends StatelessWidget {
  const ServiceFaqWidget({Key? key, required this.serviceFaq}) : super(key: key);

  final ServiceFaq serviceFaq;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(serviceFaq.title.validate(), style: primaryTextStyle()),
      tilePadding: const EdgeInsets.symmetric(horizontal: 0),
      children: [
        ListTile(
          title: Text(serviceFaq.description.validate(), style: secondaryTextStyle()),
          contentPadding: const EdgeInsets.only(bottom: 16),
        ),
      ],
    );
  }
}
