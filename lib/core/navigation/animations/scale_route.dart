import 'package:flutter/material.dart';

class ScaleRoute extends PageRouteBuilder {
  final Widget page;

  ScaleRoute({required this.page})
      : super(pageBuilder: (BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return page;
  }, transitionsBuilder: (BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child) {
    return new ScaleTransition(
      scale: new Tween<double>(
        begin: 0.0,
        end: 1.0,
      ).animate(
        CurvedAnimation(
          parent: animation,
          curve: const Interval(
            0.00,
            0.50,
            curve: Curves.linear,
          ),
        ),
      ),
      child: ScaleTransition(
        scale: Tween<double>(
          begin: 1.5,
          end: 1.0,
        ).animate(
          CurvedAnimation(
            parent: animation,
            curve: const Interval(
              0.50,
              1.00,
              curve: Curves.linear,
            ),
          ),
        ),
        child: child,
      ),
    );
  });
}
