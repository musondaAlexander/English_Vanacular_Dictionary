// unsounding dart null safety

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:offlineengvandictionary/database/db.dart';
import 'package:offlineengvandictionary/widgets/Loading.dart';

// ignore: unused_import

class EnglishToMalayalamList extends StatefulWidget {
  const EnglishToMalayalamList({Key? key}) : super(key: key);

  @override
  _EnglishToMalayalamListState createState() => _EnglishToMalayalamListState();
}

class _EnglishToMalayalamListState extends State<EnglishToMalayalamList> {
  // ignore: close_sinks
  StreamController streamController = StreamController();

  getDictionaryData() async {
    return await DictionaryDatabase.instance.getEnglishWords();
  }

  filterWords(String text, List data) {
    List filteredWords =
        data.where((item) => item['word'].startsWith(text)).toList();
    streamController.sink.add(filteredWords);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getDictionaryData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            dynamic data = snapshot.data;
            return Column(
              children: [
                TextField(
                  onChanged: (text) {
                    String capitalizedText = capitalize(text);
                    filterWords(capitalizedText, data);
                  },
                  decoration: InputDecoration(
                      fillColor: Theme.of(context).primaryColorLight,
                      filled: true,
                      border: OutlineInputBorder(),
                      hintText: 'Search..'),
                ),
                Expanded(
                  child: StreamBuilder(
                      stream: streamController.stream,
                      initialData: snapshot.data,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          dynamic data = snapshot.data;
                          return ListView.builder(
                              itemCount: data.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, '/word-details',
                                          arguments: data[index]['word']);
                                    },
                                    shape: Border.all(
                                        color: Theme.of(context).primaryColor,
                                        width: 0.1),
                                    title: Text(data[index]['word']));
                              });
                        }
                        return Loading();
                      }),
                ),
              ],
            );
          }
          return Loading();
        });
  }

  String capitalize(String input) {
    if (input == null || input.isEmpty) {
      return input;
    }
    return input[0].toUpperCase() + input.substring(1);
  }
}
