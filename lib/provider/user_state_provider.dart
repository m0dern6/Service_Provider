import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart';

class UserStateProvider extends ChangeNotifier {
  Map<String, dynamic> _user = {};
  Map<String, dynamic> get user => _user;

  UserStateProvider() {
    loadUser();
  }

  void login(Map<String, dynamic> user) async {
    _user = user;
    notifyListeners();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('user', jsonEncode(user));
  }

  void logout() async {
    _user = {};
    notifyListeners();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('user');
  }

  void loadUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userString = prefs.getString('user');
    if (userString != null) {
      _user = jsonDecode(userString);
      notifyListeners();
    }
  }
}
