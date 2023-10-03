import 'package:flutter/material.dart';
import 'package:voleizinho/model/player.dart';

class PlayerView extends StatefulWidget {
  const PlayerView({super.key, required this.player, this.editable = false});

  final Player player;
  final bool editable;

  @override
  State<PlayerView> createState() => _PlayerViewState();
}

class _PlayerViewState extends State<PlayerView> {
  @override
  Widget build(BuildContext context) {
    Widget textField = widget.editable
        ? SizedBox(
            width: 250,
            child: TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Jogador',
              ),
              onChanged: (text) {
                widget.player.name = text;
              },
            ),
          )
        : Text(
            widget.player.name,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          );

    Player player = widget.player;
    return Material(
      elevation: 3,
      child: Container(
        width: double.infinity,
        height: 40,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.white,
          shape: BoxShape.rectangle,
        ),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          textField,
          Row(
            children: [
              Text(
                player.getAverage().toString(),
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Icon(
                Icons.star,
                color: Colors.amber,
              ),
            ],
          )
        ]),
      ),
    );
  }
}