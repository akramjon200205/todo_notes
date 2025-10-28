import 'package:dartz/dartz.dart';
import 'package:todo_notes/core/common/errors/failure.dart';
import 'package:todo_notes/feature/home/data/datasources/home_datasource.dart';
import 'package:todo_notes/feature/home/data/models/task_model.dart';
import 'package:todo_notes/feature/home/domain/repositories/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeDatasource homeDatasource;

  HomeRepositoryImpl({required this.homeDatasource});

  @override
  Future<Either<Failure, TaskModel>> addTasks(TaskModel taskModel) async {
    try {
      await homeDatasource.addTask(taskModel);
      return Right(taskModel);
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, dynamic>> deleteTasks(int index) async {
    try {
      await homeDatasource.deleteTask(index);
      return Right("delete task");
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<TaskModel>>> getAllTasks() async {
    try {
      final tasks = await homeDatasource.getAllTAsks();
      return Right(tasks);
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, TaskModel>> updateTasks(
    int index,
    TaskModel updatedTask,
  ) async {
    try {
      final updateTask = await homeDatasource.updateTask(index, updatedTask);
      return Right(updateTask);
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }
}
