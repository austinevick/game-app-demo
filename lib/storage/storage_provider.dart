import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final sessionProvider = FutureProvider((ref) => ref.watch(storageProvider));

final storageProvider = Provider((ref) => StorageProvider.getUserToken());

class StorageProvider {
  static const secure = FlutterSecureStorage(
      aOptions: AndroidOptions(encryptedSharedPreferences: true));

  static void saveUserToken(String value) async =>
      await secure.write(key: 'token', value: value);

  static Future<String?> getUserToken() async =>
      await secure.read(key: 'token');

  static void saveUserId(String value) async =>
      await secure.write(key: 'id', value: value);

  static Future<String?> getUserId() async => await secure.read(key: 'id');
}
