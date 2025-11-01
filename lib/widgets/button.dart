import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:veggiez/theme/colors.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final double widthFactor;
  final double height;
  final bool isPrimary;
  final TextStyle? textStyle;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.widthFactor = 0.7,
    this.height = 50,
    this.isPrimary = true,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final backgroundColor = isPrimary ? AppColors.primary : AppColors.white;
    final textColor = AppColors.black;

    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 80),
        child: SizedBox(
          width: size.width * widthFactor,
          height: height,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: backgroundColor,
              elevation: 0,
              shadowColor: Colors.transparent,
              overlayColor: AppColors.stroke1.withValues(alpha: 0.1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: const BorderSide(
                  color: AppColors.stroke1,
                  width: 2,
                ),
              ),
            ),
            onPressed: onPressed,
            child: Text(
              text,
              style: textStyle ??
                  GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
