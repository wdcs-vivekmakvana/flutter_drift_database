import 'dart:convert';
import 'dart:developer';

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
                dmDbList.add(DmDbModel.fromJson(element as Map<String, dynamic>));
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
 {"message_id": "1", "from_user": "12", "message_type": 0,"updated_at": "","to_user":"1","parent_id":"","message":"Hey","channel_id":"dm_12_1","reply":null},
      {"message_id": "2", "from_user": "12", "message_type": 0,"updated_at": "","to_user":"1","parent_id":"","message":"Hey2","channel_id":"dm_12_1","reply":null},
      {"message_id": "3", "from_user": "12", "message_type": 0,"updated_at": "","to_user":"1","parent_id":"","message":"Hey3","channel_id":"dm_12_1","reply":null},
      {"message_id": "4", "from_user": "12", "message_type": 0,"updated_at": "","to_user":"1","parent_id":"","message":"Hey4","channel_id":"dm_12_1","reply":null},
      {"message_id": "5", "from_user": "12", "message_type": 0,"updated_at": "","to_user":"1","parent_id":"","message":"Hey5","channel_id":"dm_12_1","reply":null},
      {"message_id": "6", "from_user": "12", "message_type": 0,"updated_at": "","to_user":"1","parent_id":"","message":"Hey6","channel_id":"dm_12_1","reply":null},
      {"message_id": "7", "from_user": "12", "message_type": 0,"updated_at": "","to_user":"1","parent_id":"","message":"Hey7","channel_id":"dm_12_1","reply":null}
]''';
