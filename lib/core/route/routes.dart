import 'package:flutter/material.dart';
import 'package:todo_notes/feature/home/presentation/pages/home.dart';
import 'package:todo_notes/feature/list/presentation/pages/list_page.dart';
import 'package:todo_notes/feature/task/presentation/pages/tasks.dart';

class AppRoutes {
  static const String home = '/';
  static const String tasks = '/tasks';
  static const String lists = '/lists';
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

      default:
        return MaterialPageRoute(
          builder: (_) =>
              Scaffold(body: Center(child: Text("404: Route not found"))),
        );
    }
  }
}
