import 'package:bloc_tutorial_one/logic/cubit/internet_cubit.dart';
import 'package:bloc_tutorial_one/presentation/home_page.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'logic/cubit/counter_cubit.dart';

void main() {
  final connectivity = Connectivity();
  runApp(MyApp(
    connectivity: connectivity,
  ));
}

class MyApp extends StatefulWidget {
  final Connectivity connectivity;
  const MyApp({
    required this.connectivity,
    super.key,
  });

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.


  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<InternetCubit>(
          create: (context) => InternetCubit(connectivity: widget.connectivity),
        ),
        BlocProvider<CounterCubit>(
          create: (context) => CounterCubit(
              internetCubit: BlocProvider.of<InternetCubit>(context)),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'BLoC Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const MyHomePage(),
      ),
    );
  }

  @override
  void dispose() {
    BlocProvider.of<InternetCubit>(context).close();
    BlocProvider.of<CounterCubit>(context).close();
    super.dispose();
  }
}
