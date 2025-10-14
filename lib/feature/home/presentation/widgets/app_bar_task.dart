import 'package:flutter/material.dart';
import 'package:todo_notes/core/app_colors/app_colors.dart';
import 'package:todo_notes/core/app_text_styles/app_text_styles.dart';

class AppBarTask extends StatelessWidget {
  const AppBarTask({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text("Today", style: AppTextStyles.homeText),
      trailing: InkWell(
        onTap: () {},
        child: Icon(Icons.more_horiz, size: 24, color: AppColors.blue),
      ),
      leading: const SizedBox(width: 28, height: 28),
    );
  }
}
