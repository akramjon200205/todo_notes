import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_notes/feature/home/data/models/task_model.dart';
import 'package:todo_notes/feature/home/domain/repositories/home_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepository repository;
  HomeBloc(this.repository) : super(HomeInitial()) {
    on<HomeEvent>((event, emit) {});

    on<HomeGetAllTasksEvent>(_homeGetAllTasks);
  }

  _homeGetAllTasks(HomeGetAllTasksEvent event, emit) async {
    emit(HomeLoading());
    final result = await repository.getAllTasks();
    result.fold(
      (l) => emit(HomeError(l.message)),
      (r) => emit(HomeGetAllTasks(r)),
    );
  }
}
