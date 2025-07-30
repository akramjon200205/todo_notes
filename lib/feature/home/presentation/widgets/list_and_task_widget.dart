import 'package:flutter/material.dart';
import 'package:todo_notes/core/app_colors/app_colors.dart';
import 'package:todo_notes/core/assets/assets.dart';

class ListAndTaskWidget extends StatelessWidget {
  ListAndTaskWidget({required this.position, super.key});
  Animation<Offset> position;

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
            Row(
              children: [
                Image.asset(Assets.icons.checkIcon, height: 22),
                SizedBox(width: 13),
                Text("Task"),
              ],
            ),
            SizedBox(height: 18),
            Row(
              children: [
                Image.asset(Assets.icons.iconList, height: 22),
                SizedBox(width: 13),
                Text("List"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
