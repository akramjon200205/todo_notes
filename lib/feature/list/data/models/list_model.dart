import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'list_model.g.dart';

@HiveType(typeId: 1)
class ListModel extends HiveObject {
  @HiveField(0)
  String? name;

  @HiveField(1)
  Color? color;

  ListModel(this.name, this.color);

  ListModel copyWith({String? name, Color? color}) {
    return ListModel(name ?? this.name, color ?? this.color);
  }
}
