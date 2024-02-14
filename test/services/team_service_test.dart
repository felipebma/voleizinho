import 'package:flutter_test/flutter_test.dart';
import 'package:voleizinho/exceptions/team/not_enough_players_exception.dart';
import 'package:voleizinho/services/teams/team_service.dart';

import '../common/player_list.dart';

void main() {
  TeamService teamService = TeamService();

  group('Creating teams', () {
    test(
        'Creating teams with no Players should raise a NotEnoughPlayersException',
        () {
      expect(() => teamService.createTeams(1, [], 1, false),
          throwsA(isA<NotEnoughPlayersException>()));
    });

    test(
        'Creating teams with less players than the minimum required should raise a NotEnoughPlayersException',
        () {
      expect(() => teamService.createTeams(1, players.sublist(0, 3), 2, false),
          throwsA(isA<NotEnoughPlayersException>()));
    });
  });
}
