import 'package:booking_system_flutter/main.dart';
import 'package:booking_system_flutter/model/chat_message_model.dart';
import 'package:booking_system_flutter/utils/common.dart';
import 'package:booking_system_flutter/utils/constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class LastMessageChat extends StatelessWidget {
  final stream;

  LastMessageChat({
    required this.stream,
  });

  Widget typeWidget(ChatMessageModel message) {
    String? type = message.messageType;
    switch (type) {
      case TEXT:
        return Text(
          "${message.message.validate()}",
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: secondaryTextStyle(size: 14),
        );
      case IMAGE:
        return Row(
          children: [
            const Icon(Icons.photo_sharp, size: 16),
            6.width,
            Text(language.lblImage, style: secondaryTextStyle(size: 16)),
          ],
        );
      case VIDEO:
        return Row(
          children: [
            const Icon(Icons.videocam_outlined, size: 16),
            6.width,
            Text(language.lblVideo, style: secondaryTextStyle(size: 16)),
          ],
        );
      case AUDIO:
        return Row(
          children: [
            const Icon(Icons.audiotrack, size: 16),
            6.width,
            Text(language.lblAudio, style: secondaryTextStyle(size: 16)),
          ],
        );
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: stream,
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {
          var docList = snapshot.data!.docs;

          if (docList.isNotEmpty) {
            ChatMessageModel message = ChatMessageModel.fromJson(docList.last.data() as Map<String, dynamic>);
            String time = '';
            DateTime date = DateTime.fromMicrosecondsSinceEpoch(message.createdAt! * 1000);
            if (date.day == DateTime.now().day) {
              time = formatDate(message.createdAt.validate().toString(), format: HOUR_12_FORMAT, isFromMicrosecondsSinceEpoch: true);
            } else {
              time = formatDate(message.createdAt.validate().toString(), format: DATE_FORMAT_1, isFromMicrosecondsSinceEpoch: true);
            }
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                typeWidget(message).expand(),
                16.width,
                Text(time, style: secondaryTextStyle(size: 10)),
              ],
            ).paddingTop(2);
          }
          return const Offstage();
        }
        return const Offstage();
      },
    );
  }
}
