// Ignore
// ignore_for_file: public_member_api_docs

import 'package:drift/drift.dart';
import 'package:flutter_local_data_base_drift/data_base/data_base.dart';

class DmRepo {
  DmRepo({required this.instance});
  final AppDatabase instance;
  late final dmTable = instance.dmDbTable;
  late final dmManager = instance.managers.dmDbTable;

  Future<List<DmDbModel>> getAllDms() async {
    return dmTable.all().get();
  }

  Future<void> addMessage(DmDbModel model) async {
    await dmTable.insertOne(model.toCompanion(true));
  }
}
