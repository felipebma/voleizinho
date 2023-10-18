import 'package:voleizinho/model/player.dart';
import 'package:voleizinho/repositories/player_repository.dart';

class PlayerService {
  static final PlayerRepository _playerRepository = PlayerRepository();

  static void addPlayer(Player player, int groupId) {
    Player newPlayer = player.copyWith(groupId: groupId);
    _playerRepository.addPlayer(newPlayer);
  }

  static void updatePlayer(Player newPlayer) {
    _playerRepository.updatePlayer(newPlayer);
  }

  static List<Player> getPlayersFromGroup(int groupId) {
    return _playerRepository.getPlayersFromGroup(groupId);
  }
}
