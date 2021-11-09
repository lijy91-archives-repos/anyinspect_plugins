import 'package:anyinspect_client/anyinspect_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AnyInspectPluginSharedPreferences extends AnyInspectPlugin
    with AnyInspectPluginMethodHandler {
  @override
  String get id => 'shared_preferences';

  AnyInspectPluginSharedPreferences() {
    addMethodHandler(this);
  }

  @override
  Future<void> handleMethod(AnyInspectPluginMethod method) async {
    switch (method.name) {
      case 'getAll':
        await getAll();
        return;
      default:
    }
  }

  Future<void> getAll() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    List<Map<String, dynamic>> list = [];
    Set<String> keys = _prefs.getKeys();
    for (var key in keys) {
      list.add({'key': key, 'value': _prefs.get(key)});
    }
    emitEvent('getAllSuccess', {'list': list});
  }
}
