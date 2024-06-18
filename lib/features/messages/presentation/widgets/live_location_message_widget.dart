import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:starter_application/features/messages/domain/entity/messaging_entity.dart';

import '../../../event/presentation/widget/event_info_widget.dart';

class LiveLocationMessageWidget extends StatelessWidget {
  final MessagingLiveLocationMessageEntity messagingLiveLocationEntity;

  const LiveLocationMessageWidget(
      {Key? key, required this.messagingLiveLocationEntity})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        constraints: BoxConstraints(maxWidth: 0.9.sw, maxHeight: 0.9.sw),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                    target: LatLng(messagingLiveLocationEntity.lat,
                        messagingLiveLocationEntity.lng),
                    zoom: 15),
                scrollGesturesEnabled: false,
                rotateGesturesEnabled: false,
                tiltGesturesEnabled: false,
                zoomGesturesEnabled: false,
                mapToolbarEnabled: false,
                zoomControlsEnabled: false,
                markers: [
                  Marker(
                      markerId: const MarkerId('1'),
                      position: LatLng(messagingLiveLocationEntity.lat,
                          messagingLiveLocationEntity.lng))
                ].toSet(),
                onTap: (argument) {
                  openMap(messagingLiveLocationEntity.lat,
                      messagingLiveLocationEntity.lng);
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ), /*
            Text(messagingLocationEntity.info)*/
          ],
        ));
  }
}
