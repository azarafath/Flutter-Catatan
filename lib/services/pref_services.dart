import 'package:shared_preferences/shared_preferences.dart';

class PrefServices {
  static const String id = 'id';
  Future<SharedPreferences> getPreferences() async =>
      SharedPreferences.getInstance();

  setPref(String value) async {
    (await getPreferences()).setString(id, value);
  }

  Future<String> getPref() async {
    var pref = await getPreferences();
    String value = '';
    if (pref.getString(id) != null) {
      value = pref.getString(id)!;
    }
    return value;
  }

  Future<bool> deletePref() async {
    var pref = await getPreferences();
    pref.remove(id);
    return true;
  }
}
