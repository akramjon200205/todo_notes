import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_notes/core/app_colors/app_colors.dart';
import 'package:todo_notes/core/app_text_styles/app_text_styles.dart';
import 'package:todo_notes/core/route/routes.dart';
import 'package:todo_notes/feature/home/presentation/bloc/home_bloc.dart';
import 'package:todo_notes/feature/list/data/models/list_model.dart';
import 'package:todo_notes/feature/list/presentation/bloc/list_bloc.dart';
import 'package:todo_notes/feature/list/presentation/widgets/color_picker_widget.dart';

class AddList extends StatefulWidget {
  const AddList({super.key});

  @override
  State<AddList> createState() => _AddListState();
}

class _AddListState extends State<AddList> {
  final TextEditingController listController = TextEditingController();

  void _showColorPicker(ListBloc bloc) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        alignment: Alignment.center,
        title: Text(
          "Pick your list color",
          style: AppTextStyles.listsSubText,
          textAlign: TextAlign.center,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ColorPickerWidget(color: bloc.listColor),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                "Select",
                style: AppTextStyles.taskText.copyWith(color: AppColors.blue),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    listController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        leading: InkWell(
          borderRadius: BorderRadius.circular(30),
          onTap: () => Navigator.pushReplacementNamed(context, AppRoutes.lists),
          child: const Icon(CupertinoIcons.back, size: 22),
        ),
        title: Text("Add list", style: AppTextStyles.homeText.copyWith(fontSize: 30)),
        centerTitle: true,
      ),
      body: BlocListener<ListBloc, ListState>(
        listener: (context, state) {
          if (state is HomeUpdateTasks) {
            context.read<ListBloc>().add(GetListEvent());
            Navigator.pushReplacementNamed(context, AppRoutes.lists);
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.1),
              BlocBuilder<ListBloc, ListState>(
                builder: (context, state) {
                  final bloc = context.read<ListBloc>();
                  return Container(
                    padding: const EdgeInsets.only(left: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(11),
                      border: Border.all(color: AppColors.grey200, width: 1),
                      color: AppColors.listColor,
                    ),
                    child: TextField(
                      controller: listController,
                      style: AppTextStyles.listsNameText.copyWith(fontWeight: FontWeight.w400),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Write your list name",
                        hintStyle: AppTextStyles.listsNameText.copyWith(fontWeight: FontWeight.w400),
                        suffixIcon: Padding(
                          padding: const EdgeInsets.all(10),
                          child: InkWell(
                            onTap: () => _showColorPicker(bloc),
                            child: Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: bloc.listColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                      cursorColor: AppColors.black,
                    ),
                  );
                },
              ),
              const Spacer(),
              InkWell(
                onTap: () {
                  final bloc = context.read<ListBloc>();
                  if (listController.text.isNotEmpty) {
                    bloc.add(AddListEvent(
                      listModel: ListModel(
                        color: bloc.listColor,
                        name: listController.text,
                      ),
                    ));
                    listController.clear();
                  }
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColors.blue,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Text("Add list", style: AppTextStyles.listText.copyWith(color: AppColors.white)),
                ),
              ),
              const SizedBox(height: 35),
            ],
          ),
        ),
      ),
    );
  }
}
