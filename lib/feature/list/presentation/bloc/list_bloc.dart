import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:todo_notes/feature/home/data/models/task_model.dart';
import 'package:todo_notes/feature/list/data/models/list_model.dart';
import 'package:todo_notes/feature/list/domain/repository/list_model_repository.dart';

part 'list_event.dart';
part 'list_state.dart';

class ListBloc extends Bloc<ListEvent, ListState> {
  final ListModelRepository listModelRepository;
  List<ListModel> listModels = [];
  Color listColor = Colors.blue;
  Map<String, List<TaskModel>> groupedTaskInLists = {};

  ListBloc(this.listModelRepository) : super(ListInitial()) {
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
      emit(AddListState()); // yangilangan ro‘yxat
    });
  }

  Future<void> _onUpdateListEvent(UpdateListEvent event, Emitter emit) async {
    emit(ListLoading());
    final results = await listModelRepository.updateList(
      event.key,
      event.listModel,
    );
    results.fold((l) => emit(ListError(l.message)), (r) {
      listModels[event.index] = r;
      emit(UpdateListState());
    });
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
    final result = await listModelRepository.deleteList(event.key);
    result.fold((l) => emit(ListError(l.message)), (r) {
      listModels.removeAt(event.index);
      emit(DeleteListState());
    });
  }
}
