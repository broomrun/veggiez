import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:veggiez/theme/colors.dart';
import 'package:veggiez/widgets/background.dart';
import 'package:veggiez/data/dummy.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int currentQuestionIndex = 0;
  int? selectedOption;
  bool answered = false;
  late Timer timer;
  int secondsLeft = 10;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondsLeft > 0) {
        setState(() => secondsLeft--);
      } else {
        showAnswerAndNext();
      }
    });
  }

  void showAnswerAndNext() {
    if (!answered) {
      setState(() {
        answered = true;
        selectedOption = -1;
      });
    }
    Future.delayed(const Duration(seconds: 1), nextQuestion);
  }

  void nextQuestion() {
    if (currentQuestionIndex < quizQuestions.length - 1) {
      setState(() {
        currentQuestionIndex++;
        selectedOption = null;
        answered = false;
        secondsLeft = 10;
      });
    } else {
      timer.cancel();
    }
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  void selectOption(int index) {
    if (answered) return;
    setState(() {
      selectedOption = index;
      answered = true;
    });
    Future.delayed(const Duration(seconds: 1), nextQuestion);
  }

  @override
  Widget build(BuildContext context) {
    final question = quizQuestions[currentQuestionIndex];
    double progress = (currentQuestionIndex + 1) / quizQuestions.length;
    double boxWidth = MediaQuery.of(context).size.width * 0.8;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: Stack(
        children: [
          const HomeBackground(),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, size: 28),
                      color: AppColors.black,
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),

                  LayoutBuilder(
                    builder: (context, constraints) {
                      final double barWidth = constraints.maxWidth * 0.9;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: barWidth,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: AppColors.stroke1, width: 2),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: LinearProgressIndicator(
                                value: progress,
                                backgroundColor: AppColors.white,
                                color: AppColors.primary,
                                minHeight: 12,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          // question yang keberapa dan timer
                          SizedBox(
                            width: barWidth,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Question ${currentQuestionIndex + 1} of ${quizQuestions.length}",
                                  style: GoogleFonts.poppins(
                                    fontSize: 15,
                                    color: AppColors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "00:${secondsLeft.toString().padLeft(2, '0')}",
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.bold,
                                    color: secondsLeft <= 5
                                        ? AppColors.red
                                        : AppColors.black,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),

                  const Spacer(),

                  Center(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: boxWidth,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(16),
                              border:
                              Border.all(color: AppColors.stroke1, width: 2),
                            ),
                            child: Column(
                              children: [
                                if (question.image != null)
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    child: Image.asset(
                                      question.image!,
                                      height: 100,
                                    ),
                                  ),
                                Text(
                                  question.question,
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 25),

                          // Opsi jawaban
                          Column(
                            children: List.generate(question.options.length,
                                    (index) {
                                  final option = question.options[index];
                                  Color borderColor = AppColors.stroke1;
                                  Color fillColor = AppColors.white;

                                  if (answered) {
                                    if (index == question.correctIndex) {
                                      fillColor = AppColors.stroke1;
                                    } else if (index == selectedOption &&
                                        index != question.correctIndex) {
                                      fillColor = AppColors.red;
                                    }
                                  } else if (selectedOption == index) {
                                    fillColor = AppColors.blacksoft;
                                  }

                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 12),
                                    child: GestureDetector(
                                      onTap: () => selectOption(index),
                                      child: Container(
                                        width: boxWidth,
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 14, horizontal: 10),
                                        decoration: BoxDecoration(
                                          color: fillColor,
                                          borderRadius: BorderRadius.circular(12),
                                          border: Border.all(
                                              color: borderColor, width: 2),
                                        ),
                                        child: Row(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              width: 35,
                                              height: 35,
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
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 10),
                                            Expanded(
                                              child: Text(
                                                option,
                                                style: GoogleFonts.poppins(
                                                    fontSize: 16),
                                                softWrap: true,
                                                overflow: TextOverflow.visible,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
