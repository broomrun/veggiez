import 'package:flutter/material.dart';
import 'package:veggiez/theme/colors.dart';
import 'package:veggiez/widgets/background.dart';
import 'package:veggiez/widgets/button.dart';
import 'package:google_fonts/google_fonts.dart';

class EnterNamePage extends StatefulWidget {
  const EnterNamePage({super.key});

  @override
  State<EnterNamePage> createState() => _EnterNamePageState();
}

class _EnterNamePageState extends State<EnterNamePage> {
  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final veggie =
    ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: Stack(
        children: [
          const HomeBackground(),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, size: 28),
                    color: AppColors.black,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),

                  const Spacer(),

                  Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      width: size.width * 0.75,
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(20),
                          border:
                          Border.all(color: AppColors.stroke1, width: 2),
                        ),
                        padding: const EdgeInsets.all(30),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: AppColors.primary,
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                    color: AppColors.stroke1, width: 2),
                              ),
                              padding: const EdgeInsets.all(25),
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 25),
                              child: Image.asset(
                                veggie['image']!,
                                height: 150,
                              ),
                            ),

                            const SizedBox(height: 20),

                            Container(
                              margin:
                              const EdgeInsets.symmetric(horizontal: 25),
                              child: TextField(
                                controller: _nameController,
                                textAlign: TextAlign.left,
                                decoration: InputDecoration(
                                  hintText: "Enter your name",
                                  hintStyle: GoogleFonts.poppins(
                                    color: AppColors.blacksoft,
                                    fontSize: 14,
                                  ),
                                  filled: true,
                                  fillColor: AppColors.white,
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),

                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: const BorderSide(
                                      color: AppColors.stroke1,
                                      width: 2,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: const BorderSide(
                                      color: AppColors.stroke1,
                                      width: 2.5,
                                    ),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: const BorderSide(
                                      color: AppColors.stroke1,
                                      width: 2,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const Spacer(),

                  CustomButton(
                    text: "Next",
                    isPrimary: false,
                    onPressed: () {
                      if (_nameController.text.isNotEmpty) {
                        Navigator.pushNamed(context, '/quiz');
                      }
                    },
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
