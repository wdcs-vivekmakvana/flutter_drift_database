import 'package:drift/drift.dart';
import 'package:flutter_local_data_base_drift/data_base/data_base.dart';
import 'package:flutter_local_data_base_drift/data_base/tables/todo_table.dart';

/// Repository for managing [TodoTable] data.
class TodoRepo {
  /// Default constructor
  TodoRepo({required this.instance});

  /// Database instance
  final AppDatabase instance;

  /// Table for managing [TodoTable] data.
  late final todoTable = instance.todoTable;

  /// Manager for the TodoTable.
  late final todoManager = instance.managers.todoTable;

  /// Retrieves all [TodoTable] records from the database.
  ///
  /// Returns a [Future] that completes with a list of [TodoTable] objects.
  Future<List<Todo>> getAllTodos() async {
    return todoTable.all().get();
  }

  /// Adds a new [TodoTable] record to the database.
  ///
  /// The [companion] parameter is a [TodoTableCompanion] object that represents the new record to be added.
  ///
  /// Returns a [Future] that completes when the insertion is done.
  Future<void> addTodo(TodoTableCompanion companion) async {
    await todoTable.insertOne(companion);
  }

  /// Get Tod0 Object from id
  ///
  /// Retrieves a single [TodoTable] record from the database based on the provided [id].
  ///
  /// Parameters:
  /// - [id]: The unique identifier of the record to retrieve.
  ///
  /// Returns:
  /// A [Future] that completes with a [TodoTable] object if found, or `null` if no record is found.
  Future<Todo>? getTodoById(int id) {
    return (instance.select(todoTable)..where((a) => a.id.equals(id))).getSingle();
  }

  /// Update Tod0 Object
  ///
  /// Updates an existing [TodoTable] record in the database.
  ///
  /// Parameters:
  /// - [companion]: A [TodoTableCompanion] object that represents the updated record.
  /// - [id]: The unique identifier of the record to update.
  void updateTodo(TodoTableCompanion companion, {required int id}) {
    todoManager.filter((f) => f.id.equals(id)).update(
          (o) => companion.copyWith(createdAt: Value(DateTime.now())),
        );
  }

  ///
  /// This function retrieves all [TodoTable] records from the database and sorts them based on the provided [ordering].
  ///
  /// Parameters:
  /// - [ordering]: An [Ordering] enum that specifies the sorting order. It can be either [Ordering.asc] for ascending order or [Ordering.desc] for descending order.
  ///
  /// Returns:
  /// A [Future] that completes with a list of [TodoTable] objects sorted based on the provided [ordering].
  Future<List<Todo>> getTodosByOrdering(Ordering ordering) async {
    switch (ordering) {
      case Ordering.asc:
        return todoManager.orderBy((o) => o.createdAt.asc()).get();
      case Ordering.desc:
        return todoManager.orderBy((o) => o.createdAt.desc()).get();
    }
  }
}
