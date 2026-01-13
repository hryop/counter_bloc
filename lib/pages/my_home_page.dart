import 'package:counter_bloc/bloc/counter_bloc.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final counterBloc = CounterBloc();

  @override
  void dispose() {
    counterBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: StreamBuilder(
        stream: counterBloc.counterStream,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          return Center(
            child: Column(
              mainAxisAlignment: .center,
              children: [
                const Text('You have pushed the button this many times:'),
                Text(
                  '${snapshot.data}',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FAButton(),
    );
  }

  Widget FAButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        FloatingActionButton(
          onPressed: () {
            counterBloc.eventSink.add(CounterEvent.Decrement);
          },
          tooltip: 'Decrement',
          child: Icon(Icons.remove),
        ),
        SizedBox(width: 8),
        FloatingActionButton(
          onPressed: () {
            counterBloc.eventSink.add(CounterEvent.Increment);
          },
          tooltip: 'Increment',
          child: Icon(Icons.add),
        ),
      ],
    );
  }
}
