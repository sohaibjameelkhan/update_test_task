import 'package:hive/hive.dart';

import '../utils/log_utils.dart';
// This class is responsible for performing operations on a Hive database
class HiveLocalStorage {
  //
  // This function is responsible for opening the specified Hive box
  static Future<Box> openHiveBox(String boxName) async {
    try {
      return await Hive.openBox(boxName);
    } catch (e) {
      dp(msg: "Hive erro", arg: e);
      return Hive.box(boxName);
    }
  }
/// This function is responsible for adding a list of values to a specified box
  static Future addListData({var value, required String boxName}) async {
    try {
      var box = await openHiveBox(boxName);
      await box.add(value);
    } on Error catch (e) {
      dp(msg: "Error in read", arg: e);
    }
  }
/// This function is responsible for reading the values from the specified Hive box
  static Future<List?> getListData(
      {String? key, required String boxName}) async {
    //
    try {
      var box = await openHiveBox(boxName);
      return box.values.toList().cast<String>();
    } on HiveError catch (e) {
      dp(msg: "Error", arg: e);
      return null;
    } catch (e) {
      dp(msg: "Error", arg: e);
      return null;
    }
  }
// This function is responsible for writing the specified value to the specified Hive box
  static Future write({var value, String? key, required String boxName}) async {
    try {
      var box = await openHiveBox(boxName);
      await box.put(key, value);
    } on Error catch (e) {
      dp(msg: "Error in read", arg: e);
    }
  }

  static Future<T?> readHiveValue<T>(
      {String? key, required String boxName}) async {
    try {
      var box = await openHiveBox(boxName);
      return await box.get(key);
    } on HiveError catch (e) {
      dp(msg: "Error", arg: e);
      return null;
    }
  }

  static Future deleteHiveValue({String? key, required String boxName}) async {
    try {
      var box = await openHiveBox(boxName);
      box.delete(key);
    } on HiveError catch (e) {
      dp(msg: "Error in deleteing", arg: e);
    }
  }

  static Future deleateAllValues({required String boxName, tag}) async {
    try {
      var box = await openHiveBox(boxName);
      box.deleteFromDisk();
    } on HiveError catch (e) {
      dp(msg: "Error $tag in deleteing", arg: e);
    } catch (e) {
      dp(msg: "Error $tag in deleteing hive util", arg: e);
    }
  }

  static Future deleteHiveAt({int? key, required String boxName, tag}) async {
    try {
      var box = await openHiveBox(boxName);
      box.deleteAt(key!);
    } on HiveError catch (e) {
      dp(msg: "Error $tag in deleteing", arg: e);
    } catch (e) {
      dp(msg: "Error $tag in deleteing hive util", arg: e);
    }
  }
}
