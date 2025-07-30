import 'package:flutter/material.dart';
import 'package:todo_notes/core/app_colors/app_colors.dart';
import 'package:todo_notes/feature/home/data/models/task_model.dart';
import 'package:todo_notes/feature/home/presentation/widgets/tasks_widget.dart';

class TasksBuilderWidget extends StatefulWidget {
  const TasksBuilderWidget({super.key});

  @override
  State<TasksBuilderWidget> createState() => _TasksBuilderWidgetState();
}

class _TasksBuilderWidgetState extends State<TasksBuilderWidget> {
  List<TaskModel> tasks = [
    TaskModel(
      isChecked: false,
      textTask: 'Uy ishlarini bajarish',
      time: DateTime.now(),
    ),
    TaskModel(
      isChecked: false,
      textTask: 'Flutter loyihasini tugatish',
      time: DateTime.now(),
    ),
    TaskModel(isChecked: false, textTask: 'Kitob o‘qish', time: DateTime.now()),
  ];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      itemCount: tasks.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return TaskItemTile(
          isChecked: tasks[index].isChecked ?? false,
          onTap: () {
            setState(() {
              tasks[index].isChecked = !(tasks[index].isChecked ?? false);
            });
          },
          title: tasks[index].textTask ?? '',
          indicatorColor: AppColors.blue,
        );
      },
    );
  }
}
