import 'dart:convert';
import 'dart:developer';

import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:flutter_local_data_base_drift/data_base/data_base.dart';
import 'package:flutter_local_data_base_drift/data_base/dm_db_model/dm_repo.dart';
import 'package:flutter_local_data_base_drift/injector/injector.dart';

/// Dm Screen
class DmScreen extends StatefulWidget {
  /// Default constructor
  const DmScreen({super.key});

  @override
  State<DmScreen> createState() => _DmScreenState();
}

class _DmScreenState extends State<DmScreen> {
  @override
  void initState() {
    super.initState();
  }

  final dmRepo = Injector.instance<DmRepo>();

  void _getData() {
    dmRepo.getAllDms().then(
          (value) => log('message : $value'),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dm Screen'),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              final jsonList = jsonDecode(dmJson) as List<dynamic>;

              final dmDbList = <DmDbModel>[];
              for (final element in jsonList) {
                dmDbList.add(
                  DmDbModel.fromJson(element as Map<String, dynamic>, serializer: const CustomSerializer()),
                );
              }

              dmRepo.instance.transaction(() async {
                for (final dmColumn in dmDbList) {
                  await dmRepo.addMessage(dmColumn);
                }
              });

              _getData();
            },
            child: const Text('Parse data from JSON'),
          ),
          ElevatedButton(
            onPressed: () {},
            child: const Text('Add Local data'),
          ),
        ],
      ),
    );
  }
}

/// Dm Json
const String dmJson = '''
[     
 {"message_id": "8", "from_user": "14", "message_type": 0,"updated_at": "","to_user":"2","parent_id":"","message":"Hey 8","channel_id":"dm_14_2","reply":null},
      {"message_id": "9", "from_user": "14", "message_type": 0,"updated_at": "","to_user":"2","parent_id":"","message":"Hey 9","channel_id":"dm_14_2","reply":null},
      {"message_id": "10", "from_user": "14", "message_type": 0,"updated_at": "","to_user":"2","parent_id":"","message":"Hey 10","channel_id":"dm_14_2","reply":null},
      {"message_id": "11", "from_user": "14", "message_type": 0,"updated_at": "","to_user":"2","parent_id":"","message":"Hey 11","channel_id":"dm_14_2","reply":null},
      {"message_id": "12", "from_user": "14", "message_type": 0,"updated_at": "","to_user":"2","parent_id":"","message":"Hey 12","channel_id":"dm_14_2","reply":null},
      {"message_id": "13", "from_user": "14", "message_type": 0,"updated_at": "","to_user":"2","parent_id":"","message":"Hey 13","channel_id":"dm_14_2","reply":null},
      {"message_id": "14", "from_user": "14", "message_type": 0,"updated_at": "","to_user":"2","parent_id":"","message":"Hey 14","channel_id":"dm_14_2","reply":null}
]''';

/// Custom serializer
class CustomSerializer extends drift.ValueSerializer {
  /// Default constructor
  const CustomSerializer();

  @override
  T fromJson<T>(dynamic json) {
    if (json == null) {
      if (T == int) {
        return DateTime.now().microsecond as T;
      } else if (T == String) {
        return '' as T;
      } else if (T == DateTime) {
        return DateTime.now() as T;
      } else if (T == bool) {
        return false as T;
      } else if (T == List<T>) {
        return <T>[] as T;
      } else if (T == double) {
        return 0.0 as T;
      }
    }

    if (T == DateTime) {
      return DateTime.now() as T;
    }

    if (T == double && json is int) {
      return json.toDouble() as T;
    }

    if (T == drift.Uint8List && json is! drift.Uint8List) {
      final asList = (json as List).cast<int>();
      return drift.Uint8List.fromList(asList) as T;
    }

    return json as T;
  }

  @override
  T toJson<T>(T value) => value;
}
