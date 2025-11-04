import 'package:flutter/material.dart';
import 'package:veggiez/theme/colors.dart';

class HomeBackground extends StatelessWidget {
  const HomeBackground({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SizedBox.expand(
      child: Stack(
        children: [
          Container(color: AppColors.primary),

          Align(
            alignment: Alignment.topCenter,
            child: CustomPaint(
              size: Size(size.width, size.height * 0.65),
              painter: VeggieCurvePainter(
                fillColor: AppColors.white,
                strokeColor: AppColors.stroke1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
class HomeBackground2 extends StatelessWidget {
  const HomeBackground2({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SizedBox.expand(
      child: Stack(
        children: [
          Container(color: AppColors.white),

          Align(
            alignment: Alignment.topCenter,
            child: CustomPaint(
              size: Size(size.width, size.height * 0.65),
              painter: VeggieCurvePainter(
                fillColor: AppColors.primary,
                strokeColor: AppColors.stroke1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class VeggieCurvePainter extends CustomPainter {
  final Color fillColor;
  final Color strokeColor;

  VeggieCurvePainter({
    required this.fillColor,
    required this.strokeColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paintFill = Paint()
      ..color = fillColor
      ..style = PaintingStyle.fill;

    final paintStroke = Paint()
      ..color = strokeColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5;

    final path = Path()
      ..moveTo(0, size.height * 0.65)
      ..quadraticBezierTo(
        size.width * 0.5, size.height * 0.45,
        size.width, size.height * 0.6,
      )
      ..lineTo(size.width, 0)
      ..lineTo(0, 0)
      ..close();

    canvas.drawPath(path, paintFill);
    canvas.drawPath(path, paintStroke);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
