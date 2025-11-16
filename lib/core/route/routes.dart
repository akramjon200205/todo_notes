import 'package:flutter/material.dart';
import 'package:todo_notes/feature/home/presentation/pages/home.dart';
import 'package:todo_notes/feature/list/presentation/pages/add_list.dart';
import 'package:todo_notes/feature/list/presentation/pages/edit_list.dart';
import 'package:todo_notes/feature/list/presentation/pages/list_page.dart';
import 'package:todo_notes/feature/task/presentation/pages/tasks.dart';

class AppRoutes {
  static const String home = '/';
  static const String tasks = '/tasks';
  static const String lists = '/lists';
  static const String addList = '/addList';
  static const String editList = '/editList';
}

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.home:
        return MaterialPageRoute(builder: (_) => Home());
      case AppRoutes.tasks:
        return MaterialPageRoute(builder: (_) => Tasks());
      case AppRoutes.lists:
        return MaterialPageRoute(builder: (_) => ListPage());
      case AppRoutes.addList:
        return MaterialPageRoute(builder: (_) => AddList());
      case AppRoutes.editList:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) =>
              EditList(listModel: args['listModel'], index: args['index']),
        );

      default:
        return MaterialPageRoute(
          builder: (_) =>
              Scaffold(body: Center(child: Text("404: Route not found"))),
        );
    }
  }
}
