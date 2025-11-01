import 'package:flutter/material.dart';
import 'package:veggiez/theme/colors.dart';

class HomeBackground extends StatelessWidget {
  const HomeBackground({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Stack(
      children: [
        Container(
          color: AppColors.primary,
        ),

        Positioned(
          top: -size.height * 0.5,
          left: -size.width * 0.7,
          child: Container(
            height: size.width * 2,
            width: size.width * 2,
            decoration: BoxDecoration(
              color: AppColors.white,
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.stroke1,
                width: 2,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
