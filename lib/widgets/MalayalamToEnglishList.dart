import 'dart:async';

import 'package:flutter/material.dart';
import 'package:offlineengvandictionary/database/db.dart';
import 'package:offlineengvandictionary/widgets/Loading.dart';

class MalayalamToEnglishList extends StatefulWidget {
  const MalayalamToEnglishList({Key? key}) : super(key: key);

  @override
  _MalayalamToEnglishListState createState() => _MalayalamToEnglishListState();
}

class _MalayalamToEnglishListState extends State<MalayalamToEnglishList> {
  // ignore: close_sinks
  StreamController streamController = StreamController();

  List refactoredData = [];

  getDictionaryData() async {
    return await DictionaryDatabase.instance.getChewaWordsWithDefinition();
  }

  filterWords(String text, List data) {
    // Convert the search text to lowercase for case-insensitive matching
    String searchText = text.toLowerCase();

    // Use a more flexible search strategy: check if the word contains the search text
    List filteredWords = data
        .where((item) => item['word'].toLowerCase().contains(searchText))
        .toList();

    streamController.sink.add(filteredWords);
  }

  refactorData(List dictionaryData) {
    List list;
    dictionaryData.forEach((item) {
      list = item['word'].split(";");
      list.forEach((element) {
        refactoredData.add({"word": element, "definition": item['definition']});
      });
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getDictionaryData(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            refactorData(snapshot.data);
            return Column(
              children: [
                TextField(
                  onChanged: (text) {
                    filterWords(text, refactoredData);
                  },
                  decoration: InputDecoration(
                      fillColor: Theme.of(context).primaryColorLight,
                      filled: true,
                      border: const OutlineInputBorder(),
                      hintText: 'Search..'),
                ),
                Expanded(
                  child: StreamBuilder(
                      stream: streamController.stream,
                      initialData: refactoredData,
                      builder: (context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                    shape: Border.all(
                                        color: Theme.of(context).primaryColor,
                                        width: 0.1),
                                    title: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(snapshot.data[index]['word']),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 8.0),
                                          child: Text(
                                            snapshot.data[index]['definition'],
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      ],
                                    ));
                              });
                        }
                        return const Loading();
                      }),
                ),
              ],
            );
          }
          return const Loading();
        });
  }
}
