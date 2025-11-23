import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo_notes/core/app_colors/app_colors.dart';
import 'package:todo_notes/core/app_text_styles/app_text_styles.dart';
import 'package:todo_notes/core/assets/assets.dart';
import 'package:todo_notes/core/route/routes.dart';
import 'package:todo_notes/feature/home/data/models/task_model.dart';
import 'package:todo_notes/feature/home/presentation/widgets/divider_widget.dart';
import 'package:todo_notes/feature/home/presentation/widgets/tasks_widget.dart';

import 'package:todo_notes/feature/list/presentation/bloc/list_bloc.dart';

class BottomSheetList extends StatefulWidget {
  final Color color;
  final int index;
  final String name;
  final List<TaskModel> tasklist;

  const BottomSheetList({
    super.key,
    required this.color,
    required this.index,
    required this.name,
    required this.tasklist,
  });

  @override
  State<BottomSheetList> createState() => _BottomSheetListState();
}

class _BottomSheetListState extends State<BottomSheetList> {
  Color getTextColor(Color bgColor) {
    final lightColors = [Colors.white, Colors.amber, Colors.cyan];
    return lightColors.contains(bgColor) ? AppColors.black : AppColors.white;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textColor = getTextColor(widget.color);

    return Material(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
      child: Container(
        height: size.height * 0.9,
        width: size.width,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
        decoration: BoxDecoration(
          color: widget.color,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text(
                widget.name,
                style: AppTextStyles.listName.copyWith(color: textColor),
              ),
              subtitle: Text(
                "${widget.tasklist.length} task",
                style: AppTextStyles.listsSubText.copyWith(color: textColor),
              ),

              trailing: InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: () {
                  final listBloc = context.read<ListBloc>();
                  listBloc.add(ChangeColorEvent(widget.color));
                  Navigator.pop(context);
                  Navigator.pushNamed(
                    context,
                    AppRoutes.editList,
                    arguments: {
                      'listModel': listBloc.listModels[widget.index],
                      'index': widget.index,
                      'taskList': widget.tasklist,
                    },
                  );
                },
                child: SvgPicture.asset(
                  Assets.svgIcons.edit,
                  // ignore: deprecated_member_use
                  color: textColor,
                ),
              ),
            ),
            ListView.separated(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return TaskItemTile(
                  isChecked: widget.tasklist[index].isCompleted,
                  title: widget.tasklist[index].text,
                  bgColor: widget.color,
                  indicatorColor: widget.color,
                );
              },
              separatorBuilder: (context, index) {
                return DividerWidget();
              },
              itemCount: widget.tasklist.length,
            ),
            widget.tasklist.isNotEmpty ? DividerWidget() : SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
