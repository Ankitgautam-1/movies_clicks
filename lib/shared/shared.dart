import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  SharedPrefs._();

  static final SharedPrefs _instance = SharedPrefs._();
  static SharedPrefs get instance => _instance;

  late SharedPreferences _prefs;

  Future<void> init() async => _prefs = await SharedPreferences.getInstance();

  Future<void> remove(String key) async => await _prefs.remove(key);

  Future<void> clear() async => await _prefs.clear();

  /// Setters
  Future<bool> setShouldSkipOnboard(bool value) async =>
      await _prefs.setBool('shouldSkipOnboard', value);
  bool getShouldSkipOnboard() => _prefs.getBool('shouldSkipOnboard') ?? false;
}
