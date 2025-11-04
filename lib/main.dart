import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:veggiez/config/routes.dart';
import 'package:veggiez/theme/colors.dart';
import 'package:veggiez/provider/quiz_provider.dart';

void main() {
  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => const VeggizApp(),
    ),
  );
}

class VeggizApp extends StatelessWidget {
  const VeggizApp({super.key});

  @override
  Widget build(BuildContext context) {
    final router = createRouter();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => QuizProvider()),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Veggiez',
        locale: DevicePreview.locale(context),
        builder: DevicePreview.appBuilder,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
          useMaterial3: true,
        ),
        routerConfig: router,
      ),
    );
  }
}
