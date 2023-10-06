import "package:voleizinho/model/player.dart";
import "package:voleizinho/objectbox.g.dart";

class PlayerRepository {
  static Box<Player>? playerBox;

  static void init(Box<Player> box) {
    playerBox = box;
  }

  static void addPlayer(Player player) async {
    List<Player> players = playerBox!.getAll();
    players.add(player);
    playerBox!.put(player);
  }

  static void updatePlayer(Player oldPlayer, Player newPlayer) async {
    playerBox!.put(newPlayer);
  }

  static void removePlayer(Player player) async {
    playerBox!.remove(player.id);
  }

  static List<Player> getPlayers() {
    return playerBox!.getAll();
  }
}
