import 'package:envied/envied.dart';
import 'package:flutter_local_data_base_drift/env/env_app.dart';

part 'env_dev.g.dart';

/// Dev Env
@Envied(name: 'Env', path: '.env.dev', obfuscate: false)
class EnvDev implements AppEnv {
  /// constructor
  EnvDev();

  /// Name
  @EnviedField(varName: 'NAME')
  static const String name = _Env.name;

  /// Name
  @EnviedField(varName: 'FILE')
  static const String file = _Env.file;
}
