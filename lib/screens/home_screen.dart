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
                      iconData: Icons.man,
                      text: "Jogadores",
                      onPressed: () => {}),
                  MenuButton(
                      iconData: Icons.settings,
                      text: "Configurações",
                      onPressed: () => {}),
                  MenuButton(
                      iconData: Icons.people,
                      text: "Criar Times",
                      onPressed: () => {}),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
