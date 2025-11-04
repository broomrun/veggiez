import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:veggiez/theme/colors.dart';
import 'package:veggiez/widgets/background.dart';
import 'package:veggiez/widgets/character_card.dart';
import 'package:veggiez/config/routes.dart';
import 'package:veggiez/data/dummy.dart';
import 'package:go_router/go_router.dart';

class ResultPage extends StatelessWidget {
  final int score;
  final String name;
  final String imagePath;

  const ResultPage({
    super.key,
    required this.score,
    required this.name,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    final double padding = media.width * 0.08;
    final double iconSize = media.width * 0.07;
    final double buttonSize = media.width * 0.16;
    final double spacing = media.height * 0.02;

    final int totalQuestions = quizQuestions.length;
    final int correctAnswers = (score ~/ 10);
    final int wrongAnswers = totalQuestions - correctAnswers;
    final double percentage = (score / (totalQuestions * 10)) * 100;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: Stack(
        children: [
          const HomeBackground(),
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: padding),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CharacterCard(
                      imagePath: imagePath,
                      name: name,
                    ),
                    SizedBox(height: spacing),

                    Container(
                      padding: EdgeInsets.all(padding * 0.6),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        border: Border.all(color: AppColors.stroke1, width: 2),
                        borderRadius: BorderRadius.circular(padding * 0.5),
                      ),
                      child: Column(
                        children: [
                          _buildStatRow("Total Questions", "$totalQuestions", media),
                          _buildStatRow("Correct Answers", "$correctAnswers", media),
                          _buildStatRow("Wrong Answers", "$wrongAnswers", media),
                          _buildStatRow(
                            "Percentage",
                            "${percentage.toStringAsFixed(1)}%",
                            media,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: spacing * 2),

                    GestureDetector(
                      onTap: () {
                        context.push(AppRoutes.quiz, extra: {
                          'name': name,
                          'image': imagePath,
                        });
                      },
                      child: Container(
                        width: buttonSize,
                        height: buttonSize,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.stroke1,
                            width: 2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.stroke1.withValues(alpha: 0.2),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.refresh,
                          color: AppColors.stroke1,
                          size: iconSize,
                        ),
                      ),
                    ),
                    SizedBox(height: spacing * 0.5),
                    Text(
                      "Try Again",
                      style: GoogleFonts.poppins(
                        fontSize: media.width * 0.045,
                        color: AppColors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatRow(String label, String value, Size media) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: media.height * 0.008),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: media.width * 0.04,
              color: AppColors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: media.width * 0.04,
              color: AppColors.stroke1,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
