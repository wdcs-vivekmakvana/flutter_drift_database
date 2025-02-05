import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_local_data_base_drift/add_todo_page.dart';
import 'package:flutter_local_data_base_drift/data_base/data_base.dart';
import 'package:flutter_local_data_base_drift/data_base/tables/todo_repo.dart';
import 'package:flutter_local_data_base_drift/injector/injector.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Injector.initModules();
  runApp(const MyApp());
}

/// Entry point of the application.
class MyApp extends StatelessWidget {
  /// Default constructor.
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Drift App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

/// Home page
class MyHomePage extends StatefulWidget {
  /// Default constructor.
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final todoRepo = Injector.instance<TodoRepo>();

  final List<Todo> todos = List.empty(growable: true);
  Ordering order = Ordering.asc;

  @override
  void initState() {
    super.initState();
    _getTodos();
  }

  Future<void> _getTodos() async {
    todos
      ..clear()
      ..addAll(await todoRepo.getAllTodos());
    setState(() {});
  }

  void _addTodo() {
    Navigator.of(context)
        .push(
      MaterialPageRoute<bool?>(builder: (context) => const AddTodoPage()),
    )
        .then((value) async {
      if (value != null && value) {
        await _getTodos();
      }
    });
  }

  Future<void> _filterList() async {
    todos
      ..clear()
      ..addAll(await todoRepo.getTodosByOrdering(order));
    setState(() {});

    if (order == Ordering.desc) {
      order = Ordering.asc;
    } else {
      order = Ordering.desc;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Drift App'),
        actions: [
          IconButton(
            onPressed: _filterList,
            icon: const Icon(Icons.filter_list),
          ),
        ],
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('${todos[index].id} : ${todos[index].title}'),
            subtitle: Text('${todos[index].content} ${todos[index].createdAt}'),
            trailing: Text(todos[index].status.toString()),
            onTap: () {
              Navigator.of(context)
                  .push(
                MaterialPageRoute<bool?>(
                  builder: (context) => AddTodoPage(todo: todos[index]),
                ),
              )
                  .then((value) async {
                if (value != null && value) {
                  await _getTodos();
                }
              });
            },
          );
        },
        itemCount: todos.length,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTodo,
        tooltip: 'add todo-item',
        child: const Icon(Icons.add),
      ),
    );
  }
}
