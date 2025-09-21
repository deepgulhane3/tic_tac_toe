import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe/player_setup_screen.dart';
import 'package:tic_tac_toe/spash.dart';
import 'package:tic_tac_toe/tic_tac_toe_provider.dart';
import 'package:tic_tac_toe/tic_tac_toe_screen.dart';


void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // Simulate some init work
  await Future.delayed(const Duration(seconds: 2));

  FlutterNativeSplash.remove();
  runApp(const TicTacToeApp());
}

class TicTacToeApp extends StatelessWidget {
  const TicTacToeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TicTacToeProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Tic Tac Toe',
        theme: ThemeData(
          colorSchemeSeed: Colors.deepPurple,
          useMaterial3: true,
        ),
        initialRoute: '/splash', // simple name
        routes: {
          '/splash': (context) => SplashScreen(),
          '/setup': (context) => PlayerSetupScreen(),
          '/tic_tac_toe': (context) => TicTacToeScreen(),
        },
      ),
    );
  }
}

