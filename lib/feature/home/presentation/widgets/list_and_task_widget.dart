import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:todo_notes/core/app_colors/app_colors.dart';
import 'package:todo_notes/core/app_text_styles/app_text_styles.dart';
import 'package:todo_notes/core/assets/assets.dart';
import 'package:todo_notes/core/route/routes.dart';

// ignore: must_be_immutable
class ListAndTaskWidget extends StatelessWidget {
  ListAndTaskWidget({required this.position, required this.onTap, super.key});
  Animation<Offset> position;
  Function onTap;
  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: position,
      child: Container(
        width: 220,
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: AppColors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 30,
              // ignore: use_full_hex_values_for_flutter_colors
              color: Color(0xFF131C2933).withValues(alpha: 0.2),
              offset: Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          children: [
            FloatingAnimationWidget(
              function: () {
                onTap();
                Navigator.pushNamed(context, AppRoutes.tasks);
              },
              text: "Task",
              icon: Assets.icons.checkIcon,
            ),
            SizedBox(height: 18),
            FloatingAnimationWidget(
              text: "List",
              function: () {
                onTap();
                Navigator.pushNamed(context, AppRoutes.lists);
              },
              icon: Assets.icons.iconList,
            ),
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class FloatingAnimationWidget extends StatelessWidget {
  Function()? function;
  String text;
  String icon;
  FloatingAnimationWidget({
    required this.icon,
    this.function,
    required this.text,
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: function,
      child: Row(
        children: [
          Image.asset(icon, height: 22),
          SizedBox(width: 13),
          Text(
            text,
            style: AppTextStyles.taskText.copyWith(
              color: AppColors.blue,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
