import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:todo_notes/core/hive_ce_box/hive_ce_box.dart';
import 'package:todo_notes/feature/home/data/models/task_model.dart';

abstract class HomeDatasource {
  Future<List<TaskModel>> getAllTasks();
  Future<void> addTask(TaskModel task);
  Future<void> deleteTask(String key);
  Future<void> updateTask(String key, TaskModel updatedTask);
}

class HomeDatasourceImpl implements HomeDatasource {
  HomeDatasourceImpl();

  Box<TaskModel> get box => Hive.box<TaskModel>(HiveCeBox.hiveBox);

  @override
  Future<void> addTask(TaskModel task) async {
    final key = DateTime.now().millisecondsSinceEpoch.toString();
    final newTask = TaskModel(
      text: task.text,
      time: task.time,
      listModel: task.listModel, // agar ListModel box-da bo'lsa
      isCompleted: task.isCompleted,
      key: key,
    );

    await box.put(key, newTask);
  }

  @override
  Future<void> deleteTask(String key) async {
    await box.delete(key);
  }

  @override
  Future<List<TaskModel>> getAllTasks() async {
    return box.values.toList();
  }

  @override
  Future<void> updateTask(String key, TaskModel updatedTask) async {
    await box.put(key, updatedTask);
  }
}
