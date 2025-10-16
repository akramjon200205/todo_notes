import 'package:objectbox/objectbox.dart';
import 'package:todo_notes/feature/list/data/models/list_model.dart';

@Entity()
class TaskModel {
  int id = 0;

  String? textTask;
  bool isCompleted;

  @Property(type: PropertyType.date)
  DateTime? time;

  final listModel = ToOne<ListModel>();

  TaskModel({this.textTask, this.isCompleted = false, this.time});
}
