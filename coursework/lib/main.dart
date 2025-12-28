import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:candystore/components/l10n/app_locale.dart';
import 'package:candystore/data/repositories/candy_repository.dart';
import 'package:candystore/presentation/bloc/home_bloc/home_bloc.dart';
import 'package:candystore/presentation/bloc/like_bloc/like_bloc.dart';
import 'package:candystore/presentation/bloc/locale_bloc/locale_bloc.dart';
import 'package:candystore/presentation/bloc/locale_bloc/locale_state.dart';
import 'package:candystore/presentation/pages/home_page/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LocaleBloc>(
      lazy: false,
      create: (context) => LocaleBloc(Locale(Platform.localeName)),
      child: BlocBuilder<LocaleBloc, LocaleState>(
        builder: (context, state) {
          return MaterialApp(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            locale: state.currentLocale,
            localizationsDelegates: AppLocale.localizationsDelegates,
            supportedLocales: AppLocale.supportedLocales,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.orangeAccent),
              useMaterial3: true,
            ),
            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Симуляция загрузки, после которой приложение перейдет на главный экран
    Future.delayed(const Duration(seconds: 3), () async {
      // Проверяем, что контекст все еще действителен
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => RepositoryProvider<CandyRepository>(
              lazy: true,
              create: (_) => CandyRepository(),
              child: BlocProvider<LikeBloc>(
                lazy: false,
                create: (context) => LikeBloc(),
                child: BlocProvider<HomeBloc>(
                  lazy: false,
                  create: (context) => HomeBloc(context.read<CandyRepository>()),
                  child: const MyHomePage(title: "CandyStore"),
                ),
              ),
            ),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Добавление изображения
            Image.asset(
              'assets/candy.png',
              width: 100, // Можно настроить размеры изображения
              height: 100,
            ),
            const SizedBox(height: 20), // Расстояние между изображением и текстом
            const Text(
              'Hello',
              style: TextStyle(
                // Убедитесь, что указали правильное название шрифта
                fontFamily: 'SanFrancisco',
                fontSize: 40,
                fontWeight: FontWeight.bold,
                // Добавление наклона (курсива)
                fontStyle: FontStyle.italic,
                color: Colors.orangeAccent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
