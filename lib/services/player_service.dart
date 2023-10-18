import 'package:voleizinho/model/player.dart';
import 'package:voleizinho/repositories/player_repository.dart';

class PlayerService {
  static final PlayerRepository _playerRepository = PlayerRepository();

  static void addPlayer(Player player) {
    _playerRepository.addPlayer(player);
  }

  static void updatePlayer(Player newPlayer) {
    _playerRepository.updatePlayer(newPlayer);
  }
}
