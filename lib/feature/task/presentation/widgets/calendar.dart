import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:todo_notes/feature/home/presentation/bloc/home_bloc.dart';

// ignore: must_be_immutable
class TaskCalendar extends StatefulWidget {
  Map<DateTime, List<Color>> tasklist;
  TaskCalendar({required this.tasklist, super.key});
  @override
  State<TaskCalendar> createState() => _TaskCalendarState();
}

class _TaskCalendarState extends State<TaskCalendar> {
  DateTime? _focusedDay;
  DateTime? _selectedDay;

  List<Color> _getEventsForDay(DateTime day) {
    return widget.tasklist[DateTime.utc(day.year, day.month, day.day)] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      firstDay: DateTime.utc(2020, 1, 1),
      lastDay: DateTime.utc(2035, 12, 31),
      focusedDay: _focusedDay ?? DateTime.now(),
      selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
      onDaySelected: (selectedDay, focusedDay) {
        setState(() {
          _selectedDay = selectedDay;
          _focusedDay = focusedDay;
        });
        context.read<HomeBloc>().add(OnChangeDateEvent(selectedDay));
        context.read<HomeBloc>().add(HomeGetAllTasksEvent());
      },
      calendarStyle: CalendarStyle(
        todayDecoration: BoxDecoration(
          // ignore: deprecated_member_use
          color: Colors.blue.withOpacity(0.2),
          shape: BoxShape.circle,
        ),
        selectedDecoration: BoxDecoration(
          color: Colors.blueAccent,
          shape: BoxShape.circle,
        ),
        markersMaxCount: 4,
        markersAlignment: Alignment.bottomCenter,
        markerDecoration: const BoxDecoration(shape: BoxShape.circle),
      ),
      calendarBuilders: CalendarBuilders(
        markerBuilder: (context, date, events) {
          final taskColors = _getEventsForDay(date);
          if (taskColors.isEmpty) return const SizedBox.shrink();
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: taskColors
                .map(
                  (color) => Container(
                    margin: const EdgeInsets.symmetric(horizontal: 0.5),
                    width: 5,
                    height: 5,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                    ),
                  ),
                )
                .toList(),
          );
        },
      ),
      headerStyle: const HeaderStyle(
        titleCentered: true,
        formatButtonVisible: false,
        titleTextStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
      ),
    );
  }
}
