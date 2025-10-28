import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_notes/core/app_colors/app_colors.dart';
import 'package:todo_notes/core/app_text_styles/app_text_styles.dart';
import 'package:todo_notes/feature/home/presentation/bloc/home_bloc.dart';
import 'package:todo_notes/feature/task/presentation/widgets/calendar.dart';
import 'package:todo_notes/feature/task/presentation/widgets/list_picked.dart';
import 'package:todo_notes/feature/task/presentation/widgets/time_picked.dart';

class BottomBarLists extends StatefulWidget {
  const BottomBarLists({super.key});

  @override
  State<BottomBarLists> createState() => _BottomBarListsState();
}

class _BottomBarListsState extends State<BottomBarLists> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        final contextState = context.read<HomeBloc>();
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 16),
          decoration: BoxDecoration(color: AppColors.white),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () => showModalBottomSheet(
                  context: context,
                  builder: (_) => SizedBox(
                    width: double.infinity,
                    height: double.maxFinite,
                    child: TaskCalendar(),
                  ),
                ),
                child: SizedBox(
                  child: Icon(
                    Icons.calendar_today_outlined,
                    size: 25,
                    color: AppColors.blue,
                  ),
                ),
              ),
              SizedBox(width: 25),
              GestureDetector(
                onTap: () => showCupertinoModalPopup(
                  context: context,
                  builder: (_) => SizedBox(
                    width: double.infinity,
                    height: 250,
                    child: CupertinoTimePickerStyled(
                      initialTime: TimeOfDay.now(),
                      onTimeChanged: (TimeOfDay value) {
                        contextState.add(OnChangeTimeEvent(value));
                      },
                      onCancel: () {
                        Navigator.pop(context);
                      },
                      onDone: () {
                        contextState.add(HomeGetAllTasksEvent());
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ),
                child: SizedBox(
                  child: Icon(
                    CupertinoIcons.time,
                    size: 25,
                    color: AppColors.blue,
                  ),
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: () => showModalBottomSheet(
                  context: context,
                  builder: (_) => SizedBox(
                    width: double.infinity,
                    height: double.maxFinite,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 15,
                      ),
                      child: ListPicked(),
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    SizedBox(
                      child: Text(
                        contextState.listModels?.name ??
                            "Choose your list",
                        style: AppTextStyles.taskTimeText,
                      ),
                    ),
                    SizedBox(width: 15),
                    Container(
                      width: 15,
                      height: 15,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color:
                            contextState.listModels?.color ??
                            AppColors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
