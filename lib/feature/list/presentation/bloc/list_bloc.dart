import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:todo_notes/feature/list/data/models/list_model.dart';
import 'package:todo_notes/feature/list/domain/repository/list_model_repository.dart';

part 'list_event.dart';
part 'list_state.dart';

class ListBloc extends Bloc<ListEvent, ListState> {
  ListModelRepository listModelRepository;
  ListBloc(this.listModelRepository) : super(ListInitial()) {
    on<ListEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
