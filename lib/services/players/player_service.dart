import 'dart:convert';
import 'dart:io';

import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:voleizinho/exceptions/player/player_name_already_existis_exception.dart';
import 'package:voleizinho/exceptions/player/player_name_is_empty_exception.dart';
import 'package:voleizinho/model/player.dart';
import 'package:voleizinho/model/skills.dart';
import 'package:voleizinho/repositories/player_repository.dart';
import 'package:voleizinho/services/groups/group_service.dart';
import 'package:voleizinho/services/share_service/share_service.dart';

class PlayerService {
  final PlayerRepository _playerRepository;

  PlayerService(this._playerRepository);

  void addPlayer(Player player) {
    _validatePlayer(player);
    Player newPlayer = player.copyWith();
    _playerRepository.addPlayer(newPlayer);
  }

  void updatePlayer(Player newPlayer) {
    _validatePlayer(newPlayer);
    _playerRepository.updatePlayer(newPlayer);
  }

  void removePlayer(Player player) {
    _playerRepository.removePlayer(player);
  }

  void removePlayersFromGroup(int groupId) {
    _playerRepository.removeAllPlayerByGroup(groupId);
  }

  List<Player> getPlayersFromGroup(int groupId) {
    return _playerRepository.getPlayersFromGroup(groupId);
  }

  Future<void> exportPlayersList(int groupId) async {
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
    String groupName = GroupService.I
        .activeGroup()
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

  Future<void> importPlayersList(int groupId) async {
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
      addPlayer(player.copyWith(groupId: groupId));
    }
  }

  void _validatePlayer(Player player) {
    if (player.name == null || player.name!.isEmpty) {
      throw PlayerNameIsEmptyException("Player name is empty");
    }
    List<Player> players = getPlayersFromGroup(player.groupId);
    if (players.any(
        (element) => element.name == player.name && element.id != player.id)) {
      throw PlayerNameAlreadyExistsException("Player name already exists");
    }
  }
}
