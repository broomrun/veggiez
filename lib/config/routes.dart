import 'package:go_router/go_router.dart';
import 'package:veggiez/provider/quiz_provider.dart';
import 'package:veggiez/screens/splash_screen.dart';
import 'package:veggiez/screens/homepage.dart';
import 'package:veggiez/screens/character.dart';
import 'package:veggiez/screens/enter_name.dart';
import 'package:veggiez/screens/quiz.dart';
import 'package:veggiez/screens/result.dart';
import 'package:provider/provider.dart';


class AppRoutes {
  static const String splash = '/';
  static const String home = '/home';
  static const String character = '/character';
  static const String enterName = '/enter-name';
  static const String quiz = '/quiz';
  static const String result = '/result';
}

GoRouter createRouter() {
  return GoRouter(
    initialLocation: AppRoutes.splash,
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: AppRoutes.home,
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: AppRoutes.character,
        builder: (context, state) => const ChooseCharacterPage(),
      ),
      GoRoute(
        path: AppRoutes.enterName,
        builder: (context, state) => const EnterNamePage(),
      ),
      GoRoute(
        path: AppRoutes.quiz,
        builder: (context, state) {
          final name = state.extra != null
              ? (state.extra as Map<String, String>)['name'] ?? ''
              : '';
          final image = state.extra != null
              ? (state.extra as Map<String, String>)['image'] ?? ''
              : '';

          return ChangeNotifierProvider(
            create: (_) => QuizProvider(),
            child: QuizPage(name: name, imagePath: image),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.result,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>? ?? {};
          final score = extra['score'] as int? ?? 0;
          final name = extra['name'] as String? ?? '';
          final imagePath = extra['imagePath'] as String? ?? '';
          return ResultPage(
            score: score,
            name: name,
            imagePath: imagePath,
          );
        },
      ),
    ],
  );
}
