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
  List<ListModel> listModels;
  HomeAddTaskEvent(this.taskModel, this.listModels);
}

// ignore: must_be_immutable
class HomeUpdateTaskEvent extends HomeEvent {
  int index;
  String key;
  TaskModel updatedTask;
  List<ListModel> listModels;

  HomeUpdateTaskEvent(this.index, this.updatedTask, this.key, this.listModels);
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
class OnChangeListEvent extends HomeEvent {
  ListModel listModel;
  OnChangeListEvent(this.listModel);
}

// ignore: must_be_immutable
class OnChangeTextEvent extends HomeEvent {
  String text;
  OnChangeTextEvent(this.text);
}

// ignore: must_be_immutable
class HomeDeleteTaskEvent extends HomeEvent {
  int index;
  String key;
  List<ListModel> listModels;
  HomeDeleteTaskEvent({
    required this.index,
    required this.key,
    required this.listModels,
  });
}

// ignore: must_be_immutable
class OnTaskIsCheckedEvent extends HomeEvent {
  int index;
  String key;
  bool isChecked;
  OnTaskIsCheckedEvent({
    required this.index,
    required this.isChecked,
    required this.key,
  });
}

// ignore: must_be_immutable
class ListTasksEvent extends HomeEvent {
  List<ListModel> lists;
  ListTasksEvent(this.lists);
}
