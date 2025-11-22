import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_notes/core/app_colors/app_colors.dart';
import 'package:todo_notes/core/app_text_styles/app_text_styles.dart';
import 'package:todo_notes/feature/home/presentation/bloc/home_bloc.dart';
import 'package:todo_notes/feature/home/presentation/widgets/slidable_widget.dart';
import 'package:todo_notes/feature/list/presentation/bloc/list_bloc.dart';

class TasksBuilderWidget extends StatefulWidget {
  const TasksBuilderWidget({super.key});

  @override
  State<TasksBuilderWidget> createState() => _TasksBuilderWidgetState();
}

class _TasksBuilderWidgetState extends State<TasksBuilderWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        final home = context.read<HomeBloc>();
        final listBloc = context.read<ListBloc>();
        final tasks = home.taskList;
        final printedHeaders = <String>{};

        return ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: tasks.length,
          itemBuilder: (context, index) {
            final task = tasks[index];
            final dateLabel = getDateLabel(task.time!);
            bool showHeader = false;
            if (!printedHeaders.contains(dateLabel)) {
              showHeader = true;
              printedHeaders.add(dateLabel);
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (showHeader)
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 20,
                      bottom: 6,
                      top: 12,
                    ),
                    child: Text(
                      dateLabel,
                      style: AppTextStyles.taskText.copyWith(
                        color: AppColors.grey,
                      ),
                    ),
                  ),
                SlidableWidget(
                  index: index,
                  listModels: listBloc.listModels,
                  task: task,
                ),
              ],
            );
          },
          separatorBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Divider(
                height: 1,
                color: Colors.grey.shade300,
                indent: 30,
              ),
            );
          },
        );
      },
    );
  }

  String getDateLabel(DateTime date) {
    final today = DateTime.now();
    final yesterday = today.subtract(const Duration(days: 1));
    final tomorrow = today.add(const Duration(days: 1));

    bool isSameDay(DateTime a, DateTime b) =>
        a.year == b.year && a.month == b.month && a.day == b.day;

    if (isSameDay(date, today)) return "Today";
    if (isSameDay(date, yesterday)) return "Yesterday";
    if (isSameDay(date, tomorrow)) return "Tomorrow";

    if (date.isBefore(yesterday)) return "Past days";
    return "Future days";
  }
}
