import 'package:flutter/material.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class ListModel {
  @Id()
  int id;
  String? name;
  int colorValue;

  // ignore: deprecated_member_use
  ListModel({this.id = 0, this.name, Color? color})
    // ignore: deprecated_member_use
    : colorValue = color?.value ?? Colors.white.value;

  ListModel copyWith({int? id, String? name, Color? color}) {
    return ListModel(
      id: id ?? this.id,
      name: name ?? this.name,
      color: color ?? this.color,
    );
  }

  /// Getter - colorValue dan Color obyektini qaytaradi
  Color get color => Color(colorValue);

  /// Setter - Color obyektini qabul qilib colorValue ga yozadi
  // ignore: deprecated_member_use
  set color(Color newColor) => colorValue = newColor.value;
}
