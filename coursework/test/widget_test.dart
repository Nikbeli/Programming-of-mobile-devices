import 'dart:ui';
import 'package:candystore/data/repositories/candy_repository.dart';
import 'package:candystore/models/home_data.dart';
import 'package:candystore/presentation/bloc/home_bloc/home_bloc.dart';
import 'package:candystore/presentation/bloc/like_bloc/like_bloc.dart';
import 'package:candystore/presentation/bloc/locale_bloc/locale_bloc.dart';
import 'package:candystore/presentation/pages/home_page/home_page.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

// Мок-класс для Dio
class MockCandyRepository extends Mock implements CandyRepository {}

// MockDio class
class MockDio extends Mock implements Dio {}

void main() {
  testWidgets('MyApp widget test', (WidgetTester tester) async {
    // Mock the CandyRepository and other necessary components
    final candyRepository = MockCandyRepository();
    final dio = MockDio();

    // Mocking the get request and returning a response
    when(dio.get(
      '/api/Beans',
      queryParameters: {'pageIndex': '1', 'pageSize': '10'},
    )).thenAnswer(
          (_) async => Response(
        requestOptions: RequestOptions(path: '/api/Beans'),
        data: {
          'data': [
            // Пример данных без meta
            {
              'beanId': 1,
              'flavorName': '7Up',
              'description': 'The Refreshing And Crisp Flavor Of Lemon Lime Soda.',
              'imageUrl': 'https://cdn-tp1.mozu.com/9046-m1/cms/files/ab692677-5471-4863-91a8-659363ae4cc4',
              'groupName': ['Jelly Belly Official Flavors'],
            },
            // ... другие элементы
          ],
        },
        statusCode: 200,
      ),
    );

    // Mocking the CandyRepository to use the mocked Dio
    when(candyRepository.loadData(page: 1, pageSize: 10)).thenAnswer(
          (_) async => HomeData(
        // mock data for HomeData
      ),
    );

    await tester.pumpWidget(
      BlocProvider<LocaleBloc>(
        create: (_) => LocaleBloc(Locale('en')),
        child: RepositoryProvider<CandyRepository>(
          create: (_) => candyRepository,
          child: BlocProvider<LikeBloc>(
            create: (_) => LikeBloc(),
            child: BlocProvider<HomeBloc>(
              create: (_) => HomeBloc(candyRepository),
              child: const MyHomePage(title: "CandyStore"),
            ),
          ),
        ),
      ),
    );

    // Trigger a rebuild after any state changes
    await tester.pumpAndSettle();

    // Test UI behavior here, e.g., check for widget presence
    expect(find.text('CandyStore'), findsOneWidget);
  });
}
