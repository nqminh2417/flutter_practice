import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static SharedPreferences? _preferences;

  static Future<SharedPreferences> get _instance async =>
      _preferences ??= await SharedPreferences.getInstance();

  static Future<void> saveSearchHistory(List<String> searchHistory) async {
    final SharedPreferences prefs = await _instance;
    await prefs.setStringList('yt_search_history', searchHistory);
  }

  static Future<List<String>> loadSearchHistory() async {
    final SharedPreferences prefs = await _instance;
    return prefs.getStringList('yt_search_history') ?? [];
  }
}
