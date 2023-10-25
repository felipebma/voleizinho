import 'dart:convert';
import 'dart:io';

import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
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

  static void removePlayersFromGroup(int groupId) {
    _playerRepository.removeAllPlayerByGroup(groupId);
  }

  static List<Player> getPlayersFromGroup(int groupId) {
    return _playerRepository.getPlayersFromGroup(groupId);
  }

  static Future<void> exportPlayersList(int groupId) async {
    List<Player> players = _playerRepository.getPlayersFromGroup(groupId);
    List<Skill> skills = Skill.values;
    List<String> headers = [
      "name",
      ...skills.map((e) => e.toShortString()).toList()
    ];
    List<List<String>> rows = [];
    for (Player p in players) {
      List<String> row = [
        p.name!,
        ...skills.map((e) => p.getSkill(e).toString()).toList()
      ];
      rows.add(row);
    }
    String groupName = GroupService.activeGroup()
        .name!
        .replaceAll("/", "_")
        .replaceAll(".", "_");
    String csv = const ListToCsvConverter().convert([headers, ...rows]);
    final String directory = (await getApplicationDocumentsDirectory()).path;
    final String path = "$directory/'$groupName'.csv";
    final File file = File(path);
    await file.writeAsString(csv);
    await ShareService.shareFile(file);
  }

  static Future<void> importPlayersList(int groupId) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['csv'],
    );

    if (result == null) {
      return;
    }

    String? filePath = result.files.single.path;
    if (filePath == null) {
      return;
    }

    List<Player> players = [];

    try {
      final input = File(filePath).openRead();
      final fields = await input
          .transform(utf8.decoder)
          .transform(const CsvToListConverter())
          .toList();

      List<Skill> skillsHeader = fields[0]
          .sublist(1)
          .map((e) => Skill.values
              .firstWhere((element) => element.toShortString() == e))
          .toList();

      for (List<dynamic> row in fields.sublist(1)) {
        Map<Skill, int> skills = {};
        for (int i = 1; i < row.length; i++) {
          skills[skillsHeader[i - 1]] = row[i].round();
        }
        players.add(Player.withArgs(name: row[0], skills: skills));
      }
    } on Exception catch (e) {
      print(e);
      return;
    }

    for (Player player in players) {
      addPlayer(player, groupId);
    }
  }
}
