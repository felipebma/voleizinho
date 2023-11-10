import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voleizinho/bloc/players/players_bloc.dart';
import 'package:voleizinho/bloc/players/players_events.dart';

class PopUpMenu extends StatelessWidget {
  const PopUpMenu({super.key});

  @override
  Widget build(BuildContext context) {
    PlayersBloc bloc = BlocProvider.of<PlayersBloc>(context);
    return PopupMenuButton(
      itemBuilder: (context) {
        return [
          const PopupMenuItem(
            value: 0,
            child: Text("Importar Jogadores"),
          ),
          const PopupMenuItem(
            value: 1,
            child: Text("Exportar Jogadores"),
          ),
          const PopupMenuItem(
            value: 2,
            child: Text("Apagar Jogadores"),
          )
        ];
      },
      onSelected: (value) {
        if (value == 0) {
          bloc.add(PlayersImportEvent());
        } else if (value == 1) {
          bloc.add(PlayersExportEvent());
        } else if (value == 2) {
          bloc.add(PlayersClearEvent());
        }
      },
    );
  }
}
