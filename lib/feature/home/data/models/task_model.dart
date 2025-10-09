import 'package:hive/hive.dart';
import 'package:todo_notes/feature/list/data/models/list_model.dart';

part 'task_model.g.dart';

@HiveType(typeId: 0)
class TaskModel extends HiveObject {
  @HiveField(0)
  String? textTask;

  @HiveField(1)
  bool? isChecked;

  @HiveField(2)
  DateTime? time;

  @HiveField(3)
  ListModel? listModel;

  TaskModel({this.isChecked, this.textTask, this.time, this.listModel});

  TaskModel copyWith({
    String? textTask,
    bool? isChecked,
    DateTime? time,
    ListModel? listModel,
  }) {
    return TaskModel(
      isChecked: isChecked ?? this.isChecked,
      textTask: textTask ?? this.textTask,
      time: time ?? this.time,
      listModel: listModel ?? this.listModel,
    );
  }
}
