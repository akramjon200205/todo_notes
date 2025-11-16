import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_notes/core/app_colors/app_colors.dart';
import 'package:todo_notes/core/app_text_styles/app_text_styles.dart';
import 'package:todo_notes/core/route/routes.dart';
import 'package:todo_notes/feature/list/data/models/list_model.dart';
import 'package:todo_notes/feature/list/presentation/bloc/list_bloc.dart';
import 'package:todo_notes/feature/list/presentation/widgets/color_picker_widget.dart';

class EditList extends StatefulWidget {
  final ListModel listModel;
  final int index;

  const EditList({required this.listModel, required this.index, super.key});

  @override
  State<EditList> createState() => _EditListState();
}

class _EditListState extends State<EditList> {
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.listModel.name);
  }

  @override
  void dispose() {
    controller.dispose();
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
        title: Text(
          "Edit list",
          style: AppTextStyles.homeText.copyWith(fontSize: 30),
        ),
        centerTitle: true,
      ),
      body: BlocListener<ListBloc, ListState>(
        listener: (context, state) {
          if (state is UpdateListState) {
            context.read<ListBloc>().add(GetListEvent());
            Navigator.pushReplacementNamed(context, AppRoutes.lists);
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: BlocBuilder<ListBloc, ListState>(
            builder: (context, state) {
              final bloc = context.read<ListBloc>();
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                  Container(
                    padding: const EdgeInsets.only(left: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(11),
                      border: Border.all(color: AppColors.grey200, width: 1),
                      color: AppColors.listColor,
                    ),
                    child: TextField(
                      controller: controller,
                      style: AppTextStyles.listsNameText.copyWith(
                        fontWeight: FontWeight.w400,
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: widget.listModel.name,
                        hintStyle: AppTextStyles.listsNameText.copyWith(
                          fontWeight: FontWeight.w400,
                        ),
                        suffixIcon: Padding(
                          padding: const EdgeInsets.all(10),
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
                                    ColorPickerWidget(color: bloc.listColor),
                                    TextButton(
                                      onPressed: () {
                                        setState(() {});
                                        Navigator.pop(context);
                                      },
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
                              height: 20,
                              width: 20,
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
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () {
                      bloc.add(
                        UpdateListEvent(
                          index: widget.index,
                          listModel: ListModel(
                            name: controller.text.isNotEmpty
                                ? controller.text
                                : widget.listModel.name,
                            color: bloc.listColor,
                          ),
                          key: widget.listModel.key ?? '',
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 15,
                      ),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppColors.blue,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Text(
                        "Update list",
                        style: AppTextStyles.listText.copyWith(
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 35),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
