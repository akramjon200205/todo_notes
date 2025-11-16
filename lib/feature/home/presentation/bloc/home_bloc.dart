import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_notes/feature/list/data/models/list_model.dart';
import 'package:todo_notes/feature/home/data/models/task_model.dart';
import 'package:todo_notes/feature/home/domain/repositories/home_repository.dart';
import 'package:todo_notes/feature/list/domain/repository/list_model_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepository repository;
  final ListModelRepository listModelRepository;

  List<TaskModel> taskList = [];
  DateTime? tempDate;
  TimeOfDay? tempTime;
  ListModel? selectedList;

  HomeBloc(this.repository, this.listModelRepository) : super(HomeInitial()) {
    on<HomeGetAllTasksEvent>(_onGetAllTasks);
    on<HomeAddTaskEvent>(_onAddTask);
    on<HomeUpdateTaskEvent>(_onUpdateTask);
    on<HomeDeleteTaskEvent>(_onDeleteTask);
    on<OnChangeTimeEvent>(_onChangeTime);
    on<OnChangeDateEvent>(_onChangeDate);
    on<OnChangeTextEvent>(_onChangeText);
    on<OnTaskIsCheckedEvent>(_onChangeTaskIsChecked);
    on<OnChangeListEvent>(_onChangeListEvent);

    add(HomeGetAllTasksEvent());
  }

  void _onChangeListEvent(OnChangeListEvent event, Emitter<HomeState> emit) {
    selectedList = event.listModel;
  }

  void _onChangeText(OnChangeTextEvent event, Emitter<HomeState> emit) {}

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

    result.fold((error) => emit(HomeError(error.message)), (allTasks) {
      taskList = allTasks;
      emit(HomeGetAllTasks(taskModelList: taskList));
    });
  }

  Future<void> _onAddTask(
    HomeAddTaskEvent event,
    Emitter<HomeState> emit,
  ) async {
    if (selectedList == null) {
      emit(HomeError("List tanlanmagan"));
      return;
    }

    await repository.addTasks(event.taskModel);
    emit(HomeAddTasks());
  }

  Future<void> _onUpdateTask(
    HomeUpdateTaskEvent event,
    Emitter<HomeState> emit,
  ) async {
    final task = event.updatedTask;

    await repository.updateTasks(event.key, task);
    emit(HomeUpdateTasks());
  }

  Future<void> _onDeleteTask(
    HomeDeleteTaskEvent event,
    Emitter<HomeState> emit,
  ) async {
    final result = await repository.deleteTasks(event.key);

    result.fold((l) => emit(HomeError(l.message)), (r) {
      if (event.index >= 0 && event.index < taskList.length) {
        taskList.removeAt(event.index);
      }
      emit(HomeGetAllTasks(taskModelList: [...taskList]));
    });
  }

  Future<void> _onChangeTaskIsChecked(
    OnTaskIsCheckedEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoading());

    final oldTask = taskList[event.index];

    final updated = TaskModel(
      text: oldTask.text,
      time: oldTask.time,
      isCompleted: event.isChecked,
      listModel: oldTask.listModel,
    );

    final result = await repository.updateTasks(event.key, updated);

    result.fold((failure) => emit(HomeError(failure.message)), (_) {
      taskList[event.index] = updated;
      emit(HomeUpdateTasks());
    });
  }
}
