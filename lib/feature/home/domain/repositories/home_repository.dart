import 'package:dartz/dartz.dart';
import 'package:todo_notes/core/common/errors/failure.dart';
import 'package:todo_notes/feature/home/data/models/task_model.dart';

abstract class HomeRepository {
  Future<Either<Failure, List<TaskModel>>> getAllTasks();
  Future<Either<Failure, String>> addTasks(TaskModel taskModel);
  Future<Either<Failure, TaskModel>> updateTasks(int index, TaskModel updateTask);
  Future<Either<Failure, dynamic>> deleteTasks(int index);
}
