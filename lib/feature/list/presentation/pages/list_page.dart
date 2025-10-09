import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_notes/core/app_colors/app_colors.dart';
import 'package:todo_notes/feature/home/presentation/widgets/list_widget.dart';

import '../../../home/presentation/bloc/home_bloc.dart';

class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          final group = context.read<HomeBloc>().groupedByType.keys.toList();

          return SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                ListView.separated(
                  itemBuilder: (_, index) {
                    final type = group[index]; // masalan "week"
                    final tasks = context.read<HomeBloc>().groupedByType[type]!;
                    return ListsWidget(
                      name: type,
                      countTasks: tasks.length,
                      color: context
                          .read<HomeBloc>()
                          .groupedByType
                          .values
                          .first
                          .first
                          .listModel
                          ?.color,
                    );
                  },
                  separatorBuilder: (_, index) {
                    return SizedBox(height: 10);
                  },
                  itemCount: group.length,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
