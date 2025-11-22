import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_notes/feature/home/data/models/task_model.dart';
import 'package:todo_notes/feature/home/presentation/bloc/home_bloc.dart';
import 'package:todo_notes/feature/home/presentation/widgets/tasks_widget.dart';
import 'package:todo_notes/feature/list/data/models/list_model.dart';

// ignore: must_be_immutable
class SlidableWidget extends StatefulWidget {
  SlidableWidget({
    required this.index,
    required this.listModels,
    required this.task,
    super.key,
  });
  TaskModel task;
  int index;
  List<ListModel> listModels;
  @override
  State<SlidableWidget> createState() => _SlidableWidgetState();
}

class _SlidableWidgetState extends State<SlidableWidget> {
  @override
  Widget build(BuildContext context) {
    final contextBLoc = context.read<HomeBloc>();
    return Slidable(
      key: ValueKey(widget.task.key),
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
                    "Do you want to delete this task named ${widget.task.text}?",
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
                contextBLoc.add(
                  HomeDeleteTaskEvent(
                    index: widget.index,
                    key: widget.task.key ?? '',
                    listModels: widget.listModels,
                  ),
                );
              }
              setState(() {});
            },
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),

      child: TaskItemTile(
        isChecked: widget.task.isCompleted,
        onTap: () {
          contextBLoc.add(
            OnTaskIsCheckedEvent(
              index: widget.index,
              isChecked: !(widget.task.isCompleted),
              key: widget.task.key ?? '',
            ),
          );
        },
        title: widget.task.text,
        indicatorColor: widget.task.listModel.color,
        time: formatDate(widget.task.time ?? DateTime.now()),
      ),
    );
  }

  String formatDate(DateTime date) {
    String year = date.year.toString();
    String month = date.month.toString().padLeft(2, '0');
    String day = date.day.toString().padLeft(2, '0');
    String hour = date.hour.toString().padLeft(2, '0');
    String minute = date.minute.toString().padLeft(2, '0');
    return '$year-$month-$day, $hour:$minute';
  }
}
