import 'package:flutter_local_data_base_drift/env/env_dev.dart';
import 'package:flutter_local_data_base_drift/env/env_prod.dart';
import 'package:flutter_local_data_base_drift/env/env_type.dart';

/// abstract AppEnv class that will decided runtime
abstract class AppEnv {
  /// constructor
  factory AppEnv() => _instance;

  static final AppEnv _instance = envInstance;

  /// instance getter
  static AppEnv envInstance = switch (currentEnv) {
    EnvTypes.dev => EnvDev(),
    EnvTypes.production => EnvProd(),
  };
}
