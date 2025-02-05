// Ignore
// ignore_for_file: public_member_api_docs

import 'package:drift/drift.dart';
import 'package:flutter_local_data_base_drift/data_base/dm_db_model/dm_db_table.dart';
import 'package:flutter_local_data_base_drift/data_base/dm_db_model/message_type.dart';

/// Dm Db Model
class DmDbModel {
  ///
  DmDbModel({
    required this.messageId,
    required this.fromUserId,
    required this.messageType,
    required this.updateAt,
    required this.toUserId,
    required this.parentId,
    required this.message,
    required this.channelId,
    this.reply,
  });

  ///
  factory DmDbModel.fromJson(Map<String, dynamic> json) {
    return DmDbModel(
      messageId: json['message_id'] as String,
      fromUserId: json['from_user'] as String,
      messageType: json['message_type'] as int,
      updateAt: DateTime.now(),
      toUserId: json['to_user'] as String,
      parentId: json['parent_id'] as String,
      message: json['message'] as String,
      channelId: json['channel_id'] as String,
      reply: json['reply'] != null ? ReplyModel.fromJson(json['reply'] as Map<String, dynamic>) : null,
    );
  }

  final String messageId;
  final String fromUserId;
  final int messageType;
  final DateTime updateAt;
  final String toUserId;
  final String parentId;
  final String message;
  final String channelId;
  final ReplyModel? reply;
}

class CustomDmTableCompanion extends UpdateCompanion<DmDbTable> {
  const CustomDmTableCompanion._({
    this.messageId = const Value.absent(),
    this.fromUserId = const Value.absent(),
    this.messageType = const Value.absent(),
    this.updateAt = const Value.absent(),
    this.toUserId = const Value.absent(),
    this.parentId = const Value.absent(),
    this.message = const Value.absent(),
    this.channelId = const Value.absent(),
    this.reply = const Value.absent(),
  });

  factory CustomDmTableCompanion.insertJson({required Map<String, dynamic> json}) {
    final model = DmDbModel.fromJson(json);
    return CustomDmTableCompanion._(
      fromUserId: Value(model.fromUserId),
      messageId: Value(model.messageId),
      messageType: const Value(MessagesType.image),
      updateAt: Value(model.updateAt),
      toUserId: Value(model.toUserId),
      parentId: Value(model.parentId),
      message: Value(model.message),
      channelId: Value(model.channelId),
      reply: Value(model.reply),
    );
  }

  factory CustomDmTableCompanion.insert({
    required String messageId,
    required String fromUserId,
    required MessagesType messageType,
    required DateTime updateAt,
    required String toUserId,
    required String parentId,
    required String message,
    required String channelId,
    required ReplyModel? reply,
  }) {
    return CustomDmTableCompanion._(
      fromUserId: Value(fromUserId),
      messageId: Value(messageId),
      messageType: Value(messageType),
      updateAt: Value(updateAt),
      toUserId: Value(toUserId),
      parentId: Value(parentId),
      message: Value(message),
      channelId: Value(channelId),
      reply: Value(reply),
    );
  }

  final Value<String> messageId;
  final Value<String> fromUserId;
  final Value<MessagesType> messageType;
  final Value<DateTime> updateAt;
  final Value<String> toUserId;
  final Value<String> parentId;
  final Value<String> message;
  final Value<String> channelId;
  final Value<ReplyModel?> reply;

  @override
  Map<String, Expression<Object>> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['message_id'] = Variable<String>(messageId.value);
    map['from_user'] = Variable<String>(fromUserId.value);
    map['updated_at'] = Variable<DateTime>(updateAt.value);
    map['to_user'] = Variable<String>(toUserId.value);
    map['parent_id'] = Variable<String>(parentId.value);
    map['message'] = Variable<String>(message.value);
    map['channel_id'] = Variable<String>(channelId.value);
    map['message_type'] = Variable<int>(messageType.value.index);
    if (!nullToAbsent || reply.value != null) {
      map['reply'] = Variable<ReplyModel>(reply.value);
    }

    return map;
  }
}
