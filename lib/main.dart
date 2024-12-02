import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:server_communication/direct_call/direct_with_api/direct_list.dart';
import 'package:server_communication/direct_call/direct_with_api/loginpage.dart';
import 'package:server_communication/reg.dart';
import 'package:server_communication/test.dart';

// void main() {
//   runApp(const MyApp());
// }
void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => CounterModel(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: 
      //RegistrationScreen(),
      //DirectListExample(),
      CounterScreen(),
    );
  }
}

