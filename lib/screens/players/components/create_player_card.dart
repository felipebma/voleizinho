import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voleizinho/bloc/players/players_bloc.dart';
import 'package:voleizinho/bloc/players/players_events.dart';
import 'package:voleizinho/components/edit_player_card.dart';
import 'package:voleizinho/constants.dart';
import 'package:voleizinho/services/user_preferences.dart';

class CreatePlayerCard extends StatelessWidget {
  const CreatePlayerCard({super.key});

  @override
  Widget build(BuildContext context) {
    int groupId = UserPreferences.getGroup()!;
    PlayersBloc bloc = BlocProvider.of<PlayersBloc>(context);

    return EditPlayerCard(
      player: kDefaultPlayer.copyWith(name: "", groupId: groupId),
      onCancel: () => bloc.add(PlayersEditingEvent(-2)),
      onSave: (player) => bloc.add(PlayersCreateEvent(player)),
    );
  }
}
