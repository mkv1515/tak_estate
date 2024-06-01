import 'package:flutter_secure_storage/flutter_secure_storage.dart';

AndroidOptions _getAndroidOptions() => const AndroidOptions(
      encryptedSharedPreferences: true,
    );
final storage = FlutterSecureStorage(aOptions: _getAndroidOptions());

// Write value
void storeValue({required String valueName, required String value}) async {
  await storage.write(key: valueName, value: value);
}

// Read value
Future<String?> readValue(String valueName) async {
  return await storage.read(key: valueName);
}

// Delete single value
void deleteSingleValue(String valueName) async {
  await storage.delete(key: valueName);
}

// Delete all
void deleteAllValue() async {
  await storage.deleteAll();
}
