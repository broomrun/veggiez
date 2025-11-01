import 'package:flutter/material.dart';
import 'dart:async';
import 'package:veggiez/theme/colors.dart';
import 'package:veggiez/screens/homepage.dart'; // pastikan import ini ada

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

          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              transitionDuration: const Duration(milliseconds: 1200),
              pageBuilder: (context, animation, secondaryAnimation) => const HomePage(),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                final slideAnimation = Tween<Offset>(
                  begin: const Offset(0, 0.3),
                  end: Offset.zero,
                ).animate(
                  CurvedAnimation(
                    parent: animation,
                    curve: Curves.easeInOutQuart,
                  ),
                );

                final fadeAnimation = CurvedAnimation(
                  parent: animation,
                  curve: const Interval(0.2, 1.0, curve: Curves.easeInOut),
                );

                return FadeTransition(
                  opacity: fadeAnimation,
                  child: SlideTransition(
                    position: slideAnimation,
                    child: child,
                  ),
                );
              },
            ),
          );
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
                letterSpacing: 1.0,
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
                letterSpacing: 1.0,
                color: AppColors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
