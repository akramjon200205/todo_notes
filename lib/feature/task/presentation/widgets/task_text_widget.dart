import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_notes/core/app_colors/app_colors.dart';
import 'package:todo_notes/core/app_text_styles/app_text_styles.dart';
import 'package:todo_notes/feature/home/presentation/bloc/home_bloc.dart';

// ignore: must_be_immutable
class TaskTextWidget extends StatefulWidget {
  TaskTextWidget({required this.controller, super.key});
  TextEditingController controller;
  @override
  State<TaskTextWidget> createState() => _TaskTextWidgetState();
}

class _TaskTextWidgetState extends State<TaskTextWidget> {
  String formatDate(DateTime date) {
    String year = date.year.toString();
    String month = date.month.toString().padLeft(2, '0');
    String day = date.day.toString().padLeft(2, '0');
    return '$year-$month-$day';
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
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
                    controller: widget.controller,
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
                      context.read<HomeBloc>().tempDate == null
                          ? SizedBox.shrink()
                          : TaskTImeWidget(
                              icon: Icon(
                                Icons.calendar_today_outlined,
                                size: 12,
                                color: AppColors.black,
                              ),
                              text: formatDate(
                                context.read<HomeBloc>().tempDate ??
                                    DateTime.now(),
                              ),
                            ),
                      SizedBox(width: 20),
                      context.read<HomeBloc>().tempTime?.hour == null
                          ? SizedBox.shrink()
                          : TaskTImeWidget(
                              icon: Icon(
                                CupertinoIcons.time,
                                size: 12,
                                color: AppColors.black,
                              ),
                              text:
                                  "${context.read<HomeBloc>().tempTime?.hour} : ${context.read<HomeBloc>().tempTime?.minute}",
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
                color:
                    context.read<HomeBloc>().listModels?.color ?? Colors.white,
              ),
            ),
          ],
        );
      },
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
