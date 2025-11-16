import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo_notes/core/app_colors/app_colors.dart';
import 'package:todo_notes/core/app_text_styles/app_text_styles.dart';
import 'package:todo_notes/core/assets/assets.dart';
import 'package:todo_notes/core/route/routes.dart';
import 'package:todo_notes/feature/list/presentation/bloc/list_bloc.dart';

class BottomSheetList extends StatelessWidget {
  final Color color;
  final int index;
  final String name;

  const BottomSheetList({
    super.key,
    required this.color,
    required this.index,
    required this.name,
  });

  Color getTextColor(Color bgColor) {
    // Background rangiga qarab qora/oq text
    final lightColors = [Colors.white, Colors.amber, Colors.cyan];
    return lightColors.contains(bgColor) ? AppColors.black : AppColors.white;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textColor = getTextColor(color);

    return Material(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
      child: Container(
        height: size.height * 0.9,
        width: size.width,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
        decoration: BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text(
                name,
                style: AppTextStyles.listName.copyWith(color: textColor),
              ),
              leading: Container(
                width: 25,
                height: 25,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: textColor, width: 2),
                ),
              ),
              trailing: InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: () {
                  final listBloc = context.read<ListBloc>();
                  listBloc.add(ChangeColorEvent(color));

                  Navigator.pushNamed(
                    context,
                    AppRoutes.editList,
                    arguments: {
                      'listModel': listBloc.listModels[index],
                      'index': index,
                    },
                  );
                },
                child: SvgPicture.asset(
                  Assets.svgIcons.edit,
                  // ignore: deprecated_member_use
                  color: textColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
