import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:veggiez/theme/colors.dart';
import 'package:veggiez/widgets/background.dart';
import 'package:veggiez/data/dummy.dart';
import 'package:go_router/go_router.dart';
import 'package:veggiez/config/routes.dart';
import 'package:veggiez/provider/quiz_provider.dart';

class QuizPage extends StatefulWidget {
  final String name;
  final String imagePath;

  const QuizPage({
    super.key,
    required this.name,
    required this.imagePath,
  });

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final quizProvider = context.read<QuizProvider>();
      quizProvider.resetQuiz();

      quizProvider.startTimer(() {
        quizProvider.answered = true;
        quizProvider.selectedOption = -1;

        if (quizProvider.currentQuestionIndex < quizQuestions.length - 1) {
          quizProvider.nextQuestion();
        } else {
          _goToResult();
        }
      });
    });
  }

  @override
  void dispose() {
    context.read<QuizProvider>().stopTimer();
    super.dispose();
  }

  void _goToResult() {
    final quizProvider = context.read<QuizProvider>();
    quizProvider.stopTimer();

    if (!mounted) return;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      context.pushReplacement(
        AppRoutes.result,
        extra: {
          'score': quizProvider.score,
          'name': widget.name,
          'imagePath': widget.imagePath,
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final quizProvider = context.watch<QuizProvider>();
    final question = quizQuestions[quizProvider.currentQuestionIndex];

    final size = MediaQuery.of(context).size;
    final spacing = size.height * 0.025;
    final horizontalPadding = size.width * 0.08;
    final boxWidth = size.width * 0.85;
    final progress =
        (quizProvider.currentQuestionIndex + 1) / quizQuestions.length;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: Stack(
        children: [
          const HomeBackground(),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: spacing,
              ),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back),
                      color: AppColors.black,
                      onPressed: () {
                        quizProvider.stopTimer();
                        context.pop();
                      },
                    ),
                  ),
                  SizedBox(height: spacing),

                  Column(
                    children: [
                      Container(
                        width: boxWidth,
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.stroke1),
                          borderRadius:
                          BorderRadius.circular(size.width * 0.03),
                        ),
                        child: ClipRRect(
                          borderRadius:
                          BorderRadius.circular(size.width * 0.03),
                          child: LinearProgressIndicator(
                            value: progress,
                            minHeight: size.height * 0.015,
                            backgroundColor: AppColors.white,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                      SizedBox(height: spacing / 2),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Question ${quizProvider.currentQuestionIndex + 1}/${quizQuestions.length}",
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold,
                              fontSize: size.width * 0.04,
                            ),
                          ),
                          Text(
                            "00:${quizProvider.secondsLeft.toString().padLeft(2, '0')}",
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold,
                              color: quizProvider.secondsLeft <= 5
                                  ? AppColors.red
                                  : AppColors.black,
                              fontSize: size.width * 0.045,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  SizedBox(height: spacing),

                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          Container(
                            width: boxWidth,
                            padding: EdgeInsets.all(size.width * 0.05),
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              border: Border.all(color: AppColors.stroke1),
                              borderRadius:
                              BorderRadius.circular(size.width * 0.04),
                            ),
                            child: Column(
                              children: [
                                if (question.image != null)
                                  Padding(
                                    padding:
                                    EdgeInsets.only(bottom: spacing / 2),
                                    child: Image.asset(
                                      question.image!,
                                      height: size.height * 0.16,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                Text(
                                  question.question,
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600,
                                    fontSize: size.width * 0.048,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: spacing),

                          ...List.generate(question.options.length, (index) {
                            final option = question.options[index];
                            final isCorrect =
                                index == question.correctIndex;
                            final isSelected =
                                index == quizProvider.selectedOption;

                            Color fillColor = AppColors.white;
                            if (quizProvider.answered) {
                              if (isCorrect) {
                                fillColor = AppColors.stroke1;
                              } else if (isSelected && !isCorrect) {
                                fillColor = AppColors.red;
                              }
                            } else if (isSelected) {
                              fillColor = AppColors.blacksoft;
                            }

                            return Padding(
                              padding:
                              EdgeInsets.only(bottom: spacing * 0.7),
                              child: GestureDetector(
                                onTap: () {
                                  quizProvider.selectOption(index);

                                  Future.delayed(
                                      const Duration(seconds: 1), () {
                                    if (!mounted) return;

                                    if (quizProvider.currentQuestionIndex <
                                        quizQuestions.length - 1) {
                                      quizProvider.nextQuestion();
                                    } else {
                                      _goToResult();
                                    }
                                  });
                                },
                                child: Container(
                                  width: boxWidth,
                                  padding: EdgeInsets.symmetric(
                                    vertical: size.height * 0.018,
                                    horizontal: size.width * 0.04,
                                  ),
                                  decoration: BoxDecoration(
                                    color: fillColor,
                                    borderRadius: BorderRadius.circular(
                                        size.width * 0.03),
                                    border: Border.all(
                                      color: AppColors.stroke1,
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: size.width * 0.08,
                                        height: size.width * 0.08,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(6),
                                          border: Border.all(
                                              color: AppColors.stroke1),
                                        ),
                                        child: Text(
                                          String.fromCharCode(65 + index),
                                          style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.bold,
                                            fontSize: size.width * 0.04,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: size.width * 0.03),
                                      Expanded(
                                        child: Text(
                                          option,
                                          style: GoogleFonts.poppins(
                                            fontSize: size.width * 0.042,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
