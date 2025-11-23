import 'package:hive_ce/hive.dart';
import 'package:todo_notes/feature/list/data/models/list_model.dart';

part 'task_model.g.dart';

@HiveType(typeId: 2)
class TaskModel {
  @HiveField(1)
  String text;

  @HiveField(2)
  bool isCompleted;

  @HiveField(3)
  DateTime? time;

  @HiveField(4)
  ListModel listModel;

  @HiveField(5)
  String? key;

  TaskModel({
    required this.text,
    this.isCompleted = false,
    this.time,
    required this.listModel,
    this.key,
  });

  TaskModel copyWith({
    String? text,
    bool? isCompleted,
    DateTime? time,
    ListModel? listModel,
    String? key,
  }) {
    return TaskModel(
      text: text ?? this.text,
      isCompleted: isCompleted ?? this.isCompleted,
      time: time ?? this.time,
      listModel: listModel ?? this.listModel,
      key: key ?? this.key,
    );
  }
}
