import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_notes/core/app_colors/app_colors.dart';
import 'package:todo_notes/core/app_text_styles/app_text_styles.dart';
import 'package:todo_notes/core/route/routes.dart';
import 'package:todo_notes/feature/home/presentation/widgets/list_widget.dart';
import 'package:todo_notes/feature/list/data/models/list_model.dart';
import 'package:todo_notes/feature/list/presentation/bloc/list_bloc.dart';
import 'package:todo_notes/feature/list/presentation/pages/bottom_sheet_list.dart';

class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  late final ListBloc listBloc;

  @override
  void initState() {
    super.initState();
    listBloc = context.read<ListBloc>();
    listBloc.add(GetListEvent());
  }

  Future<void> _showDeleteDialog(int index, ListModel list) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Confirmation"),
        content: Text("Do you want to delete the list named \"${list.name}\"?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text("Delete"),
          ),
        ],
      ),
    );

    if (confirm == true) {
      listBloc.add(DeleteListEvent(index, list.key ?? ''));
    }
  }

  void _showBottomSheet(int index, String name, Color color) {
    showCupertinoModalPopup(
      context: context,
      builder: (_) => BottomSheetList(color: color, name: name, index: index),
    );
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
          onTap: () => Navigator.pushReplacementNamed(context, AppRoutes.home),
          child: const Icon(CupertinoIcons.back, size: 22),
        ),
      ),
      backgroundColor: AppColors.white,
      body: BlocBuilder<ListBloc, ListState>(
        builder: (context, state) {
          if (state is ListLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is ListError) {
            return Center(child: Text(state.message));
          }
          if (state is GetListState) {
            final lists = state.listModel;
            if (lists.isEmpty) {
              return const Center(child: Text("No lists available"));
            }

            return ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              physics: const BouncingScrollPhysics(),
              itemCount: lists.length,
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemBuilder: (_, index) {
                final listItem = lists[index];
                return InkWell(
                  onTap: () =>
                      _showBottomSheet(index, listItem.name, listItem.color),
                  child: Slidable(
                    key: ValueKey(listItem),
                    endActionPane: ActionPane(
                      motion: const DrawerMotion(),
                      children: [
                        SlidableAction(
                          onPressed: (_) => _showDeleteDialog(index, listItem),
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          icon: Icons.delete,
                          label: 'Delete',
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ],
                    ),
                    child: ListsWidget(
                      name: listItem.name,
                      countTasks: index,
                      color: listItem.color,
                    ),
                  ),
                );
              },
            );
          }
          return const SizedBox.shrink();
        },
      ),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        backgroundColor: AppColors.white,
        onPressed: () => Navigator.pushNamed(context, AppRoutes.addList),
        child: Icon(Icons.add, color: AppColors.blue),
      ),
    );
  }
}
