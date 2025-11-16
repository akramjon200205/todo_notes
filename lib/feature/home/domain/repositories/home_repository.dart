import 'package:dartz/dartz.dart';
import 'package:todo_notes/core/common/errors/failure.dart';
import 'package:todo_notes/feature/home/data/models/task_model.dart';

abstract class HomeRepository {
  Future<Either<Failure, List< TaskModel>>> getAllTasks();
  Future<Either<Failure, TaskModel>> addTasks(TaskModel taskModel);
  Future<Either<Failure, TaskModel>> updateTasks(String key, TaskModel updateTask);
  Future<Either<Failure, dynamic>> deleteTasks(String key);
}
