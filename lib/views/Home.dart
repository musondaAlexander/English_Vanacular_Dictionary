import 'package:flutter/material.dart';
import 'package:offlineengvandictionary/widgets/EnglishToMalayalamList.dart';

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
              buildDrawerOption(context, "English", () {
                Navigator.of(context).pop();
              }),
              const SizedBox(height: 5),
              buildDrawerOption(context, "Chewa to English", () {
                Navigator.of(context).pop();
                Navigator.pushNamed(context, '/malayalam');
              }),
              const SizedBox(height: 10),
              buildDrawerOption(context, "About", () {
                Navigator.of(context).pop();
                // Add functionality for About
              }),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        title: Text(widget.title),
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
