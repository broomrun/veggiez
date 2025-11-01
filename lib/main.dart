import 'package:flutter/material.dart';
import 'package:veggiez/screens/character.dart';
import 'package:veggiez/screens/splash_screen.dart';
import 'package:veggiez/screens/homepage.dart';
import 'package:veggiez/screens/enter_name.dart';
import 'package:veggiez/theme/colors.dart';

void main() {
  runApp(const VeggizApp());
}

class VeggizApp extends StatelessWidget {
  const VeggizApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Veggiez',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
        useMaterial3: true,
      ),

      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/home': (context) => const HomePage(),
        '/chara': (context) => const ChooseCharacterPage(),
        '/enterName': (context) => const EnterNamePage(),
      },
    );
  }
}
