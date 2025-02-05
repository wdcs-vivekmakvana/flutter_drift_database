import 'package:envied/envied.dart';
import 'package:flutter_local_data_base_drift/env/env_app.dart';

part 'env_prod.g.dart';

/// Dev Env
@Envied(name: 'Env', path: '.env.prod', obfuscate: false)
class EnvProd implements AppEnv {
  /// constructor
  EnvProd();

  /// Name
  @EnviedField(varName: 'NAME')
  static const String name = _Env.name;

  /// File
  @EnviedField(varName: 'FILE')
  static const String file = _Env.file;
}
