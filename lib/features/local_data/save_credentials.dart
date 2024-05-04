import 'package:qubit/presentation/widgets/snakbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalDatabase {
  Future<bool> saveData(String key) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('key', key);
      return true;
    } catch (e) {
      showCustomSnakbar('Somthing went wrong', e.toString());
      return false;
    }
  }

  Future<String?> getData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('key');
  }
  Future<bool> remove() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.remove('key');
  }
}
