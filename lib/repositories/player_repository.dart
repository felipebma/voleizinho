import "package:voleizinho/model/player.dart";
import "package:voleizinho/objectbox.g.dart";
import "package:voleizinho/services/user_preferences.dart";

class PlayerRepository {
  static Box<Player>? playerBox;

  static void init(Box<Player> box) {
    playerBox = box;
  }

  void addPlayer(Player player) {
    player.groupId = UserPreferences.getGroup()!;
    playerBox!.put(player);
  }

  void updatePlayer(Player newPlayer) {
    playerBox!.put(newPlayer);
  }

  void removePlayer(Player player) {
    playerBox!.remove(player.id);
  }

  List<Player> getPlayers() {
    return playerBox!.getAll();
  }
}
