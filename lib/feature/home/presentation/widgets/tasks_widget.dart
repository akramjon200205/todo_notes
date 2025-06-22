import 'package:flutter/material.dart';
import 'package:todo_notes/core/app_colors/app_colors.dart';
import 'package:todo_notes/core/app_colors/app_text_styles.dart';
import 'package:todo_notes/feature/home/presentation/widgets/rounded_check_box.dart';

// ignore: must_be_immutable
class TasksWidget extends StatelessWidget {
  bool isChecked;
  Function() onTap;
  Color colorTaskList;
  String textTask;
  TasksWidget({
    required this.textTask,
    required this.isChecked,
    required this.onTap,
    required this.colorTaskList,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: RoundCheckbox(isChecked: isChecked, onTap: onTap),
      title: Text(textTask, style: AppTextStyles.taskText),
      trailing: Container(
        width: 12,
        height: 12,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: colorTaskList,
          border: Border.all(color: AppColors.grey, width: 0.1),
        ),
      ),
    );
  }
}
