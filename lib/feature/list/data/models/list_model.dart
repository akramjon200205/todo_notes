import 'package:hive_ce/hive.dart';
import 'package:flutter/material.dart';

part 'list_model.g.dart';

@HiveType(typeId: 1)
class ListModel {
  @HiveField(1)
  String name;

  @HiveField(2)
  Color color;

  @HiveField(3)
  String? key;

  ListModel({
    required this.name,
    required this.color,
    this.key,
  });

  ListModel copyWith({
    String? name,
    Color? color,
    String? key,
  }) {
    return ListModel(
      name: name ?? this.name,
      color: color ?? this.color,
      key: key ?? this.key,
    );
  }
}
