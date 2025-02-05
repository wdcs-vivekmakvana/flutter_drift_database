// Ignore
// ignore_for_file: public_member_api_docs

import 'package:drift/drift.dart';
import 'package:flutter_local_data_base_drift/data_base/data_base.dart';
import 'package:flutter_local_data_base_drift/data_base/dm_db_model/dm_db_model.dart';
import 'package:flutter_local_data_base_drift/data_base/dm_db_model/dm_db_table.dart';

class DmRepo {
  DmRepo({required this.instance});
  final AppDatabase instance;
  late final dmTable = instance.dmDbTable;
  late final dmManager = instance.managers.dmDbTable;

  Future<List<DmDbTable>> getAllDms() async {
    return dmTable.all().get();
  }

  Future<void> addTodo(CustomDmTableCompanion companion) async {
    await dmTable.insertOne(companion);
  }
}
