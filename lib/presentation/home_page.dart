import 'package:bloc_tutorial_one/constants/enums.dart';
import 'package:bloc_tutorial_one/logic/cubit/internet_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../logic/cubit/counter_cubit.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            BlocBuilder<InternetCubit, InternetState>(
              builder: (context, state) {
                if(state is InternetConnected && state.connectionType == ConnectionType.Wifi){
                  return Text(
                    'Wifi Connection',
                    style: Theme.of(context).textTheme.headlineMedium,
                  );
                } else if(state is InternetConnected && state.connectionType == ConnectionType.Wifi){
                  return Text(
                    'Mobile Connection',
                    style: Theme.of(context).textTheme.headlineMedium,
                  );
                } else if(state is InternetDisconnected){
                  return Text(
                    'Disconnected',
                    style: Theme.of(context).textTheme.headlineMedium,
                  );
                }else{
                  return CircularProgressIndicator();
                }
              },
            ),
            BlocConsumer<CounterCubit, CounterState>(
              builder: (context, state) {
                return Text(
                  state.counterValue.toString(),
                  style: Theme.of(context).textTheme.headlineMedium,
                );
              },
              listener: (context, state) {
                if (state.wasIncremented) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('incremented'),
                      duration: Duration(milliseconds: 500),
                    ),
                  );
                } else if (!state.wasIncremented) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('decremented'),
                      duration: Duration(milliseconds: 500),
                    ),
                  );
                }
              },
            ),
            // Row(
            //   mainAxisSize: MainAxisSize.max,
            //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //   children: [
            //     FloatingActionButton(
            //       onPressed: () {
            //         BlocProvider.of<CounterCubit>(context).decrement();
            //       },
            //       tooltip: 'Decrement',
            //       child: const Icon(Icons.remove),
            //     ),
            //     FloatingActionButton(
            //       onPressed: () {
            //         BlocProvider.of<CounterCubit>(context).increment();
            //       },
            //       tooltip: 'Increment',
            //       child: const Icon(Icons.add),
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
