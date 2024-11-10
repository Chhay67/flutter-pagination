import 'package:edu_pagination/page/bloc/pagination_bloc_demo_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import 'bloc/data_bloc.dart';
import 'bloc/data_cubit/data_cubit.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => DataCubit(),
        ),
        BlocProvider(
          create: (_) => DataBloc(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PaginationBlocDemoPage(),
    );
  }
}
