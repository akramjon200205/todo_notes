part of 'home_bloc.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

final class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

// ignore: must_be_immutable
class HomeGetAllTasks extends HomeState {
  List<TaskModel> taskModelList;
  HomeGetAllTasks(this.taskModelList);
}

// ignore: must_be_immutable
class HomeUpdateTasks extends HomeState {
  int index;
  TaskModel updatedTask;

  HomeUpdateTasks({required this.index, required this.updatedTask});
}

// ignore: must_be_immutable
class HomeDeleteTasks extends HomeState {
  int index;
  HomeDeleteTasks({required this.index});
}

// ignore: must_be_immutable
class HomeAddTasks extends HomeState {
  TaskModel taskModel;
  HomeAddTasks({required this.taskModel});
}

class HomeError extends HomeState {
  final String message;

  const HomeError(this.message);

  @override
  List<Object> get props => [message];
}