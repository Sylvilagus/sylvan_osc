/**
 * Created by Sylva Lee
 */

import 'package:shared_preferences/shared_preferences.dart';
import 'package:sylvan_osc/entity/entity.dart';
abstract class _SimpleStringPersist{
  save(String key, String value);
  Future<String> get(String key);
  factory _SimpleStringPersist(){
    return _SpPersist();
  }
}

class _SpPersist extends _SimpleStringPersist{
  factory _SpPersist(){
    return _SpPersist();
  }
  @override
  Future<String> get(String key) async {
    var sp = await SharedPreferences.getInstance();
    return sp.getString(key);
  }

  @override
  save(String key, String value) async {
    var sp = await SharedPreferences.getInstance();
    sp.setString(key, value);
  }

}

class PersistApi{
  PersistApi._internal();
  static PersistApi _instance = PersistApi._internal();
  _SimpleStringPersist sp = _SimpleStringPersist();
  factory PersistApi(){
    return _instance;
  }
  static const _KEY_USER = "user";
  Future<User> getUser() async{
    String jsonString = await sp.get(_KEY_USER);
    return User.fromJson(jsonString);
  }
  saveUser(String jsonString) async{
    sp.save(_KEY_USER, jsonString);
  }
}

