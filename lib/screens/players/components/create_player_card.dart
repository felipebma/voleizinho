import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voleizinho/bloc/groups/group_bloc.dart';
import 'package:voleizinho/bloc/players/players_bloc.dart';
import 'package:voleizinho/bloc/players/players_events.dart';
import 'package:voleizinho/components/edit_player_card.dart';
import 'package:voleizinho/constants.dart';

class CreatePlayerCard extends StatelessWidget {
  const CreatePlayerCard({super.key});

  @override
  Widget build(BuildContext context) {
    PlayersBloc playersBloc = BlocProvider.of<PlayersBloc>(context);
    GroupBloc groupBloc = BlocProvider.of<GroupBloc>(context);

    return EditPlayerCard(
      player: kDefaultPlayer.copyWith(
          name: "", groupId: groupBloc.state.activeGroup!.id),
      onCancel: () => playersBloc.add(PlayersEditingEvent(-2)),
      onSave: (player) => playersBloc.add(PlayersCreateEvent(player)),
    );
  }
}
