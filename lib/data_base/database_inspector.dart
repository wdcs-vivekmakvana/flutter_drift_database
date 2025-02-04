import 'package:drift_local_storage_inspector/drift_local_storage_inspector.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_data_base_drift/data_base/data_base.dart';
import 'package:flutter_local_data_base_drift/injector/injector.dart';
import 'package:storage_inspector/storage_inspector.dart';

/// A class for inspecting and managing the local database.
class DatabaseInspector {
  /// Storage Server Driver
  late final StorageServerDriver driver;

  /// Initializes the database inspector and starts the storage server driver.
  ///
  /// This method creates a [DriftSQLDatabaseServer] instance using the provided
  /// [AppDatabase] instance and adds it to a [StorageServerDriver]. The driver
  /// is then started to enable inspection of the database.
  Future<void> init() async {
    final sqlServer = DriftSQLDatabaseServer(
      id: '1',
      name: 'SQL server', // Database name and Shown in inspector
      database: Injector.instance<AppDatabase>(),
    );
    driver = StorageServerDriver(
      bundleId: 'com.example.flutter_local_data_base_drift', // App bundle ID
    )..addSQLServer(sqlServer);

    await _startService();
  }

  Future<void> _startService() async {
    if (kDebugMode) await driver.start();
  }

  /// Stops the storage server driver.
  Future<void> stopService() async {
    if (kDebugMode) await driver.stop();
  }
}
