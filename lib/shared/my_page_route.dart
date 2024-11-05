import 'package:flutter/material.dart';

class MyPageRoute extends PageRouteBuilder {
  final Widget page;
  final Offset offset;

  MyPageRoute({required this.page, this.offset = const Offset(0.0, 1.0)})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) {
            const end = Offset.zero;
            const curve = Curves.fastOutSlowIn;

            var tween = Tween(begin: offset, end: end).chain(CurveTween(curve: curve));
            var offsetAnimation = animation.drive(tween);

            return SlideTransition(
              position: offsetAnimation,
              child: page,
            );
          },
          transitionDuration: const Duration(milliseconds: 300),
        );
}
