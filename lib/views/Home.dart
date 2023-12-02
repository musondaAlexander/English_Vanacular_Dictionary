import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:offlineengvandictionary/online_dictionary/app.dart';
import 'package:offlineengvandictionary/online_dictionary/business/respository.dart';
import 'package:offlineengvandictionary/online_dictionary/config/configs.dart';
import 'package:offlineengvandictionary/online_dictionary/presentation/bloc/dictionary_bloc.dart';
import 'package:offlineengvandictionary/views/about.dart';
import 'package:offlineengvandictionary/widgets/EnglishToMalayalamList.dart';
import 'package:offlineengvandictionary/widgets/crud.dart';

class Home extends StatefulWidget {
  const Home({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Padding(
          padding: const EdgeInsets.only(top: 38.0),
          child: Column(
            children: [
              buildDrawerOption(context, "Online English Dictionary", () {
                // Navigator.of(context).pop();
                main();
              }),
              // const SizedBox(height: 3),
              buildDrawerOption(context, "English", () {
                Navigator.of(context).pop();
              }),
              // const SizedBox(height: 3),
              buildDrawerOption(context, "Chewa to English", () {
                Navigator.of(context).pop();
                Navigator.pushNamed(context, '/malayalam');
              }),
              // const SizedBox(height: 2),
              buildDrawerOption(context, "About", () {
                Navigator.of(context).pop(); // Close the drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AboutPage()),
                );
              }),
              buildDrawerOption(context, "Add word", () {
                Navigator.of(context).pop(); // Close the drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DictionaryWidget()),
                );
              }),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        // leading: const Icon(Icons.book),
        title: Row(
          children: [
            const Icon(Icons.book),
            const SizedBox(width: 10),
            Text(widget.title),
          ],
        ),
        // Text(widget.title),
      ),
      body: const EnglishToMalayalamList(),
    );
  }

  Widget buildDrawerOption(
      BuildContext context, String text, VoidCallback onTap) {
    return Material(
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          height: 50,
          margin: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(26),
            color: Theme.of(context).primaryColorLight,
          ),
          child: Align(
            alignment: Alignment.center,
            child: Text(
              text,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ),
    );
  }
}

void main() async {
  await Hive.initFlutter().then((value) async {
    await Hive.openBox<String>(AppConfigs.strings.recentsBox);
  });
  runApp(RepositoryProvider(
    create: (context) => DictionaryRepository.instance,
    child: const MyApp(),
  ));
}

// class to launch the online dictionary.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DictionaryBloc>(
      create: (context) => DictionaryBloc(context.read<DictionaryRepository>()),
      child: const Dictionary(),
    );
  }
}
