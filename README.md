# flutter_local_data_base_drift

A new Flutter project for demonstration of DRIFT local database

## Get started

1. first we have to add below plugins in dependencies 

```dart
dart pub add drift drift_flutter dev:drift_dev dev:build_runner
```

2. Second we have to add Table in Our project

```dart
@DataClassName('Todo')
class TodoTable extends Table with TableMixin {
  /// Item Title
  TextColumn get title => text().withLength(min: 4, max: 32)();

  /// Item Content
  TextColumn get content => text().named('body')();

  /// Item Status
  IntColumn get status => intEnum<TodoEnum>()();

  ///
  TextColumn get listTest => text().map(ModelListTypeConverter()).nullable()();
}

/// List of model converter
class ModelListTypeConverter extends TypeConverter<List<TestModel>, String> {
  @override
  List<TestModel> fromSql(String fromDb) {
    if (jsonDecode(fromDb) is List<dynamic>) {
      final result = <TestModel>[];
      for (final element in (jsonDecode(fromDb) as List<dynamic>)) {
        result.add(TestModel.fromJson(element as Map<String, dynamic>));
      }
      return result;
    }

    return List<TestModel>.empty();
  }

  @override
  String toSql(List<TestModel> value) {
    return jsonEncode(value.map((e) => e.toJson()).toList());
  }
}
```

where DataClassName is not required but If you don't put it, It will reflect on 
```dart
todoTable.all().get()
```
and return type will be T, If we define DataClassName then return type will be defined className[Todo].

NOTE: DataClassName's name is not same as Table name otherwise return type will be T

3. After that need to create Database Class with Empty body for code generation purposes
```dart
@DriftDatabase(tables: [TodoTable])
class AppDatabase extends _$AppDatabase {
  } 
```

it will generate file_name.g.dart file in working directory.
4. After that we need to setup database
```dart
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
```

