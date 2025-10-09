import 'package:flutter/material.dart';
import 'package:todo_notes/core/app_colors/app_colors.dart';

class AppTextStyles {
  AppTextStyles._();
  static const _font = 'SFProText';

  static TextStyle homeText = s(
    color: AppColors.black,
    weight: FontWeight.w700,
    size: 41,
  );

  static TextStyle taskText = s(
    color: AppColors.black,
    weight: FontWeight.w500,
    size: 18,
  );

  static TextStyle listText = s(
    color: AppColors.black,
    weight: FontWeight.w700,
    size: 16,
  );

  static TextStyle listsNameText = s(
    color: AppColors.black,
    weight: FontWeight.w600,
    size: 19,
  );
  static TextStyle listsSubText = s(
    color: AppColors.black,
    weight: FontWeight.w400,
    size: 14,
  );

  static TextStyle tasksEditText = s(
    color: AppColors.blue,
    weight: FontWeight.w400,
    size: 18,
  );

  static TextStyle tasksText = s(
    color: AppColors.black.withValues(alpha: 0.15),
    weight: FontWeight.w500,
    size: 18,
  );

  static TextStyle taskTimeText = s(
    color: AppColors.black,
    weight: FontWeight.w500,
    size: 14,
  );

  static TextStyle s({
    double size = 14,
    FontWeight weight = FontWeight.normal,
    Color color = Colors.black,
    TextDecoration? decoration,
  }) {
    return TextStyle(
      fontSize: size,
      fontWeight: weight,
      color: color,
      fontFamily: _font,
      decoration: decoration,
    );
  }
}
