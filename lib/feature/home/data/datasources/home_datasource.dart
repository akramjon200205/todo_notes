import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_notes/core/hive_box/hive_box.dart';
import 'package:todo_notes/feature/home/data/models/task_model.dart';

abstract class HomeDatasource {
  Future<List<TaskModel>> getAllTAsks();
  Future<void> addTask(TaskModel task);
  Future<TaskModel> updateTask(int index, TaskModel updatedTask);
  Future<void> deleteTask(int index);
}

class HomeDatasourceImpl implements HomeDatasource {
  @override
  Future<void> addTask(TaskModel task) async {
    final Box<TaskModel> taskBox = await Hive.openBox<TaskModel>(
      HiveBoxes.taskBox,
    );

    await taskBox.add(task);
    await taskBox.close();
  }

  @override
  Future<void> deleteTask(int index) async {
    final Box<TaskModel> taskBox = await Hive.openBox<TaskModel>(
      HiveBoxes.taskBox,
    );

    await taskBox.deleteAt(index);
    await taskBox.close();
  }

  @override
  Future<List<TaskModel>> getAllTAsks() async {
    final Box<TaskModel> taskBox = await Hive.openBox<TaskModel>(
      HiveBoxes.taskBox,
    );

    final getAllTasks = taskBox.values.toList();
    await taskBox.close();
    return getAllTasks;
  }

  @override
  Future<TaskModel> updateTask(int index, TaskModel updatedTask) async {
    final Box<TaskModel> taskBox = await Hive.openBox<TaskModel>(
      HiveBoxes.taskBox,
    );
    await taskBox.putAt(index, updatedTask);
    final updated = taskBox.getAt(index)!;

    await taskBox.close();

    return updated;
  }
}
