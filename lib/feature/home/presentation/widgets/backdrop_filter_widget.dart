import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:todo_notes/core/app_colors/app_colors.dart';

// ignore: must_be_immutable
class BackdropFilterWidget extends StatelessWidget {
  BackdropFilterWidget({required this.fadeAnimation, super.key});
  Animation<double> fadeAnimation;

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: fadeAnimation,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
        child: Container(
          // ignore: deprecated_member_use
          color: AppColors.black.withOpacity(0.25),
        ),
      ),
    );
  }
}

