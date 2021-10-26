import 'package:anyinspect_client/anyinspect_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AnyInspectPluginSharedPreferences extends AnyInspectPlugin {
  @override
  String get id => 'shared_preferences';

  AnyInspectPluginSharedPreferences() {
    receive('getAll', (data) => getAll());
  }

  void getAll() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();

    List<Map<String, dynamic>> list = [];

    Set<String> keys = _prefs.getKeys();
    for (var key in keys) {
      list.add({
        'key': key,
        'value': _prefs.get(key),
      });
    }
    send('getAllResult', {'list': list});
  }
}
