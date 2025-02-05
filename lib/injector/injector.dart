import 'package:flutter_local_data_base_drift/data_base/data_base.dart';
import 'package:flutter_local_data_base_drift/data_base/database_inspector.dart';
import 'package:flutter_local_data_base_drift/data_base/dm_db_model/dm_repo.dart';
import 'package:flutter_local_data_base_drift/data_base/tables/todo_repo.dart';
import 'package:get_it/get_it.dart';

/// A class responsible for managing and injecting dependencies using GetIt.
class Injector {
  const Injector._();

  static final _injector = GetIt.instance;

  /// GetIt Instance
  ///
  /// Returns the singleton instance of GetIt.
  static GetIt get instance => _injector;

  /// Initializes the modules for dependency injection.
  static void initModules() {
    _databaseInject(instance);
    _servicesInject(instance);

    Injector.instance.allReady();

    DatabaseInspector().init();
  }

  static void _databaseInject(GetIt injector) {
    injector.registerLazySingleton(AppDatabase.new);
  }

  static void _servicesInject(GetIt injector) {
    injector
      ..registerFactory(() => TodoRepo(instance: instance()))
      ..registerFactory(() => DmRepo(instance: instance()));
  }
}
