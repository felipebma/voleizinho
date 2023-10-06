import 'package:flutter/material.dart';
import 'package:voleizinho/model/player.dart';

class PlayerCard extends StatefulWidget {
  const PlayerCard(
      {super.key,
      required this.player,
      this.editable = false,
      this.color = Colors.white});

  final Player player;
  final bool editable;
  final Color color;

  @override
  State<PlayerCard> createState() => _PlayerCardState();
}

class _PlayerCardState extends State<PlayerCard> {
  @override
  Widget build(BuildContext context) {
    Widget textField = widget.editable
        ? SizedBox(
            width: 250,
            child: TextField(
              controller: TextEditingController(text: widget.player.name),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
              style: const TextStyle(
                color: Colors.grey,
                fontFamily: "poller_one",
              ),
              onChanged: (text) {
                widget.player.name = text;
              },
            ),
          )
        : Text(
            widget.player.name!,
            style: const TextStyle(
              fontFamily: "poller_one",
              color: Colors.black,
              fontSize: 20,
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
          color: widget.color,
          shape: BoxShape.rectangle,
        ),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          textField,
          Row(
            children: [
              Text(
                player.getAverage().toStringAsFixed(1),
                style: const TextStyle(
                  fontFamily: "poller_one",
                  color: Colors.black,
                  fontSize: 20,
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
