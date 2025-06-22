import 'package:get_it/get_it.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:todo_notes/feature/home/data/datasources/home_datasource.dart';
import 'package:todo_notes/feature/home/data/models/list_model.dart';
import 'package:todo_notes/feature/home/data/models/task_model.dart';
import 'package:todo_notes/feature/home/data/repositories/home_repository_impl.dart';
import 'package:todo_notes/feature/home/domain/repositories/home_repository.dart';
import 'package:todo_notes/feature/home/presentation/bloc/home_bloc.dart';

final di = GetIt.instance;

Future<void> init() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TaskModelAdapter());
  Hive.registerAdapter(ListModelAdapter());

  di.registerLazySingleton<HomeDatasource>(() => HomeDatasourceImpl());

  di.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(homeDatasource: di()),
  );

  di.registerFactory<HomeBloc>(() => HomeBloc(di()));
}
