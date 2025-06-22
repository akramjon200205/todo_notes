part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class HomeGetAllTasksEvent extends HomeEvent {
  const HomeGetAllTasksEvent();
}

class HomeAddTaskEvent extends HomeEvent {
  const HomeAddTaskEvent();
}

class HomeUpdateTaskEvent extends HomeEvent {
  const HomeUpdateTaskEvent();
}

class HomeDeleteTaskEvent extends HomeEvent {
  const HomeDeleteTaskEvent();
}
