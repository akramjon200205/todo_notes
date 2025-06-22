import 'package:flutter/material.dart';
import 'package:todo_notes/core/app_colors/app_colors.dart';

class RoundCheckbox extends StatelessWidget {
  final bool isChecked;
  final VoidCallback onTap;

  const RoundCheckbox({
    super.key,
    required this.isChecked,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isChecked ? AppColors.blue : Colors.transparent,
          border: Border.all(
            color: isChecked ? AppColors.blue : AppColors.grey,
            width: 2,
          ),
        ),
        child: isChecked
            ? const Icon(Icons.check, color: Colors.white, size: 20)
            : null,
      ),
    );
  }
}
