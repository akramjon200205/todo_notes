import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_notes/core/app_text_styles/app_text_styles.dart';
import 'package:todo_notes/feature/home/presentation/bloc/home_bloc.dart';
import 'package:todo_notes/feature/home/presentation/widgets/list_widget.dart';
import 'package:todo_notes/feature/list/presentation/bloc/list_bloc.dart';

class ListsBuilderWidget extends StatefulWidget {
  const ListsBuilderWidget({super.key});

  @override
  State<ListsBuilderWidget> createState() => _ListsWidgetState();
}

class _ListsWidgetState extends State<ListsBuilderWidget> {
  @override
  Widget build(BuildContext context) {
    final homeBloc = context.read<HomeBloc>();

    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        final lists = context.read<ListBloc>().listModels;
        final listTasks = homeBloc.listTasks;

        return Padding(
          padding: const EdgeInsets.only(left: 50, right: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Text("Lists", style: AppTextStyles.listText),
              ),
              ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: lists.length,
                itemBuilder: (context, index) {
                  final list = lists[index];
                  final countTasks = listTasks[list.key ?? '']?.length ?? 0;

                  return ListsWidget(
                    name: list.name,
                    countTasks: countTasks,
                    color: list.color,
                  );
                },
                separatorBuilder: (_, __) => const SizedBox(height: 10),
              ),
            ],
          ),
        );
      },
    );
  }
}
