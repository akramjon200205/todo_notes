import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_notes/feature/home/presentation/bloc/home_bloc.dart';
import 'package:todo_notes/feature/home/presentation/widgets/tasks_widget.dart';

class TasksBuilderWidget extends StatefulWidget {
  const TasksBuilderWidget({super.key});

  @override
  State<TasksBuilderWidget> createState() => _TasksBuilderWidgetState();
}

class _TasksBuilderWidgetState extends State<TasksBuilderWidget> {
  String formatDate(DateTime date) {
    String year = date.year.toString();
    String month = date.month.toString().padLeft(2, '0');
    String day = date.day.toString().padLeft(2, '0');
    String hour = date.hour.toString().padLeft(2, '0');
    String minute = date.minute.toString().padLeft(2, '0');
    return '$year-$month-$day, $hour:$minute';
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        final contextState = context.read<HomeBloc>();

        return ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: contextState.taskList.length,
          itemBuilder: (context, index) {
            final task = contextState.taskList[index];

            return Slidable(
              key: ValueKey(task.id),
              endActionPane: ActionPane(
                motion: const DrawerMotion(),
                extentRatio: 0.25,
                children: [
                  SlidableAction(
                    onPressed: (context) async {
                      final confirm = await showDialog<bool>(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: const Text("Confirmation"),
                          content: Text(
                            "Do you want to delete this task named ${task.textTask}?",
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(ctx, false),
                              child: const Text("Cancel"),
                            ),
                            ElevatedButton(
                              onPressed: () => Navigator.pop(ctx, true),
                              child: const Text("Delete"),
                            ),
                          ],
                        ),
                      );

                      if (confirm == true) {
                        contextState.add(HomeDeleteTaskEvent(index));                     
                        contextState.add(HomeGetAllTasksEvent());
                      }
                    },
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    icon: Icons.delete,
                    label: 'Delete',
                  ),
                ],
              ),

              child: TaskItemTile(
                isChecked: task.isCompleted,
                onTap: () {
                  contextState.add(
                    OnTaskIsCheckedEvent(index, !(task.isCompleted)),
                  );
                },
                title: task.textTask ?? '',
                indicatorColor: task.listModel.target?.color ?? Colors.white,
                time: formatDate(task.time ?? DateTime.now()),
              ),
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
}
