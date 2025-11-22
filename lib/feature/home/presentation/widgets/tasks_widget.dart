import 'package:flutter/material.dart';
import 'package:todo_notes/core/app_colors/app_colors.dart';
import 'package:todo_notes/core/app_text_styles/app_text_styles.dart';

class TaskItemTile extends StatelessWidget {
  final String title;
  final String? time;
  final Color? indicatorColor;
  final bool isChecked;
  final VoidCallback? onTap;
  final Color? bgColor;

  const TaskItemTile({
    super.key,
    this.bgColor,
    required this.title,
    this.time,
    this.indicatorColor,
    this.isChecked = false,
    this.onTap,
  });

  Color getTextColor(Color bgColor) {
    final lightColors = [Colors.white, Colors.amber, Colors.cyan];
    return lightColors.contains(bgColor) ? AppColors.black : AppColors.white;
  }

  @override
  Widget build(BuildContext context) {
    final textColor = getTextColor(bgColor??Colors.white);
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
            child: Column(
              children: [
                Row(
                  children: [
                    indicatorColor != null
                        ? Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: AppColors.grey,
                                width: 2,
                              ),
                              color: isChecked
                                  ? AppColors.blue
                                  : AppColors.white,
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
                          )
                        : SizedBox.shrink(),
                    const SizedBox(width: 12),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(title, style: AppTextStyles.taskText.copyWith(color: textColor)),
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
                    Spacer(),
                    if (indicatorColor != null)
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
              ],
            ),
          ),
        ),
      ],
    );
  }
}
