import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:flutter_local_data_base_drift/data_base/table_mixin.dart';
import 'package:flutter_local_data_base_drift/data_base/tables/todo_enum.dart';

/// TodoTable
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

  @override
  String get tableName => 'TodoTable';
}

/// A companion class for the [TodoTable] that assists in building insert and update statements.
/// It provides methods to insert new records and update existing ones.
class CustomTodoTableCompanion extends UpdateCompanion<TodoTable> {
  /// Constructs a [CustomTodoTableCompanion] with default values for each field.
  const CustomTodoTableCompanion({
    this.title = const Value.absent(),
    this.content = const Value.absent(),
    this.status = const Value.absent(),
  });

  /// Constructs a [CustomTodoTableCompanion] for inserting a new record into the table.
  ///
  /// Parameters:
  /// - [title]: The title of the Tod0 item. Must not be null.
  /// - [content]: The content of the Tod0 item. Must not be null.
  /// - [status]: The status of the Tod0 item. Must not be null.
  CustomTodoTableCompanion.insert({
    required String title,
    required String content,
    required TodoEnum status,
  })  : title = Value(title),
        content = Value(content),
        status = Value(status);

  /// The title of the Tod0 item.
  final Value<String> title;

  /// The content of the Tod0 item.
  final Value<String> content;

  /// The status of the Tod0 item.
  final Value<TodoEnum> status;

  /// Converts the current instance into a map of column names to their corresponding expressions.
  ///
  /// Parameters:
  /// - [nullToAbsent]: A boolean indicating whether null values should be converted to absent values.
  ///
  /// Returns:
  /// A map of column names to their corresponding expressions.
  @override
  Map<String, Expression<Object>> toColumns(bool nullToAbsent) {
    throw UnimplementedError();
  }

  /// Factory method for creating Model from Json
  /* factory TodoTableCompanion.fromJson(Map<String, dynamic> json) => TodoTableCompanion(
      title: Value(json['title'] as String),
      content: Value(json['content'] as String),
      status: Value(json['status'] as TodoEnum),
  );*/
}

///
class StringListTypeConverter extends TypeConverter<List<String>, String> {
  @override
  List<String> fromSql(String fromDb) {
    return List<String>.from(jsonDecode(fromDb) as List<String>);
  }

  @override
  String toSql(List<String> value) {
    return jsonEncode(value);
  }
}

///
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

///
class TestModel {
  ///
  TestModel(this.name, this.age, this.hobbies);

  /// From JSon
  factory TestModel.fromJson(Map<String, dynamic> json) {
    final hobbies = <String>[];
    if (json['hobbies'] != null && json['hobbies'] is List<dynamic>) {
      for (final e in json['hobbies'] as List<dynamic>) {
        hobbies.add(e as String);
      }
    }
    return TestModel(
      json['name'] as String,
      json['age'] as int,
      hobbies,
    );
  }

  ///
  final String name;

  ///
  final int age;

  ///
  final List<String> hobbies;

  /// To Json
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'age': age,
      'hobbies': hobbies,
    };
  }
}
