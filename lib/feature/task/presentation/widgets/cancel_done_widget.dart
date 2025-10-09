// ignore: must_be_immutable
import 'package:flutter/material.dart';
import 'package:todo_notes/core/app_text_styles/app_text_styles.dart';

// ignore: must_be_immutable
class CancelDoneWidget extends StatelessWidget {
  String text;
  Function()? function;
  CancelDoneWidget({this.function, required this.text, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(5),
      onTap: function,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Text(text, style: AppTextStyles.tasksEditText),
      ),
    );
  }
}
