import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/Provider/todo_provder.dart';
import 'package:todo_app/home.dart';


void main()=>runApp(
  MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) =>TodoProvder ()),
    ],
    child: const MyApp(),
  ),
);


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {

    return const MaterialApp (
      debugShowCheckedModeBanner: false,
         home: MyToDo(),
    );
  }
}


