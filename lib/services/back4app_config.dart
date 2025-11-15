import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class Back4AppConfig {
  // TODO: Replace these with your actual Back4App credentials
  // Get these from your Back4App dashboard at https://www.back4app.com/
  static const String appId = 'pzHfbqyux9lXznoX0FN5zAWsclyrFTWqiqzggP0l';
  static const String clientKey = 'ufGvfPLNoNJ5bs0JKa1OdQUsdOvDmPi3TvsOaxXC';
  static const String serverUrl = 'https://parseapi.back4app.com';

  static Future<void> initialize() async {
    await Parse().initialize(
      appId,
      serverUrl,
      clientKey: clientKey,
      debug: true,
      autoSendSessionId: true,
      coreStore: await CoreStoreSharedPreferences.getInstance(),
    );
  }
}
