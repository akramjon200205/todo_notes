import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_notes/feature/home/presentation/bloc/home_bloc.dart';

import '../../../home/presentation/widgets/list_widget.dart';

class ListPicked extends StatefulWidget {
  const ListPicked({super.key});

  @override
  State<ListPicked> createState() => _ListPickedState();
}

class _ListPickedState extends State<ListPicked> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is HomeGetAllTasks) {
          final grouped = state.groupedByType;

          final typeKeys = grouped.keys.toList();
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ListView.separated(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final type = typeKeys[index]; // masalan "week"
                  final tasks = grouped[type]!;
                  return ListsWidget(name: type, countTasks: tasks.length);
                },
                separatorBuilder: (_, index) {
                  return SizedBox(height: 10);
                },
                itemCount: typeKeys.length,
              ),
            ],
          );
        }
        return SizedBox.shrink();
      },
    );
  }
}
