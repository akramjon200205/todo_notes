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

  String? _tempText;
  DateTime? _tempDate;
  TimeOfDay? _tempTime;
  ListModel? _listModel;

  HomeBloc(this.repository) : super(HomeInitial()) {
    on<HomeGetAllTasksEvent>(_onGetAllTasks);
    on<HomeAddTaskEvent>(_onAddTask);
    on<HomeUpdateTaskEvent>(_onUpdateTask);
    on<HomeDeleteTaskEvent>(_onDeleteTask);
    on<OnChangeTimeEvent>(_onChangeTime);
    on<OnChangeDateEvent>(_onChangeDate);
    on<OnChangeTextEvent>(_onChangeText);
    on<OnTaskIsCheckedEvent>(_onChangeTaskIsChecked);
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
    taskList[event.index] = isChecked;
    await repository.updateTasks(event.index, isChecked);
    emit(HomeUpdateTasks());
  }

  void _onChangeText(OnChangeTextEvent event, Emitter<HomeState> emit) {
    _tempText = event.text;
  }

  void _onChangeDate(OnChangeDateEvent event, Emitter<HomeState> emit) {
    _tempDate = event.date;
  }

  void _onChangeTime(OnChangeTimeEvent event, Emitter<HomeState> emit) {
    _tempTime = event.time;
  }

  Future<void> _onGetAllTasks(
    HomeGetAllTasksEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoading());
    final result = await repository.getAllTasks();
    result.fold((failure) => emit(HomeError(failure.message)), (tasks) {
      taskList = tasks;

      // for (var task in taskList) {
      //   final type = task.listModel.name ?? 'unknown';

      //   groupedByType.putIfAbsent(type, () => []);

      //   groupedByType[type]!.add(task);
      // }
      emit(
        HomeGetAllTasks(taskModelList: taskList, groupedByType: groupedByType),
      );
    });
  }

  Future<void> _onAddTask(
    HomeAddTaskEvent event,
    Emitter<HomeState> emit,
  ) async {
    DateTime combinedDateTime = DateTime(
      _tempDate?.year ?? DateTime.now().year,
      _tempDate?.month ?? DateTime.now().month,
      _tempDate?.day ?? DateTime.now().day,
      _tempTime?.hour ?? DateTime.now().hour,
      _tempTime?.minute ?? DateTime.now().minute,
    );
    final ListModel listModel = event.listModel;
    TaskModel task = TaskModel(
      isCompleted: false,      
      textTask: _tempText,
      time: combinedDateTime,
    );
    task.listModel.target = listModel;
    final result = await repository.addTasks(task);
    result.fold((failure) => emit(HomeError(failure.message)), (newTask) {
      taskList.add(newTask);
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
