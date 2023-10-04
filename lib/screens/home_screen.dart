import 'package:flutter/material.dart';
import 'package:voleizinho/components/menu_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Image(image: AssetImage('assets/logo.png')),
              const Text(
                "VOLEIZINHO",
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  fontFamily: "poller_one",
                ),
              ),
              const SizedBox(height: 50.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  MenuButton(
                    leftWidget: const Icon(
                      Icons.man,
                      color: Colors.black,
                      size: 56,
                    ),
                    text: "Jogadores",
                    onPressed: () => {
                      Navigator.pushNamed(context, "/players"),
                    },
                  ),
                  MenuButton(
                      leftWidget: const Icon(
                        Icons.settings,
                        color: Colors.black,
                        size: 56,
                      ),
                      text: "Configurações",
                      onPressed: () => {}),
                  MenuButton(
                    leftWidget: const Icon(
                      Icons.people,
                      color: Colors.black,
                      size: 56,
                    ),
                    text: "Criar Times",
                    onPressed: () => {
                      Navigator.pushNamed(context, "/team_creation"),
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
