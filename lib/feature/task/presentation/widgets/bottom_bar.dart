import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_notes/core/app_colors/app_colors.dart';
import 'package:todo_notes/core/app_text_styles/app_text_styles.dart';
import 'package:todo_notes/feature/home/presentation/bloc/home_bloc.dart';
import 'package:todo_notes/feature/task/presentation/widgets/calendar.dart';
import 'package:todo_notes/feature/task/presentation/widgets/list_picked.dart';
import 'package:todo_notes/feature/task/presentation/widgets/time_picked.dart';

class BottomBarLists extends StatelessWidget {
  const BottomBarLists({super.key});

  void _showModal(BuildContext context, Widget child) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => SizedBox(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.7,
        child: child,
      ),
    );
  }

  void _showCupertinoTimePicker(BuildContext context, HomeBloc bloc) {
    showCupertinoModalPopup(
      context: context,
      builder: (_) => SizedBox(
        width: double.infinity,
        height: 250,
        child: CupertinoTimePickerStyled(
          initialTime: TimeOfDay.now(),
          onTimeChanged: (value) => bloc.add(OnChangeTimeEvent(value)),
          onCancel: () => Navigator.pop(context),
          onDone: () {
            bloc.add(HomeGetAllTasksEvent());
            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<HomeBloc>();
    final list = bloc.selectedList;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 16),
      color: AppColors.white,
      child: Row(
        children: [
          InkWell(
            onTap: () => _showModal(context, const TaskCalendar()),
            borderRadius: BorderRadius.circular(30),
            child: Icon(
              Icons.calendar_today_outlined,
              size: 25,
              color: AppColors.blue,
            ),
          ),
          const SizedBox(width: 25),
          InkWell(
            onTap: () => _showCupertinoTimePicker(context, bloc),
            borderRadius: BorderRadius.circular(30),
            child: Icon(CupertinoIcons.time, size: 25, color: AppColors.blue),
          ),
          const Spacer(),
          InkWell(
            onTap: () => _showModal(
              context,
              const Padding(padding: EdgeInsets.all(15), child: ListPicked()),
            ),
            borderRadius: BorderRadius.circular(30),
            child: Row(
              children: [
                Text(
                  list?.name ?? "Choose your list",
                  style: AppTextStyles.taskTimeText,
                ),
                const SizedBox(width: 15),
                Container(
                  width: 15,
                  height: 15,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: list?.color ?? AppColors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
