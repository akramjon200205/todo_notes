import 'package:objectbox/objectbox.dart';
import 'package:todo_notes/feature/home/data/models/task_model.dart';

abstract class HomeDatasource {
  Future<List<TaskModel>> getAllTAsks();
  Future<void> addTask(TaskModel task);
  Future<TaskModel> updateTask(int index, TaskModel updatedTask);
  Future<void> deleteTask(int index);
}

class HomeDatasourceImpl implements HomeDatasource {
  final Store store;

  HomeDatasourceImpl(this.store);

  @override
  Future<void> addTask(TaskModel task) async {
    final box = store.box<TaskModel>();
    box.put(task); // id=0 bo'lsa yangi yozuv sifatida saqlanadi
  }

  @override
  Future<void> deleteTask(int index) async {
    final box = store.box<TaskModel>();
    final allTasks = box.getAll();
    if (index >= 0 && index < allTasks.length) {
      box.remove(allTasks[index].id);
    }
  }

  @override
  Future<List<TaskModel>> getAllTAsks() async {
    final box = store.box<TaskModel>();
    return box.getAll();
  }

  @override
  Future<TaskModel> updateTask(int index, TaskModel updatedTask) async {
    final box = store.box<TaskModel>();
    final allTasks = box.getAll();

    if (index >= 0 && index < allTasks.length) {
      final existing = allTasks[index];
      updatedTask.id = existing.id; // mavjud yozuvni yangilash uchun
      box.put(updatedTask);
      return updatedTask;
    }

    throw Exception("Invalid index: $index");
  }
}
