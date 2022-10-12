import 'package:battary/token/token_string.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyToken {
  static Future getUserID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var data = await prefs.getString(TokenString.userid);
    return data;
  }

  static Future getRoleId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var data = await prefs.getString(TokenString.roleId);
    return data;
  }

  static Future getName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var data = await prefs.getString(TokenString.userName);
    return data;
  }
}
