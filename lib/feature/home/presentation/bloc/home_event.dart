part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class HomeGetAllTasksEvent extends HomeEvent {
  const HomeGetAllTasksEvent();
}

// ignore: must_be_immutable
class HomeAddTaskEvent extends HomeEvent {
  TaskModel taskModel;
  HomeAddTaskEvent(this.taskModel);
}

// ignore: must_be_immutable
class HomeUpdateTaskEvent extends HomeEvent {
  int index;
  TaskModel updatedTask;
  HomeUpdateTaskEvent(this.index, this.updatedTask);
}

// ignore: must_be_immutable
class OnChangeTimeEvent extends HomeEvent {
TimeOfDay time;
OnChangeTimeEvent(this.time);
}
// ignore: must_be_immutable
class OnChangeDateEvent extends HomeEvent {
DateTime date;
OnChangeDateEvent(this.date);
}
// ignore: must_be_immutable
class OnChangeTextEvent extends HomeEvent {
String text;
OnChangeTextEvent(this.text);
}

// ignore: must_be_immutable
class HomeDeleteTaskEvent extends HomeEvent {
  int index;
  HomeDeleteTaskEvent(this.index);
}
