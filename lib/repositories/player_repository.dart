import "package:get_it/get_it.dart";
import "package:voleizinho/model/player.dart";
import "package:voleizinho/objectbox.g.dart";

class PlayerRepository {
  static Box<Player>? playerBox;

  PlayerRepository() {
    final getIt = GetIt.instance;
    playerBox = getIt.get<Box<Player>>();
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
