import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_notes/feature/home/data/models/task_model.dart';
import 'package:todo_notes/feature/home/domain/repositories/home_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepository repository;
  
  List<TaskModel> _taskList = [];

  HomeBloc(this.repository) : super(HomeInitial()) {
    on<HomeGetAllTasksEvent>(_onGetAllTasks);
    on<HomeAddTaskEvent>(_onAddTask);
    on<HomeUpdateTaskEvent>(_onUpdateTask);
    on<HomeDeleteTaskEvent>(_onDeleteTask);
  }

  Future<void> _onGetAllTasks(
      HomeGetAllTasksEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoading());
    final result = await repository.getAllTasks();
    result.fold(
      (failure) => emit(HomeError(failure.message)),
      (tasks) {
        _taskList = tasks;
        emit(HomeGetAllTasks(_taskList));
      },
    );
  }

  Future<void> _onAddTask(
      HomeAddTaskEvent event, Emitter<HomeState> emit) async {
    final result = await repository.addTasks(event.taskModel);
    result.fold(
      (failure) => emit(HomeError(failure.message)),
      (newTask) {
        _taskList.add(newTask);
        emit(HomeGetAllTasks(List.from(_taskList)));
      },
    );
  }

  Future<void> _onUpdateTask(
      HomeUpdateTaskEvent event, Emitter<HomeState> emit) async {
    final result = await repository.updateTasks(event.index, event.updatedTask);
    result.fold(
      (failure) => emit(HomeError(failure.message)),
      (updatedTask) {
        _taskList[event.index] = updatedTask;
        emit(HomeGetAllTasks(List.from(_taskList)));
      },
    );
  }

  Future<void> _onDeleteTask(
      HomeDeleteTaskEvent event, Emitter<HomeState> emit) async {
    final result = await repository.deleteTasks(event.index);
    result.fold(
      (failure) => emit(HomeError(failure.message)),
      (_) {
        _taskList.removeAt(event.index);
        emit(HomeGetAllTasks(List.from(_taskList)));
      },
    );
  }
}