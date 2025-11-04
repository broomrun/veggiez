import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:veggiez/theme/colors.dart';
import 'package:veggiez/widgets/background.dart';
import 'package:veggiez/widgets/button.dart';
import 'package:veggiez/config/routes.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final double imageHeight = size.height * 0.25;
    final double cardWidth = size.width * 0.7;
    final double cardPaddingH = size.width * 0.05;
    final double cardPaddingV = size.height * 0.05;

    return Scaffold(
      body: Stack(
        children: [
          const HomeBackground(),

          Positioned(
            top: size.height * 0.22,
            left: size.width * 0.02,
            child: Image.asset(
              'assets/images/cabbage.png',
              height: imageHeight,
              fit: BoxFit.contain,
            ),
          ),

          Align(
            alignment: const Alignment(0, 0.25),
            child: Container(
              width: cardWidth,
              padding: EdgeInsets.symmetric(
                horizontal: cardPaddingH,
                vertical: cardPaddingV,
              ),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(size.width * 0.03),
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
                      fontSize: size.width * 0.06,
                      fontWeight: FontWeight.bold,
                      color: AppColors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: size.height * 0.015),
                  Text(
                    "Only true veggie lovers survive this quiz!",
                    style: GoogleFonts.poppins(
                      fontSize: size.width * 0.035,
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
              context.go(AppRoutes.character);
            },
          ),
        ],
      ),
    );
  }
}
