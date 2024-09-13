import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:intl/date_symbol_data_local.dart';
import 'package:mood_diary/blocs/mood_bloc/mood_diary_bloc.dart';
import 'package:showcaseview/showcaseview.dart';
import 'screens/home/home_page.dart';

void main() {

  initializeDateFormatting('ru', null).then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MoodDiaryBloc(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        home:ShowCaseWidget(
          builder : (context) => MyHomePage(title: 'Home'),
        ),
        locale: const Locale('ru'),
        
        supportedLocales: const [
          Locale('en'),
          Locale('ru'),
        ],
        localizationsDelegates: const [
          
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
      ),
    );
  }
}
