import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_notes/core/app_colors/app_colors.dart';
import 'package:todo_notes/core/app_colors/app_text_styles.dart';
import 'package:todo_notes/feature/home/data/models/task_model.dart';
import 'package:todo_notes/feature/home/presentation/bloc/home_bloc.dart';
import 'package:todo_notes/feature/home/presentation/widgets/tasks_widget.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
    return Scaffold(
      backgroundColor: AppColors.white,
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state == HomeLoading()) {
            return CircularProgressIndicator();
          }
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                ListTile(
                  title: Text("Today", style: AppTextStyles.homeText),
                  trailing: Icon(
                    Icons.more_horiz,
                    size: 24,
                    color: AppColors.blue,
                  ),
                  leading: SizedBox(width: 28, height: 28),
                ),
                SizedBox(height: 20),
                ListView.builder(
                  itemCount: tasks.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return TasksWidget(
                      textTask: tasks[index].textTask ?? '',
                      colorTaskList: AppColors.red,
                      isChecked: tasks[index].isChecked ?? false,
                      onTap: () {
                        setState(() {
                          tasks[index].isChecked =
                              !(tasks[index].isChecked ?? false);
                        });
                      },
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
