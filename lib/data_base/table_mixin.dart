import 'package:drift/drift.dart';

/// A mixin that provides common fields for database tables.
///
/// This mixin includes two fields:
/// - [id]: An auto-incrementing integer primary key.
/// - [createdAt]: A timestamp representing the creation time, defaulted to the current date and time.
mixin TableMixin on Table {
  /// Primary key column
  late final id = integer().autoIncrement()();

  /// Column for created at timestamp
  late final createdAt = dateTime().nullable().withDefault(currentDateAndTime)();
}
