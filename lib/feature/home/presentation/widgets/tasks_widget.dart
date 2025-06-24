import 'package:flutter/material.dart';
import 'package:todo_notes/core/app_colors/app_colors.dart';
import 'package:todo_notes/core/app_text_styles/app_text_styles.dart';

class TaskItemTile extends StatelessWidget {
  final String title;
  final String? time;
  final Color indicatorColor;
  final bool isChecked;
  final VoidCallback? onTap;

  const TaskItemTile({
    super.key,
    required this.title,
    this.time,
    required this.indicatorColor,
    this.isChecked = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.grey, width: 2),
                    color: isChecked ? AppColors.blue : AppColors.white,
                  ),
                  child: isChecked
                      ? Center(
                          child: Icon(
                            Icons.check,
                            size: 16,
                            color: AppColors.white,
                          ),
                        )
                      : null,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: AppTextStyles.taskText),
                      if (time != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Row(
                            children: [
                              Icon(
                                Icons.access_time,
                                size: 14,
                                color: Colors.grey,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                time!,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),

                Container(
                  width: 10,
                  height: 10,
                  margin: const EdgeInsets.only(left: 8),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: indicatorColor,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            Divider(height: 1, color: Colors.grey.shade300),
          ],
        ),
      ),
    );
  }
}
