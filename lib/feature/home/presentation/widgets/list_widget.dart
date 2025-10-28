import 'package:flutter/material.dart';
import 'package:todo_notes/core/app_colors/app_colors.dart';
import 'package:todo_notes/core/app_text_styles/app_text_styles.dart';

// ignore: must_be_immutable
class ListsWidget extends StatelessWidget {
  
  ListsWidget({
    required this.name,
    required this.countTasks,
    required this.color,
    super.key,
  });

  Color color;
  String name;
  int countTasks;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: color,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: AppTextStyles.listsNameText.copyWith(
              color:
                  color == Colors.white ||
                      color == Colors.amber ||
                      color == Colors.cyan
                  ? AppColors.black
                  : AppColors.white,
            ),
          ),
          SizedBox(height: 4),
          Text(
            countTasks == 0 || countTasks < 0
                ? "Empty list"
                : countTasks > 1
                ? "$countTasks tasks"
                : "$countTasks task",
            style: AppTextStyles.listsSubText.copyWith(color:
              color == Colors.white ||
                      color == Colors.amber ||
                      color == Colors.cyan
                  ? AppColors.black
                  : AppColors.white,
            ),
          ),
        ],
      ),
    );
  }
}
