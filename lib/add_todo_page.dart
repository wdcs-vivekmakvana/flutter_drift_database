import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:flutter_local_data_base_drift/data_base/data_base.dart';
import 'package:flutter_local_data_base_drift/data_base/tables/todo_repo.dart';
import 'package:flutter_local_data_base_drift/data_base/tables/todo_table.dart';
import 'package:flutter_local_data_base_drift/injector/injector.dart';

/// For add TOD0 in Database
class AddTodoPage extends StatefulWidget {
  /// Default constructor
  const AddTodoPage({super.key, this.todo});

  /// for Update tod0 Item
  final Todo? todo;

  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final database = Injector.instance<TodoRepo>();

  @override
  void initState() {
    super.initState();

    if (widget.todo == null) return;
    _titleController.text = widget.todo!.title;
    _contentController.text = widget.todo!.content;
  }

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
    _contentController.dispose();
  }

  Future<void> _addTodo() async {
    if (_titleController.text == '' || _contentController.text == '') return;
    try {
      if (widget.todo == null) {
        await database.addTodo(
          TodoTableCompanion(
            title: drift.Value(_titleController.text),
            content: drift.Value(_contentController.text),
            status: const drift.Value(TodoEnum.Completed),
            listTest: drift.Value(
              [
                TestModel('name', 1, ['Tennis']),
              ],
            ),
          ),
        );
      } else {
        database.updateTodo(
          TodoTableCompanion(
            title: drift.Value(_titleController.text),
            content: drift.Value(_contentController.text),
            status: const drift.Value(TodoEnum.Pending),
            /*listTest: drift.Value(
              [
                TestModel('name', 1, ['cricket']),
                TestModel('name', 1, ['cricket']),
              ],
            ),*/
          ),
          id: widget.todo!.id,
        );
      }

      // Navigate back to the main page
      if (mounted) Navigator.pop(context, true);
    } on drift.InvalidDataException catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.message)),
        );
      }
    } on Exception catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Todo'),
      ),
      body: Column(
        children: [
          TextField(controller: _titleController),
          TextField(controller: _contentController),
          ElevatedButton(
            onPressed: _addTodo,
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }
}
