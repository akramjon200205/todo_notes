import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_notes/core/route/routes.dart';
import 'package:todo_notes/feature/home/presentation/bloc/home_bloc.dart';
import 'package:todo_notes/core/di/dependency_injection.dart' as sl;
import 'package:todo_notes/feature/list/presentation/bloc/list_bloc.dart';

Future<void> main() async {
  await sl.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ListBloc(sl.di())),
        BlocProvider(create: (_) => HomeBloc(sl.di(), sl.di())),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Todo Notes',
        theme: ThemeData(
          primaryColor: Colors.blue,
          scaffoldBackgroundColor: Colors.white,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: AppRoutes.home,
        onGenerateRoute: AppRouter.generateRoute,
      ),
    );
  }
}
