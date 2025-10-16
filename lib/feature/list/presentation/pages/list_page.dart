import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_notes/core/app_colors/app_colors.dart';
import 'package:todo_notes/core/app_text_styles/app_text_styles.dart';
import 'package:todo_notes/core/route/routes.dart';
import 'package:todo_notes/feature/home/presentation/widgets/list_widget.dart';
import 'package:todo_notes/feature/list/presentation/bloc/list_bloc.dart';

class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  @override
  void initState() {
    super.initState();
    // context.read<ListBloc>().add(GetListEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: Text(
          "Lists",
          style: AppTextStyles.homeText.copyWith(fontSize: 30),
        ),
        centerTitle: true,
        leading: InkWell(
          borderRadius: BorderRadius.circular(30),
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(CupertinoIcons.back, size: 22),
        ),
      ),
      backgroundColor: AppColors.white,
      body: BlocBuilder<ListBloc, ListState>(
        builder: (context, state) {
          if (state is ListLoading) {
            return CircularProgressIndicator();
          }
          if (state is ListError) {
            return Center(child: Text(state.message));
          }
          if (state is GetListState) {
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (_, index) {
                      return ListsWidget(
                        name: state.listModel[index].name ?? '',
                        countTasks: index,
                        color: state.listModel[index].color,
                      );
                    },
                    separatorBuilder: (_, index) {
                      return SizedBox(height: 10);
                    },
                    itemCount: state.listModel.length,
                  ),
                ],
              ),
            );
          }
          return SizedBox.shrink();
        },
      ),
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        backgroundColor: AppColors.white,
        onPressed: () {
          Navigator.pushNamed(context, AppRoutes.addList);
        },
        child: Icon(Icons.add, color: AppColors.blue),
      ),
    );
  }
}
