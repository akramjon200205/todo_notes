import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_notes/core/app_colors/app_colors.dart';
import 'package:todo_notes/core/app_text_styles/app_text_styles.dart';

class TaskTextWidget extends StatefulWidget {
  const TaskTextWidget({super.key});

  @override
  State<TaskTextWidget> createState() => _TaskTextWidgetState();
}

class _TaskTextWidgetState extends State<TaskTextWidget> {
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            SizedBox(height: 10),
            Icon(
              Icons.circle_outlined,
              size: 28,
              color: AppColors.black.withValues(alpha: 0.2),
            ),
          ],
        ),
        SizedBox(width: 15),
        Expanded(
          child: Column(
            children: [
              TextField(
                showCursor: true,
                controller: controller,
                style: AppTextStyles.taskText,
                maxLines: null, // cheksiz qatorga yozish imkoniyati
                minLines: 1,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "What do you want to do?",
                  hintStyle: AppTextStyles.tasksText,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TaskTImeWidget(
                    icon: Icon(
                      Icons.calendar_today_outlined,
                      size: 12,
                      color: AppColors.black,
                    ),
                    text: "Today",
                  ),
                  SizedBox(width: 20),
                  TaskTImeWidget(
                    icon: Icon(
                      CupertinoIcons.time,
                      size: 12,
                      color: AppColors.black,
                    ),
                    text: "10:41 am",
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 18),
          width: 15,
          height: 15,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.purple,
          ),
        ),
      ],
    );
  }
}

// ignore: must_be_immutable
class TaskTImeWidget extends StatelessWidget {
  Icon icon;
  String text;
  TaskTImeWidget({required this.icon, required this.text, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        icon,
        SizedBox(width: 10),
        Text(text, style: AppTextStyles.tasksText),
      ],
    );
  }
}
