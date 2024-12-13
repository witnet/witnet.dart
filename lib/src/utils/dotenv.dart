import 'package:dotenv/dotenv.dart';

class DotEnvUtil {
  DotEnv? env;
  static final DotEnvUtil _singleton = DotEnvUtil._internal();
  factory DotEnvUtil() {
    if (_singleton.env == null) {
      _singleton.env = DotEnv(includePlatformEnvironment: true)..load();
    }
    return _singleton;
  }

  DotEnvUtil._internal();

  bool get testnet => get('ENVIRONMENT') != 'testnet' ? false : true;

  String? get(String key) {
    if (env != null) {
      if (env!.isDefined(key)) {
        return env![key];
      }
    }
    return null;
  }
}
