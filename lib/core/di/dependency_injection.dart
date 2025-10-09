import 'package:get_it/get_it.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:todo_notes/feature/home/data/datasources/home_datasource.dart';
import 'package:todo_notes/feature/list/data/datasource/local/list_model_datasource_impl.dart';
import 'package:todo_notes/feature/list/data/models/list_model.dart';
import 'package:todo_notes/feature/home/data/models/task_model.dart';
import 'package:todo_notes/feature/home/data/repositories/home_repository_impl.dart';
import 'package:todo_notes/feature/home/domain/repositories/home_repository.dart';
import 'package:todo_notes/feature/home/presentation/bloc/home_bloc.dart';
import 'package:todo_notes/feature/list/data/repository/list_model_repository_impl.dart';
import 'package:todo_notes/feature/list/domain/data/list_model_datasource.dart';
import 'package:todo_notes/feature/list/domain/repository/list_model_repository.dart';
import 'package:todo_notes/feature/list/presentation/bloc/list_bloc.dart';

final di = GetIt.instance;

Future<void> init() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TaskModelAdapter());
  Hive.registerAdapter(ListModelAdapter());

  di.registerLazySingleton<HomeDatasource>(() => HomeDatasourceImpl());

  di.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(homeDatasource: di()),
  );

  di.registerLazySingleton<ListModelDatasource>(
    () => ListModelDatasourceImpl(),
  );
  di.registerLazySingleton<ListModelRepository>(
    () => ListModelRepositoryImpl(listModelDatasource: di()),
  );

  di.registerFactory<HomeBloc>(() => HomeBloc(di()));
  di.registerFactory<ListBloc>(() => ListBloc(di()));
}
