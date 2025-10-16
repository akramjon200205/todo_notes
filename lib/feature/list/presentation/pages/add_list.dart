import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_notes/core/app_colors/app_colors.dart';
import 'package:todo_notes/core/app_text_styles/app_text_styles.dart';
import 'package:todo_notes/feature/list/data/models/list_model.dart';
import 'package:todo_notes/feature/list/presentation/bloc/list_bloc.dart';
import 'package:todo_notes/feature/list/presentation/widgets/color_picker_widget.dart';

class AddList extends StatefulWidget {
  const AddList({super.key});

  @override
  State<AddList> createState() => _AddListState();
}

class _AddListState extends State<AddList> {
  TextEditingController listController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        leading: InkWell(
          borderRadius: BorderRadius.circular(30),
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(CupertinoIcons.back, size: 22),
        ),
        title: Text(
          "Add list",
          style: AppTextStyles.homeText.copyWith(fontSize: 30),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<ListBloc, ListState>(
        builder: (context, state) {
          return Padding(
            padding: EdgeInsetsGeometry.symmetric(horizontal: 15),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                Container(
                  padding: EdgeInsets.only(left: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(11),
                    border: Border.all(color: AppColors.grey200, width: 1),
                    color: AppColors.listColor,
                  ),
                  child: TextField(
                    controller: listController,
                    style: AppTextStyles.listsNameText.copyWith(
                      fontWeight: FontWeight.w400,
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      focusColor: AppColors.listColor,

                      fillColor: AppColors.listColor,
                      hintText: "Write your list name",
                      hintStyle: AppTextStyles.listsNameText.copyWith(
                        fontWeight: FontWeight.w400,
                      ),
                      suffixIcon: Padding(
                        padding: const EdgeInsets.only(
                          right: 10,
                          bottom: 10,
                          top: 10,
                        ),
                        child: InkWell(
                          onTap: () => showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              alignment: Alignment.center,
                              title: Text(
                                "Pick your list color",
                                style: AppTextStyles.listsSubText,
                                textAlign: TextAlign.center,
                              ),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ColorPickerWidget(),
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: Text(
                                      "Select",
                                      style: AppTextStyles.taskText.copyWith(
                                        color: AppColors.blue,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          child: Container(
                            height: 10,
                            width: 10,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: context.read<ListBloc>().listColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                    cursorColor: AppColors.black,
                  ),
                ),
                Spacer(),
                InkWell(
                  onTap: () {
                    if (listController.text.isNotEmpty) {
                      context.read<ListBloc>().add(
                        AddListEvent(
                          listModel: ListModel(
                            color: context.read<ListBloc>().listColor,
                            name: listController.text,
                          ),
                        ),
                      );
                      listController.clear();
                      context.read<ListBloc>().add(GetListEvent());
                      Navigator.pop(context); // sahifadan chiqish
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppColors.blue,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text(
                      "Add list",
                      style: AppTextStyles.listText.copyWith(
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 35),
              ],
            ),
          );
        },
      ),
    );
  }
}
