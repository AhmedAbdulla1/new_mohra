import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class WaitingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator.adaptive(),
    );
  }
}

class TextWaitingWidget extends StatelessWidget {
  final String text;
  final Duration? pause;
  final Color textColor;

  const TextWaitingWidget(this.text,
      {Key? key, this.pause, this.textColor = Colors.black})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text(
      text,
      style: TextStyle(
        color: textColor,
        fontWeight: FontWeight.bold,
        fontSize: 50.sp,
      ),
    ));
  }
}
