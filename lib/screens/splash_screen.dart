import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:veggiez/theme/colors.dart';
import 'package:veggiez/config/routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String displayedText = "";
  final String fullText = "Veggiez";
  int _currentIndex = 0;
  Timer? _typingTimer;

  @override
  void initState() {
    super.initState();
    _startTypingEffect();
  }

  void _startTypingEffect() {
    _typingTimer = Timer.periodic(const Duration(milliseconds: 300), (timer) {
      if (_currentIndex < fullText.length) {
        setState(() {
          displayedText += fullText[_currentIndex];
          _currentIndex++;
        });
      } else {
        timer.cancel();

        Future.delayed(const Duration(seconds: 1), () {
          if (!mounted) return;
          context.go(AppRoutes.home);
        });
      }
    });
  }

  @override
  void dispose() {
    _typingTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Center(
        child: Stack(
          children: [
            Text(
              displayedText,
              style: TextStyle(
                fontSize: size.width * 0.20,
                fontFamily: 'Harlow',
                fontStyle: FontStyle.italic,
                letterSpacing: size.width * 0.003,
                foreground: Paint()
                  ..style = PaintingStyle.stroke
                  ..strokeWidth = 3
                  ..color = AppColors.stroke1,
              ),
            ),
            Text(
              displayedText,
              style: TextStyle(
                fontSize: size.width * 0.20,
                fontFamily: 'Harlow',
                fontStyle: FontStyle.italic,
                letterSpacing: size.width * 0.003,
                color: AppColors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
