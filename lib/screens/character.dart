import 'package:flutter/material.dart';
import 'package:veggiez/theme/colors.dart';
import 'package:veggiez/widgets/background.dart';
import 'package:veggiez/widgets/button.dart';

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
    final bool isButtonEnabled = selectedVeggie != null;
    final size = MediaQuery.of(context).size;
    final double cardWidth = size.width * 0.7;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: Stack(
        children: [
          const HomeBackground2(),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: Column(
                children: [
                  const SizedBox(height: 50),

                  Stack(
                    children: [
                      Text(
                        'Choose Your\nVeggie',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Harlow',
                          fontSize: 55,
                          height: 1.1,
                          foreground: Paint()
                            ..style = PaintingStyle.stroke
                            ..strokeWidth = 2
                            ..color = AppColors.stroke1,
                        ),
                      ),
                      const Text(
                        'Choose Your\nVeggie',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Harlow',
                          fontSize: 55,
                          height: 1.1,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),

                const SizedBox(height: 60),

                  Center(
                    child: SizedBox(
                      width: cardWidth,
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: veggies.length,
                        gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 25,
                          crossAxisSpacing: 25,
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
                              duration: const Duration(milliseconds: 200),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? AppColors.primary
                                    : AppColors.white,
                                borderRadius: BorderRadius.circular(25),
                                border: Border.all(
                                  color: AppColors.stroke1,
                                  width: 2,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.black.withOpacity(0.1),
                                    blurRadius: 4,
                                    offset: const Offset(2, 2),
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: Image.asset(
                                  veggie['image']!,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),

                  const Spacer(),

                  AbsorbPointer(
                    absorbing: !isButtonEnabled,
                    child: Opacity(
                      opacity: isButtonEnabled ? 1.0 : 0.5,
                      child: CustomButton(
                        text: "Next",
                        isPrimary: true,
                        onPressed: () {
                          if (isButtonEnabled) {
                            final selectedVeggieData = veggies[selectedVeggie!];
                            Navigator.pushNamed(
                              context,
                              '/enterName',
                              arguments: selectedVeggieData,
                            );
                          }
                        },
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
