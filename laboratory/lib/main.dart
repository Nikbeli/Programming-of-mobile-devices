import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pmd/components/locale/l10n/app_locale.dart';
import 'package:pmd/data/repositories/mock_repository.dart';
import 'package:pmd/data/repositories/potter_repository.dart';
import 'package:pmd/presentation/bloc/bloc.dart';
import 'package:pmd/presentation/home_page/home_page.dart';
import 'package:pmd/presentation/home_page/like_bloc/like_bloc.dart';
import 'package:pmd/presentation/home_page/locale_bloc/locale_bloc.dart';
import 'package:pmd/presentation/home_page/locale_bloc/locale_state.dart';

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
            home: RepositoryProvider<PotterRepository>(
              lazy: true,
              create: (_) => PotterRepository(),
              child: BlocProvider<LikeBloc>(
                lazy: false,
                create: (context) => LikeBloc(),
                child: BlocProvider<HomeBloc>(
                    lazy: false,
                    create: (context) => HomeBloc(context.read<PotterRepository>()),
                    child: const MyHomePage(
                        title: 'Laboratory 7: Internationalization and Localization')),
              ),
            ),
          );
        },
      ),
    );
  }
}
