import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DictionaryDatabase {
  late Database? _database;

  Future<void> initializeDatabase() async {
    _database = await openDatabase(
      join(await getDatabasesPath(), 'dictionary.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE dictionary(word TEXT NOT NULL, definition TEXT NOT NULL)',
        );
      },
      version: 1,
    );
  }

  Future<void> insertWord(String word, String definition) async {
    await _database?.insert(
      'chewa',
      {'word': word, 'definition': definition},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Map<String, dynamic>>> getAllWords() async {
    return await _database!.query('dictionary');
  }

  Future<void> updateWord(String word, String newDefinition) async {
    await _database!.update(
      'chewa',
      {'definition': newDefinition},
      where: 'word = ?',
      whereArgs: [word],
    );
  }

  Future<void> deleteWord(String word) async {
    await _database!.delete(
      'chewa',
      where: 'word = ?',
      whereArgs: [word],
    );
  }
}

class DictionaryWidget extends StatefulWidget {
  @override
  _DictionaryWidgetState createState() => _DictionaryWidgetState();
}

class _DictionaryWidgetState extends State<DictionaryWidget> {
  final DictionaryDatabase _database = DictionaryDatabase();
  final TextEditingController _wordController = TextEditingController();
  final TextEditingController _definitionController = TextEditingController();
  final TextEditingController _updateWordController = TextEditingController();
  final TextEditingController _newDefinitionController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    _initializeDatabase();
  }

  Future<void> _initializeDatabase() async {
    await _database.initializeDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dictionary App'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _wordController,
                decoration: InputDecoration(labelText: 'Word'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _definitionController,
                decoration: InputDecoration(labelText: 'Definition'),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                _addWord(_wordController.text, _definitionController.text);
              },
              child: Text('Add Word'),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _updateWordController,
                decoration: InputDecoration(labelText: 'Word to Update'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _newDefinitionController,
                decoration: InputDecoration(labelText: 'New Definition'),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                _updateWord(
                    _updateWordController.text, _newDefinitionController.text);
              },
              child: Text('Update Word'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _addWord(String word, String definition) async {
    await _database.insertWord(word, definition);
    _wordController.clear();
    _definitionController.clear();
    setState(() {});
  }

  Future<void> _updateWord(String word, String newDefinition) async {
    await _database.updateWord(word, newDefinition);
    _updateWordController.clear();
    _newDefinitionController.clear();
    setState(() {});
  }
}
