import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_notes/feature/home/presentation/bloc/home_bloc.dart';
import 'package:todo_notes/feature/task/presentation/widgets/bottom_bar.dart';
import 'package:todo_notes/feature/task/presentation/widgets/cancel_done_widget.dart';
import 'package:todo_notes/feature/task/presentation/widgets/task_text_widget.dart';

class Tasks extends StatefulWidget {
  const Tasks({super.key});

  @override
  State<Tasks> createState() => _TasksState();
}

class _TasksState extends State<Tasks> {
  TimeOfDay selectedTime = const TimeOfDay(hour: 14, minute: 30);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CancelDoneWidget(
                            text: "Cancel",
                            function: () {
                              Navigator.pop(context);
                            },
                          ),
                          CancelDoneWidget(
                            text: "Done",
                            function: () {
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      TaskTextWidget(),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: BottomBarLists(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
