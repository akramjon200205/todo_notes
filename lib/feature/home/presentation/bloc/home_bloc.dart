import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_notes/feature/list/data/models/list_model.dart';
import 'package:todo_notes/feature/home/data/models/task_model.dart';
import 'package:todo_notes/feature/home/domain/repositories/home_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepository repository;

  List<TaskModel> taskList = [];
  Map<String, List<TaskModel>> groupedByType = {};

  DateTime? tempDate;
  TimeOfDay? tempTime;
  ListModel? listModels;

  HomeBloc(this.repository) : super(HomeInitial()) {
    on<HomeGetAllTasksEvent>(_onGetAllTasks);
    on<HomeAddTaskEvent>(_onAddTask);
    on<HomeUpdateTaskEvent>(_onUpdateTask);
    on<HomeDeleteTaskEvent>(_onDeleteTask);
    on<OnChangeTimeEvent>(_onChangeTime);
    on<OnChangeDateEvent>(_onChangeDate);
    on<OnChangeTextEvent>(_onChangeText);
    on<OnTaskIsCheckedEvent>(_onChangeTaskIsChecked);
    on<OnChangeListEvent>(_onChangeListEvent);
  }

  Future<void> _onChangeTaskIsChecked(
    OnTaskIsCheckedEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoading());
    TaskModel taskModel = taskList[event.index];

    TaskModel isChecked = TaskModel(
      isCompleted: event.isChecked,
      textTask: taskModel.textTask,
      time: taskModel.time,
    );
    isChecked.listModel.target = taskList[event.index].listModel.target;
    taskList[event.index] = isChecked;
    await repository.updateTasks(event.index, isChecked);
    emit(HomeUpdateTasks());
  }

  void _onChangeListEvent(OnChangeListEvent event, Emitter<HomeState> emit) {
    listModels = event.listModel;
  }

  void _onChangeText(OnChangeTextEvent event, Emitter<HomeState> emit) {
    // _tempText = event.text;
  }

  void _onChangeDate(OnChangeDateEvent event, Emitter<HomeState> emit) {
    tempDate = event.date;
  }

  void _onChangeTime(OnChangeTimeEvent event, Emitter<HomeState> emit) {
    tempTime = event.time;
  }

  Future<void> _onGetAllTasks(
    HomeGetAllTasksEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoading());
    final result = await repository.getAllTasks();
    result.fold((failure) => emit(HomeError(failure.message)), (tasks) {
      taskList = tasks;
      emit(HomeGetAllTasks(taskModelList: tasks, groupedByType: groupedByType));
    });
  }

  Future<void> _onAddTask(
    HomeAddTaskEvent event,
    Emitter<HomeState> emit,
  ) async {
    final ListModel? listModel = listModels;
    TaskModel task = TaskModel(
      isCompleted: event.taskModel.isCompleted,
      textTask: event.taskModel.textTask,
      time: event.taskModel.time,
    );
    task.listModel.target = listModel;
    final result = await repository.addTasks(task);
    result.fold((failure) => emit(HomeError(failure.message)), (newTask) {
      taskList.add(newTask);
      taskList.sort((a, b) => a.time!.compareTo(b.time!));
      emit(HomeAddTasks());
    });
  }

  Future<void> _onUpdateTask(
    HomeUpdateTaskEvent event,
    Emitter<HomeState> emit,
  ) async {
    final TaskModel updatedTask = event.updatedTask;
    updatedTask.listModel.target = event.listModel;
    final result = await repository.updateTasks(event.index, event.updatedTask);
    result.fold((failure) => emit(HomeError(failure.message)), (updatedTask) {
      taskList[event.index] = updatedTask;
      taskList.sort((a, b) => a.time!.compareTo(b.time!));
      emit(HomeUpdateTasks());
    });
  }

  Future<void> _onDeleteTask(
    HomeDeleteTaskEvent event,
    Emitter<HomeState> emit,
  ) async {
    final result = await repository.deleteTasks(event.index);
    result.fold((failure) => emit(HomeError(failure.message)), (_) {
      taskList.removeAt(event.index);
      emit(HomeDeleteTasks());
    });
  }
}
