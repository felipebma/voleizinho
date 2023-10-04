import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'package:voleizinho/model/player.dart';

class SharedPref {
  read(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return json.decode(prefs.getString(key)!);
  }

  save(String key, value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, json.encode(value));
  }

  remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }

  static String encode(List<Player> players) => json.encode(
        players.map<Map<String, dynamic>>((player) => player.toJson()).toList(),
      );

  static List<Player> decode(String players) =>
      (json.decode(players) as List<dynamic>)
          .map<Player>((player) => Player.fromJson(player))
          .toList();
}
