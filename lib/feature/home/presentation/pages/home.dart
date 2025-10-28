import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_notes/core/app_colors/app_colors.dart';
import 'package:todo_notes/feature/home/data/models/task_model.dart';
import 'package:todo_notes/feature/home/presentation/bloc/home_bloc.dart';
import 'package:todo_notes/feature/home/presentation/widgets/app_bar_task.dart';
import 'package:todo_notes/feature/home/presentation/widgets/backdrop_filter_widget.dart';
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
  late Animation<double> _fadeAnimation;
  Map<String, List<TaskModel>> groupedByType = {};

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(-1, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));

    _fadeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
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
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppBarTask(),
                      const SizedBox(height: 20),
                      const TasksBuilderWidget(),
                      Padding(
                        padding: EdgeInsets.only(
                          bottom: 10,
                          top: 10,
                          left: 20,
                          right: 20,
                        ),
                        child: Divider(
                          height: 1,
                          color: Colors.grey.shade300,
                          indent: 30,
                          endIndent: 0,
                        ),
                      ),
                      const ListsBuilderWidget(),
                      const SizedBox(height: 120),
                    ],
                  ),
                ),
                if (_isOpened)
                  BackdropFilterWidget(fadeAnimation: _fadeAnimation),
                Align(
                  alignment: const Alignment(0.9, 0.85),
                  child: AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      if (_controller.value == 0 && !_isOpened) {
                        return const SizedBox.shrink();
                      }
                      return FadeTransition(
                        opacity: _fadeAnimation,
                        child: ListAndTaskWidget(
                          position: _slideAnimation,
                          onTap: _toggle,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: AnimatedRotation(
        turns: _isOpened ? 0.125 : 0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutBack,
        child: FloatingActionButton(
          backgroundColor: _isOpened ? AppColors.blue : AppColors.white,
          shape: const CircleBorder(),
          onPressed: _toggle,
          child: Icon(
            Icons.add,
            color: _isOpened ? AppColors.white : AppColors.blue,
          ),
        ),
      ),
    );
  }
}
