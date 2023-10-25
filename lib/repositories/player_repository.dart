import "package:voleizinho/model/player.dart";
import "package:voleizinho/objectbox.g.dart";

class PlayerRepository {
  static Box<Player>? playerBox;

  static void init(Box<Player> box) {
    playerBox = box;
  }

  void addPlayer(Player player) {
    playerBox!.put(player);
  }

  void updatePlayer(Player newPlayer) {
    playerBox!.put(newPlayer);
  }

  void removePlayer(Player player) {
    playerBox!.remove(player.id);
  }

  void removeAllPlayerByGroup(int groupId) {
    playerBox!.query(Player_.groupId.equals(groupId)).build().remove();
  }

  List<Player> getPlayers() {
    return playerBox!.getAll();
  }

  List<Player> getPlayersFromGroup(int groupId) {
    return playerBox!.query(Player_.groupId.equals(groupId)).build().find();
  }
}
