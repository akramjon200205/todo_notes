import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_notes/feature/home/presentation/bloc/home_bloc.dart';
import 'package:todo_notes/feature/list/presentation/bloc/list_bloc.dart';
import '../../../home/presentation/widgets/list_widget.dart';

class ListPicked extends StatelessWidget {
  const ListPicked({super.key});

  @override
  Widget build(BuildContext context) {
    final listBloc = context.watch<ListBloc>();
    final homeBloc = context.read<HomeBloc>();
    final lists = listBloc.listModels;

    if (lists.isEmpty) {
      return const Center(child: Text('No lists available'));
    }
    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 10),
      itemCount: lists.length,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (context, index) {
        final list = lists[index];
        final taskCount = homeBloc.taskList
            .where((t) => t.listModel.key == list.key)
            .length;

        return InkWell(
          onTap: () {
            homeBloc.add(OnChangeListEvent(list));
            homeBloc.add(HomeGetAllTasksEvent());
            Navigator.pop(context);
          },
          child: ListsWidget(
            name: list.name,
            countTasks: taskCount,
            color: list.color,
          ),
        );
      },
    );
  }
}
