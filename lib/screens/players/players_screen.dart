import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voleizinho/bloc/players/players_bloc.dart';
import 'package:voleizinho/bloc/players/players_events.dart';
import 'package:voleizinho/bloc/players/players_states.dart';
import 'package:voleizinho/components/drawer.dart';
import 'package:voleizinho/components/edit_player_card.dart';
import 'package:voleizinho/components/menu_button.dart';
import 'package:voleizinho/constants.dart';
import 'package:voleizinho/screens/players/widgets/players_list.dart';
import 'package:voleizinho/screens/players/widgets/popup_menu_widget.dart';
import 'package:voleizinho/services/user_preferences.dart';

class PlayersScreen extends StatefulWidget {
  const PlayersScreen({super.key});

  @override
  State<PlayersScreen> createState() => _PlayersScreenState();
}

class _PlayersScreenState extends State<PlayersScreen> {
  int groupId = UserPreferences.getGroup()!;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<PlayersBloc>(context).add(PlayersLoadEvent(groupId));
  }

  @override
  Widget build(BuildContext context) {
    PlayersBloc bloc = BlocProvider.of<PlayersBloc>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFCDE8DE),
        elevation: 0,
        foregroundColor: Colors.black,
        actions: const [PopUpMenu()],
      ),
      drawer: const CustomDrawer(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Center(
            child: BlocConsumer<PlayersBloc, PlayersState>(
              listener: (context, state) {
                if (state.isError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.errorMessage!),
                    ),
                  );
                }
              },
              builder: (context, state) {
                final players = state.players;
                players.sort((a, b) =>
                    a.name!.toUpperCase().compareTo(b.name!.toUpperCase()));
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MenuButton(
                      text: "NOVO JOGADOR",
                      onPressed: () {
                        bloc.add(PlayersEditingEvent(-1));
                      },
                      leftWidget: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.green,
                        ),
                        child: const Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    ),
                    MenuButton(
                      text: "CRIAR TIMES",
                      onPressed: () => Navigator.pushReplacementNamed(
                        context,
                        '/team_creation',
                      ),
                      leftWidget: const Icon(
                        color: Colors.black,
                        Icons.group_rounded,
                        size: 30,
                      ),
                    ),
                    if (state.editingPlayerIndex == -1)
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: EditPlayerCard(
                          player: kDefaultPlayer.copyWith(
                              name: "", groupId: groupId),
                          onCancel: () => bloc.add(PlayersEditingEvent(-2)),
                          onSave: (player) =>
                              bloc.add(PlayersCreateEvent(player)),
                        ),
                      ),
                    const SizedBox(height: 30),
                    PlayersList(players: players),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
