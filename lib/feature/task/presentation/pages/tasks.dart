import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_notes/feature/home/data/models/task_model.dart';
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
  TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        final context0 = context.read<HomeBloc>();
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
                              controller.clear();
                              context.read<HomeBloc>().tempDate = null;
                              context.read<HomeBloc>().tempTime = null;
                              context.read<HomeBloc>().listModels = null;

                              Navigator.pop(context);
                            },
                          ),
                          CancelDoneWidget(
                            text: "Done",
                            function: () {
                              DateTime combinedDateTime = DateTime(
                                context0.tempDate?.year ?? DateTime.now().year,
                                context0.tempDate?.month ??
                                    DateTime.now().month,
                                context0.tempDate?.day ?? DateTime.now().day,
                                context0.tempTime?.hour ?? DateTime.now().hour,
                                context0.tempTime?.minute ??
                                    DateTime.now().minute,
                              );
                              if (context0.listModels != null &&
                                  controller.text.isNotEmpty &&
                                  context0.tempDate != null) {
                                context0.add(
                                  HomeAddTaskEvent(
                                    TaskModel(
                                      isCompleted: false,
                                      textTask: controller.text,
                                      time: combinedDateTime,
                                    ),
                                    context0.listModels,
                                  ),
                                );

                                context0.add(HomeGetAllTasksEvent());
                                context.read<HomeBloc>().tempDate = null;
                                context.read<HomeBloc>().tempTime = null;
                                context.read<HomeBloc>().listModels = null;

                                Navigator.pop(context);
                              }
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      TaskTextWidget(controller: controller),
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
