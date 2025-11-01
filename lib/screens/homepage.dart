import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:veggiez/theme/colors.dart';
import 'package:veggiez/widgets/background.dart';
import 'package:veggiez/widgets/button.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          const HomeBackground(),

          Positioned(
            top: size.height * 0.25,
            left: size.width * 0.01,
            child: Image.asset(
              'assets/images/cabbage.png',
              height: size.height * 0.25,
            ),
          ),

          Align(
            alignment: const Alignment(0, 0.25),
            child: Container(
              width: size.width * 0.7,
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 40),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppColors.stroke1,
                  width: 2,
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Let's Start a Quiz",
                    style: GoogleFonts.poppins(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: AppColors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    "Only true veggie lovers survive this quiz!",
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.blacksoft,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),

          CustomButton(
            text: "Start Game",
            isPrimary: false,
            onPressed: () {
              Navigator.pushNamed(context, '/chara');
            },
          ),
        ],
      ),
    );
  }
}
