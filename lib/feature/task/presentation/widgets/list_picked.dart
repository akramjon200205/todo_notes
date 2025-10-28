import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_notes/feature/home/presentation/bloc/home_bloc.dart';
import 'package:todo_notes/feature/list/presentation/bloc/list_bloc.dart';

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
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ListView.separated(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    context.read<HomeBloc>().add(
                      OnChangeListEvent(
                        context.read<ListBloc>().listModels[index],
                      ),
                    );
                    context.read<HomeBloc>().add(HomeGetAllTasksEvent());
                    Navigator.pop(context);
                  },
                  child: ListsWidget(
                    name: context.read<ListBloc>().listModels[index].name ?? '',
                    countTasks: context.read<ListBloc>().listModels.length,
                    color: context.read<ListBloc>().listModels[index].color,
                  ),
                );
              },
              separatorBuilder: (_, index) {
                return SizedBox(height: 10);
              },
              itemCount: context.read<ListBloc>().listModels.length,
            ),
          ],
        );
      },
    );
  }
}
