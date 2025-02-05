import 'dart:convert';
import 'dart:developer';

import 'package:drift/drift.dart';
import 'package:flutter_local_data_base_drift/data_base/dm_db_model/message_type.dart';
import 'package:flutter_local_data_base_drift/data_base/table_mixin.dart';

///
class ReplyModel {
  /// constructor
  ReplyModel();

  ///
  factory ReplyModel.fromJson(Map<String, dynamic> json) {
    log('json : $json');
    return ReplyModel();
  }

  ///
  Map<String, dynamic> toJson() {
    return {};
  }
}

///
@UseRowClass(DmDbTable)
class DmDbTable extends Table with TableMixin {
  /// Message Id
  TextColumn get messageId => text().named('message_id')();

  /// From User
  TextColumn get fromUserId => text().named('from_user')();

  /// Message Type
  IntColumn get messageType =>
      intEnum<MessagesType>().named('message_type').clientDefault(() => MessagesType.image.index)();

  /// Updated At
  DateTimeColumn get updateAt => dateTime().named('updated_at').withDefault(currentDateAndTime)();

  /// to user
  TextColumn get toUserId => text().named('to_user')();

  /// parent id
  TextColumn get parentId => text().named('parent_id')();

  /// message
  TextColumn get message => text().named('message')();

  /// channel id
  TextColumn get channelId => text().named('channel_id')();

  ///
  TextColumn get reply => text().named('reply').map(ModelTypeConverter()).nullable()();

  @override
  String get tableName => 'DmTable';
}

///
class ModelTypeConverter extends TypeConverter<ReplyModel, String> {
  @override
  ReplyModel fromSql(String fromDb) {
    if (jsonDecode(fromDb) is Map<String, dynamic>) {
      return ReplyModel.fromJson(jsonDecode(fromDb) as Map<String, dynamic>);
    }

    return ReplyModel();
  }

  @override
  String toSql(ReplyModel value) {
    return jsonEncode(value.toJson());
  }
}
