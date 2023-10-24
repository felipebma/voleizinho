import 'dart:io';

import 'package:csv/csv.dart';
import 'package:path_provider/path_provider.dart';
import 'package:voleizinho/model/player.dart';
import 'package:voleizinho/model/skills.dart';
import 'package:voleizinho/repositories/player_repository.dart';
import 'package:voleizinho/services/group_service.dart';
import 'package:voleizinho/services/share_service.dart';

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

  static Future<void> exportPlayersList(int groupId) async {
    List<Player> players = _playerRepository.getPlayersFromGroup(groupId);
    List<Skill> skills = Skill.values;
    List<String> headers = [
      "name",
      ...skills.map((e) => e.toString()).toList()
    ];
    List<List<String>> rows = [];
    for (Player p in players) {
      List<String> row = [
        p.name!,
        ...skills.map((e) => p.getSkill(e).toString()).toList()
      ];
      rows.add(row);
    }
    String groupName = GroupService.activeGroup().name!;
    String csv = const ListToCsvConverter().convert([headers, ...rows]);
    final String directory = (await getApplicationDocumentsDirectory()).path;
    final String path = "$directory/$groupName.csv";
    final File file = File(path);
    await file.writeAsString(csv);
    await ShareService.shareFile(file);
  }
}
