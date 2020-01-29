import 'dart:convert';
import 'package:hive/hive.dart';

class Storage {
  Storage();

  Future<void> putJson({String boxName, Map<String, dynamic> json}) async {
    Box box = await Hive.openBox(boxName);
    await box.putAll(json);
    box.close();
    return;
  }

  Future<void> putData(
      {String boxName, String key, Map<String, dynamic> data}) async {
    Box box = await Hive.openBox(boxName);
    final String stringJson = json.encode(data);
    await box.put(key, stringJson);
    box.close();
    return;
  }

  Future<String> getString({String boxName, String key}) async {
    Box box = await Hive.openBox(boxName);
    String value = box.get(key);
    box.close();
    return value;
  }

  Future<DateTime> getDate({String boxName, String key}) async {
    Box box = await Hive.openBox(boxName);
    DateTime date = box.get(key);
    box.close();
    return date;
  }

  Future<int> getInt({String boxName, String key}) async {
    Box box = await Hive.openBox(boxName);
    int value = box.get(key);
    box.close();
    return value;
  }

  Future<double> getDouble({String boxName, String key}) async {
    Box box = await Hive.openBox(boxName);
    double value = box.get(key);
    box.close();
    return value;
  }

  Future<Map<String, dynamic>> getData({String boxName, String key}) async {
    Box box = await Hive.openBox(boxName);
    final String value = box.get(key);
    if (value != null) {
      final Map<String, dynamic> jsonData = await json.decode(value);
      box.close();
      return jsonData;
    }
    return null;
  }

  Future<void> deleteData(String name) async {
    Box box = await Hive.openBox(name);
    await box.deleteFromDisk();
    // box.close();
    return;
  }
}

final storage = Storage();
