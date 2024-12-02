import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Define the CounterModel class
class CounterModel extends ChangeNotifier {
  int _count = 0;

  int get count => _count;

  void increment() {
    _count++;
    notifyListeners();
  }
}



// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Counter App',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: const CounterScreen(),
//     );
//   }
// }

class CounterScreen extends StatelessWidget {
  const CounterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter App'),
      ),
      body: Center(
        child: Consumer<CounterModel>(
          builder: (context, counter, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'You have pushed the button this many times:',
                ),
                Text(
                  '${counter.count}',
                  style: Theme.of(context).textTheme.bodySmall
                ),
              ],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Provider.of<CounterModel>(context, listen: false).increment();
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ));
  }}