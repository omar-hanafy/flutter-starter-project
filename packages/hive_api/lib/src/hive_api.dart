import 'dart:developer';

import 'package:hive_flutter/hive_flutter.dart';

class HiveApiClient {
  HiveApiClient({String? boxName}) : _boxName = boxName ?? "hiveBox";

  final String _boxName;
  late final Box _hiveBox = Hive.box(_boxName);

  Future<void> addToHive({required dynamic value, key}) async {
    if (!_hiveBox.isOpen) {
      await Hive.openBox(_boxName);
    }
    if (await isKeyExist(key)) {
      throw Exception('Already exist in the hive table');
    } else {
      _hiveBox.put(key, value);
    }
  }

  Future<void> updateHive({required dynamic value, required key}) async {
    if (!_hiveBox.isOpen) {
      await Hive.openBox(_boxName);
    }
    log("updateHive: value: $value");
    await Hive.openBox(_boxName);
    if (_hiveBox.containsKey(key)) {
      _hiveBox.put(key, value);
    } else {
      throw Exception('key not exist in the hive table');
    }
  }

  Future<void> addToHiveAutoIndex({required dynamic object}) async {
    try {
      await Hive.openBox(_boxName);
      _hiveBox.add(object);
    } catch (e) {
      log("addToHiveAutoIndex => exception: $e");
    }
  }

  deleteHiveValue({required key}) async {
    try {
      await Hive.openBox(_boxName);
      _hiveBox.delete(key);
    } catch (e) {
      log("deleteHiveValue => exception: $e");
    }
  }

  Future<void> deleteHiveBox() async {
    try {
      Hive.deleteBoxFromDisk(_boxName);
    } catch (e) {
      log("clearHiveBox => exception: $e");
    }
  }

  Future<List<dynamic>> getValues() async {
    await Hive.openBox(_boxName);
    return _hiveBox.values.toList();
  }

  getSingleValue(dynamic key) async {
    await Hive.openBox(_boxName);
    return _hiveBox.get(key);
  }

  Future<bool> isKeyExist(key) async {
    await Hive.openBox(_boxName);
    return _hiveBox.containsKey(key);
  }
}
