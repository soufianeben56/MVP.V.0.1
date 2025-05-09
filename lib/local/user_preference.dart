import 'package:infinity_circuit/exports.dart';
import 'package:synchronized/synchronized.dart' as sync;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/network/response_models/bluetooth_service_response.dart';

class UserPreference {
  static UserPreference? _singleton;
  static SharedPreferences? _prefs;
  static final sync.Lock _lock = sync.Lock();

  static const String _fixedEmail = "yazid@gmail.com";
  static const String _fixedPassword = "Yazidox";

  static Future<void> initializeDefaultCredentials() async {
    await getInstance();
    String? currentEmail = getString(PrefKeys.email);
    String? currentPassword = getString(PrefKeys.password);

    if (currentEmail == null || currentEmail.isEmpty) {
      await putString(PrefKeys.email, _fixedEmail);
    }

    if (currentPassword == null || currentPassword.isEmpty) {
      await putString(PrefKeys.password, _fixedPassword);
    }
  }

  static Future<UserPreference?> getInstance() async {
    if (_singleton == null) {
      await _lock.synchronized(() async {
        if (_singleton == null) {
          var singleton = UserPreference._();
          await singleton._init();
          _singleton = singleton;
        }
      });
    }
    return _singleton;
  }

  UserPreference._();

  Future _init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Future<void> logout() async {
    await remove(PrefKeys.isLogin);
    await initializeDefaultCredentials();
  }

  static String getFixedEmail() {
    return _fixedEmail;
  }

  static String getFixedPassword() {
    return _fixedPassword;
  }

  static Future<bool>? putObject(String key, Object value) {
    return _prefs?.setString(key, json.encode(value));
  }

  static T? getObj<T>(String key, T Function(Map v) f, {T? defValue}) {
    Map? map = getObject(key);
    return map == null ? defValue : f(map);
  }

  static Map? getObject(String key) {
    String? data = _prefs?.getString(key);
    return (data == null || data.isEmpty) ? null : json.decode(data);
  }

  static Future<bool>? putObjectList(String key, List<Object> list) {
    List<String>? dataList = list.map((value) => json.encode(value)).toList();
    return _prefs?.setStringList(key, dataList);
  }

  static List<T>? getObjList<T>(String key, T Function(Map v) f, {List<T>? defValue = const []}) {
    List<Map>? dataList = getObjectList(key);
    List<T>? list = dataList?.map((value) => f(value)).toList();
    return list ?? defValue;
  }

  static List<Map>? getObjectList(String key) {
    List<String>? dataLis = _prefs?.getStringList(key);
    return dataLis?.map((value) => json.decode(value) as Map<dynamic, dynamic>).toList();
  }

  static String? getString(String key, {String? defValue = ''}) {
    return _prefs?.getString(key) ?? defValue;
  }

  static Future<bool>? putString(String key, String value) {
    return _prefs?.setString(key, value);
  }

  static bool? getBool(String key, {bool? defValue = false}) {
    return _prefs?.getBool(key) ?? defValue;
  }

  static Future<bool>? putBool(String key, bool value) {
    return _prefs?.setBool(key, value);
  }

  static int? getInt(String key, {int? defValue = 0}) {
    return _prefs?.getInt(key) ?? defValue;
  }

  static Future<bool>? putInt(String key, int value) {
    return _prefs?.setInt(key, value);
  }

  static double? getDouble(String key, {double? defValue = 0.0}) {
    return _prefs?.getDouble(key) ?? defValue;
  }

  static Future<bool>? putDouble(String key, double value) {
    return _prefs?.setDouble(key, value);
  }

  static List<String>? getStringList(String key, {List<String>? defValue = const []}) {
    return _prefs?.getStringList(key) ?? defValue;
  }

  static Future<bool>? putStringList(String key, List<String> value) {
    return _prefs?.setStringList(key, value);
  }

  static dynamic getDynamic(String key, {Object? defValue}) {
    return _prefs?.get(key) ?? defValue;
  }

  static bool? haveKey(String key) {
    return _prefs?.getKeys().contains(key);
  }

  static bool? containsKey(String key) {
    return _prefs?.containsKey(key);
  }

  static Set<String>? getKeys() {
    return _prefs?.getKeys();
  }

  static Future<bool>? remove(String key) {
    return _prefs?.remove(key);
  }

  static Future<bool>? clear() {
    return _prefs?.clear();
  }

  static Future<void>? reload() {
    return _prefs?.reload();
  }

  static bool isInitialized() {
    return _prefs != null;
  }

  static SharedPreferences? getSp() {
    return _prefs;
  }

  Future<void> saveBluetoothServiceResponses(List<BluetoothServiceResponse> responses) async {
    final jsonList = responses.map((response) => response.toJson()).toList();
    await UserPreference.putObjectList(PrefKeys.bluetoothServices, jsonList);
  }

  Future<List<BluetoothServiceResponse>> loadBluetoothServiceResponses() async {
    final jsonList = UserPreference.getObjectList(PrefKeys.bluetoothServices) ?? [];
    return jsonList.map((json) => BluetoothServiceResponse.fromJson(json)).toList();
  }
}
