import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:flutter_local_data_base_drift/data_base/tables/todo_table.dart';

part 'data_base.g.dart';

/// App Database
@DriftDatabase(tables: [TodoTable])
class AppDatabase extends _$AppDatabase {
  /// Constructor for the AppDatabase class.
  ///
  /// Initializes the database by calling the super constructor with the result of [_openConnection()].
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  /// Open a connection to the database.
  ///
  /// This function uses the `driftDatabase` function from the `drift` package to create a connection to the database.
  /// The database name is set to 'my_database' and the native options are provided using `DriftNativeOptions()`.
  ///
  /// Returns: A [QueryExecutor] instance representing the database connection.
  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'my_database',
      native: const DriftNativeOptions(),
    );
  }
}

/// Ordering enumeration
enum Ordering {
  /// Ascending order
  asc,

  /// Descending order
  desc
}
