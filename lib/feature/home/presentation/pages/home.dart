import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:todo_notes/core/app_colors/app_colors.dart';
import 'package:todo_notes/core/app_text_styles/app_text_styles.dart';
import 'package:todo_notes/core/hive_box/hive_box.dart';
import 'package:todo_notes/feature/home/presentation/bloc/home_bloc.dart';
import 'package:todo_notes/feature/home/presentation/widgets/list_and_task_widget.dart';
import 'package:todo_notes/feature/home/presentation/widgets/tasks_builder_widget.dart';
import 'package:todo_notes/feature/home/presentation/widgets/lists_builder_widget.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  bool _isOpened = false;
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    );

    _slideAnimation = Tween<Offset>(
      begin: Offset(0, 5), // pastdan chiqadi
      end: Offset(0, 0.0),
    ).animate(CurvedAnimation(parent: _controller, curve: Easing.standard));
  }

  @override
  void dispose() {
    Hive.box(HiveBoxes.taskBox).close();
    _controller.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() {
      _isOpened = !_isOpened;
      if (_isOpened) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: BlocConsumer<HomeBloc, HomeState>(
        listener: (_, state) {
          if (state is HomeLoading) {
            Center(child: CircularProgressIndicator());
          }
          if (state is HomeError) {
            Center(child: Text('Xatolik: ${state.message}'));
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: Stack(
              children: [
                SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        title: Text("Today", style: AppTextStyles.homeText),
                        trailing: InkWell(
                          onTap: () {},
                          child: Icon(
                            Icons.more_horiz,
                            size: 24,
                            color: AppColors.blue,
                          ),
                        ),
                        leading: SizedBox(width: 28, height: 28),
                      ),
                      SizedBox(height: 20),
                      TasksBuilderWidget(),
                      ListsBuilderWidget(),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
                _isOpened
                    ? BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 1.5, sigmaY: 1.5),
                        child: Container(
                          decoration: BoxDecoration(
                            // ignore: deprecated_member_use
                            color: Colors.white.withOpacity(0.2),
                          ),
                        ),
                      )
                    : SizedBox.shrink(),

                Positioned(
                  right: 20,
                  bottom: 85,
                  child: ListAndTaskWidget(position: _slideAnimation),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        backgroundColor: _isOpened ? AppColors.blue : AppColors.white,
        onPressed: _toggle,
        child: AnimatedRotation(
          turns: _isOpened ? 0.125 : 0,
          duration: Duration(milliseconds: 300),
          child: Icon(
            Icons.add,
            color: _isOpened ? AppColors.white : AppColors.blue,
          ),
        ),
      ),
    );
  }
}
