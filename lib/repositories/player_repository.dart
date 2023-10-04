import "package:voleizinho/constants.dart";
import "package:voleizinho/model/player.dart";
import "package:voleizinho/shared_pref.dart";

class PlayerRepository {
  static SharedPref prefs = SharedPref();

  static void addPlayer(Player player) async {
    List<Player> players = SharedPref.decode(await prefs.read("players"));
    players.add(player);
    await prefs.save("players", SharedPref.encode(players));
  }

  static void updatePlayer(Player oldPlayer, Player newPlayer) async {
    List<Player> players = SharedPref.decode(await prefs.read("players"));
    players[players.indexWhere((element) => element.name == oldPlayer.name)] =
        newPlayer;
    prefs.save("players", SharedPref.encode(players));
  }

  static void removePlayer(Player player) async {
    List<Player> players = SharedPref.decode(await prefs.read("players"));
    players.remove(player);
    await prefs.save("players", SharedPref.encode(players));
  }

  static List<Player> getPlayers() {
    return prefs.read("players");
  }

  static void resetDB() async {
    prefs
        .save("test", playersDB[0].toJson())
        .then((value) => print("saved: $value"));
    prefs.save("players", SharedPref.encode(playersDB));
  }
}
