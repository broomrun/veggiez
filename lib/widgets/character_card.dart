import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:veggiez/theme/colors.dart';

class CharacterCard extends StatelessWidget {
  final String imagePath;
  final String name;
  final TextEditingController? controller;
  final bool showTextField;

  const CharacterCard({
    super.key,
    required this.imagePath,
    required this.name,
    this.controller,
    this.showTextField = false,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    return Center(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.02),
            width: width * 0.75,
            padding: EdgeInsets.all(width * 0.06),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(width * 0.05),
              border: Border.all(color: AppColors.stroke1, width: width * 0.005),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(width * 0.037),
                    border: Border.all(color: AppColors.stroke1, width: width * 0.005),
                  ),
                  padding: EdgeInsets.all(width * 0.048),
                  child: Image.asset(imagePath, height: height * 0.18, fit: BoxFit.contain),
                ),
            SizedBox(height: height * 0.02),

            showTextField
                ? TextField(
              controller: controller,
              style: GoogleFonts.poppins(fontSize: width * 0.04, color: AppColors.black),
              decoration: InputDecoration(
                hintText: "Enter your name",
                hintStyle: GoogleFonts.poppins(color: AppColors.blacksoft),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(width * 0.03),
                ),
              ),
            )
                : Text(
              name,
              style: GoogleFonts.poppins(
                fontSize: width * 0.04,
                fontWeight: FontWeight.bold,
                color: AppColors.black,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),

    ),
    );
  }

}
