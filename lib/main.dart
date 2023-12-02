import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:offlineengvandictionary/online_dictionary/business/respository.dart';
import 'package:offlineengvandictionary/online_dictionary/config/configs.dart';
import 'package:offlineengvandictionary/views/Home.dart';
import 'package:offlineengvandictionary/views/MalayalamToEnglish.dart';
import 'package:offlineengvandictionary/views/WordDetails.dart';

void main() async {
  await Hive.initFlutter().then((value) async {
    await Hive.openBox<String>(AppConfigs.strings.recentsBox);
  });
  runApp(RepositoryProvider(
    create: (context) => DictionaryRepository.instance,
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'English',
      routes: {
        '/': (context) => const Home(title: 'English Dictionary'),
        '/malayalam': (context) =>
            const MalayalamToEnglish(title: 'Chewa to English Dictionary'),
        '/word-details': (context) => const WordDetails()
      },
      initialRoute: '/',
      theme: ThemeData(
        primaryColor: Colors.deepPurple[400],
        primaryColorLight: Colors.deepPurple[50],
        hintColor: Colors.white,
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.purple)
            .copyWith(error: Colors.red[600]),
      ),
    );
  }
}
