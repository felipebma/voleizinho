import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:voleizinho/screens/home_screen.dart';
import 'package:voleizinho/screens/players_screen.dart';
import 'package:voleizinho/screens/team_creation_screen.dart';
import 'package:voleizinho/screens/teams_view_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light().copyWith(
        primaryColor: Colors.blue,
        scaffoldBackgroundColor: const Color(0xFFCDE8DE),
        primaryTextTheme: const TextTheme(
          titleLarge: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            fontFamily: "poller_one",
          ),
        ),
      ),
      routes: {
        "/": (context) => const HomeScreen(),
        "/players": (context) => PlayersScreen(),
        "/team_creation": (context) => const TeamCreationScreen(),
        "/teams_view": (context) => const TeamsViewScreen(),
      },
      initialRoute: "/",
    );
  }
}
