import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:todo_notes/feature/home/data/models/task_model.dart';
import 'package:todo_notes/feature/home/domain/repositories/home_repository.dart';
import 'package:todo_notes/feature/list/data/models/list_model.dart';
import 'package:todo_notes/feature/list/domain/repository/list_model_repository.dart';

part 'list_event.dart';
part 'list_state.dart';

class ListBloc extends Bloc<ListEvent, ListState> {
  final ListModelRepository listModelRepository;
  final HomeRepository homeRepository;
  List<ListModel> listModels = [];
  Color listColor = Colors.blue;
  Map<String, List<TaskModel>> groupedTaskInLists = {};

  ListBloc(this.listModelRepository, this.homeRepository)
    : super(ListInitial()) {
    on<AddListEvent>(_onAddListEvent);
    on<UpdateListEvent>(_onUpdateListEvent);
    on<GetListEvent>(_onGetListEvent);
    on<DeleteListEvent>(_onDeleteListEvent);
    on<ChangeColorEvent>(_onChangeColorEvent);
    add(GetListEvent());
  }

  Future<void> _onChangeColorEvent(ChangeColorEvent event, Emitter emit) async {
    listColor = event.changeColor;
    emit(ChangeColorState());
  }

  Future<void> _onAddListEvent(AddListEvent event, Emitter emit) async {
    emit(ListLoading());
    final result = await listModelRepository.addList(event.listModel);
    result.fold((l) => emit(ListError(l.message)), (r) {
      listModels.add(r);
      emit(GetListState(listModels));
    });
  }

  Future<void> _onUpdateListEvent(UpdateListEvent event, Emitter emit) async {
    emit(ListLoading());

    final result = await listModelRepository.updateList(
      event.key,
      event.listModel,
    );
    if (result.isLeft()) {
      emit(ListError(result.fold((l) => l.message, (r) => '')));
      return;
    }
    final updatedList = result.fold((l) => null, (r) => r)!;
    listModels[event.index] = updatedList.copyWith();
    for (var task in event.taskList) {
      await homeRepository.updateTasks(
        task.key!,
        task.copyWith(listModel: updatedList),
      );
    }
    emit(UpdateListState());
  }

  Future<void> _onGetListEvent(GetListEvent event, Emitter emit) async {
    emit(ListLoading());
    final result = await listModelRepository.getAllLists();
    result.fold((l) => emit(ListError(l.message)), (r) {
      listModels = r;

      emit(GetListState(r));
    });
  }

  Future<void> _onDeleteListEvent(DeleteListEvent event, Emitter emit) async {
    emit(ListLoading());

    ListModel list = listModels[event.index];

    final tasksToDelete = event.taskList
        .where((task) => task.listModel.key == list.key)
        .toList();

    for (var task in tasksToDelete) {
      await homeRepository.deleteTasks(task.key ?? '');
    }

    event.taskList.removeWhere((task) => task.listModel.key == list.key);
    for (var element in event.taskList) {
      final date = DateTime.utc(
        element.time?.year ?? DateTime.now().year,
        element.time?.month ?? DateTime.now().month,
        element.time?.day ?? DateTime.now().day,
      );

      if (event.calendarTasks.containsKey(date)) {
        event.calendarTasks[date]!.add(element.listModel.color);
      } else {
        event.calendarTasks[date] = [element.listModel.color];
      }
    }
    final result = await listModelRepository.deleteList(event.key);
    result.fold((l) => emit(ListError(l.message)), (r) {
      listModels.removeAt(event.index);
      emit(DeleteListState());
    });
  }
}
