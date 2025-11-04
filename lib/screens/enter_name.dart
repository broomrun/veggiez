import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:veggiez/theme/colors.dart';
import 'package:veggiez/widgets/background.dart';
import 'package:veggiez/widgets/button.dart';
import 'package:veggiez/widgets/character_card.dart';

class EnterNamePage extends StatefulWidget {
  const EnterNamePage({super.key});

  @override
  State<EnterNamePage> createState() => _EnterNamePageState();
}

class _EnterNamePageState extends State<EnterNamePage> {
  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final veggie = GoRouterState.of(context).extra as Map<String, String>?;

    final size = MediaQuery.of(context).size;
    final horizontalPadding = size.width * 0.08;
    final verticalPadding = size.height * 0.02;
    final iconSize = size.width * 0.08;
    final space = size.height * 0.03;

    return Scaffold(
      backgroundColor: AppColors.white,
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          const HomeBackground(),

          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: verticalPadding,
              ),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      icon: Icon(Icons.arrow_back, size: iconSize),
                      color: AppColors.black,
                      onPressed: () => context.pop(),
                    ),
                  ),

                  SizedBox(height: space * 0.5),

                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: size.height * 0.65,
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CharacterCard(
                                imagePath: veggie?['image'] ?? '',
                                name: '',
                                controller: _nameController,
                                showTextField: true,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: space),
                  CustomButton(
                    text: "Next",
                    isPrimary: false,
                    onPressed: () {
                      final name = _nameController.text.trim();
                      if (name.isNotEmpty) {
                        context.push(
                          '/quiz',
                          extra: {
                            'name': name,
                            'image': veggie?['image'] ?? '',
                          },
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "Please enter your name first!",
                              style: GoogleFonts.poppins(),
                            ),
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: AppColors.primary,
                          ),
                        );
                      }
                    },
                  ),

                  SizedBox(height: space * 0.5),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
