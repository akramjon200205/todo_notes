import 'package:hive/hive.dart';

part 'list_model.g.dart';
@HiveType(typeId: 1)
class ListModel extends HiveObject {
  @HiveField(0)
  String? name;

  ListModel(this.name);

  ListModel copyWith({String? name, int? taskCount}) {
    return ListModel(name ?? this.name);
  }
}
