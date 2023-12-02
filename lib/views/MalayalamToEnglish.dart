import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:offlineengvandictionary/online_dictionary/app.dart';
import 'package:offlineengvandictionary/online_dictionary/business/respository.dart';
import 'package:offlineengvandictionary/online_dictionary/config/configs.dart';
import 'package:offlineengvandictionary/online_dictionary/presentation/bloc/dictionary_bloc.dart';
import 'package:offlineengvandictionary/views/about.dart';
import 'package:offlineengvandictionary/widgets/MalayalamToEnglishList.dart';

class MalayalamToEnglish extends StatefulWidget {
  const MalayalamToEnglish({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MalayalamToEnglishState createState() => _MalayalamToEnglishState();
}

class _MalayalamToEnglishState extends State<MalayalamToEnglish> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
          child: Padding(
        padding: const EdgeInsets.only(top: 38.0),
        child: Column(
          children: [
            Material(
              child: InkWell(
                onTap: () {
                  main();
                  // Navigator.of(context).pop();
                  // Navigator.pushNamed(context, '/');
                },
                child: Container(
                  width: double.infinity,
                  height: 50,
                  margin: const EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(26),
                    color: Theme.of(context).primaryColorLight,
                  ),
                  child: const Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Online English Dictionary",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      )),
                ),
              ),
            ),
            Material(
              child: InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.pushNamed(context, '/');
                },
                child: Container(
                  width: double.infinity,
                  height: 50,
                  margin: const EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(26),
                    color: Theme.of(context).primaryColorLight,
                  ),
                  child: const Align(
                      alignment: Alignment.center,
                      child: Text(
                        "English to English",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      )),
                ),
              ),
            ),
            Material(
              child: InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(26),
                    color: Theme.of(context).primaryColorLight,
                  ),
                  child: const Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Chewa to English",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      )),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Material(
              child: InkWell(
                onTap: () {
                  Navigator.of(context).pop(); // Close the drawer
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AboutPage()),
                  );
                },
                child: Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(26),
                    color: Theme.of(context).primaryColorLight,
                  ),
                  child: const Align(
                      alignment: Alignment.center,
                      child: Text(
                        "About",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      )),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      )),
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: const MalayalamToEnglishList(),
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
