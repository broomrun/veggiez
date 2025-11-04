import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:veggiez/theme/colors.dart';
import 'package:veggiez/widgets/background.dart';
import 'package:veggiez/widgets/button.dart';
import 'package:veggiez/config/routes.dart';

class ChooseCharacterPage extends StatefulWidget {
  const ChooseCharacterPage({super.key});

  @override
  State<ChooseCharacterPage> createState() => _ChooseCharacterPageState();
}

class _ChooseCharacterPageState extends State<ChooseCharacterPage> {
  int? selectedVeggie;

  final List<Map<String, String>> veggies = [
    {'name': 'Carrot', 'image': 'assets/images/carrot.png'},
    {'name': 'Eggplant', 'image': 'assets/images/eggplant.png'},
    {'name': 'YellowPepper', 'image': 'assets/images/yellow_pepper.png'},
    {'name': 'RedPepper', 'image': 'assets/images/red_pepper.png'},
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool isButtonEnabled = selectedVeggie != null;

    final double titleFont = size.shortestSide * 0.12;
    final double cardRadius = size.width * 0.06;
    final double horizontalPadding = size.width * 0.08;
    final double topSpacing = size.height * 0.03;
    final double gridSpacing = size.height * 0.025;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: Stack(
        children: [
          const HomeBackground2(),

          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: topSpacing,
              ),
              child: Column(
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Stack(
                        children: [
                          Text(
                            'Choose Your\nVeggie',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Harlow',
                              fontSize: titleFont,
                              height: 0.85,
                              foreground: Paint()
                                ..style = PaintingStyle.stroke
                                ..strokeWidth = 2
                                ..color = AppColors.stroke1,
                            ),
                          ),
                          Text(
                            'Choose Your\nVeggie',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Harlow',
                              fontSize: titleFont,
                              height: 0.85,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: size.height * 0.03),
                    ],
                  ),

                  Expanded(
                    child: Center(
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          final double gridWidth =
                              constraints.maxWidth * 0.85;

                          return SizedBox(
                            width: gridWidth,
                            child: GridView.builder(
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              itemCount: veggies.length,
                              gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: gridSpacing,
                                crossAxisSpacing: gridSpacing,
                                childAspectRatio: 1,
                              ),
                              itemBuilder: (context, index) {
                                final veggie = veggies[index];
                                final isSelected = selectedVeggie == index;

                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedVeggie = index;
                                    });
                                  },
                                  child: AnimatedContainer(
                                    duration:
                                    const Duration(milliseconds: 200),
                                    decoration: BoxDecoration(
                                      color: isSelected
                                          ? AppColors.primary
                                          : AppColors.white,
                                      borderRadius:
                                      BorderRadius.circular(cardRadius),
                                      border: Border.all(
                                        color: AppColors.stroke1,
                                        width: 2,
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: AppColors.black
                                              .withValues(alpha: 0.1),
                                          blurRadius: 4,
                                          offset: const Offset(2, 2),
                                        ),
                                      ],
                                    ),
                                    child: Padding(
                                      padding:
                                      EdgeInsets.all(size.width * 0.05),
                                      child: Image.asset(
                                        veggie['image']!,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.only(top: size.height * 0.015),
                    child: AbsorbPointer(
                      absorbing: !isButtonEnabled,
                      child: Opacity(
                        opacity: isButtonEnabled ? 1.0 : 0.5,
                        child: CustomButton(
                          text: "Next",
                          isPrimary: true,
                          onPressed: () {
                            if (isButtonEnabled) {
                              final selectedVeggieData =
                              veggies[selectedVeggie!];
                              context.push(
                                AppRoutes.enterName,
                                extra: selectedVeggieData,
                              );
                            }
                          },
                        ),
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
