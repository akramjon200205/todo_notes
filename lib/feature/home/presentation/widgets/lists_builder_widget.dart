import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_notes/core/app_text_styles/app_text_styles.dart';
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
    return BlocBuilder<ListBloc, ListState>(
      builder: (context, state) {
        final contextBloc = context.read<ListBloc>().listModels;
        return Padding(
          padding: EdgeInsets.only(left: 50, right: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsetsGeometry.symmetric(vertical: 10),
                child: Text("Lists", style: AppTextStyles.listText),
              ),
              ListView.separated(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final list = contextBloc[index];

                  return ListsWidget(
                    name: list.name,
                    countTasks: index,
                    color: list.color,
                  );
                },
                separatorBuilder: (context, index) {
                  return SizedBox(height: 10);
                },
                itemCount: contextBloc.length,
              ),
            ],
          ),
        );
      },
    );
  }
}
