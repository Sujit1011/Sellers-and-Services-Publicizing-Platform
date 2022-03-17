import 'package:flutter/material.dart';
import 'assets/design.dart' as design;
import 'maps.dart' as maps;
import 'search.dart' as search;
import 'appbar.dart' as appbar;
// import 'licenses.dart' as lic;


void main() {

  // lic.lisences();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ShoSev',
      theme: 
      design.myThemeData,
      home: const MyHomePage(title: 'Flutter Demo Home Page'),

    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  void _myChats() {
    setState(() {
      appbar.fadeSystemUI();
      
    });
  }

  void _myLocation() {
    setState(() {
      appbar.fadeSystemUI();
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Column(
            children: [
              Container(
                height: 129.0,
                color: const Color(0xFFFFC804),
                child: appbar.AppBarContents(title: widget.title),
              ),
              Expanded(               
                child: Container(
                  constraints: const BoxConstraints.expand(),
                  child: const maps.MyMap()
                ),
              ),
            ],
          ),
          const Positioned(
            top: 107,
            right: 30,
            left: 30,
            child: search.MySearch(),
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            FloatingActionButton(
              onPressed: _myChats,
              tooltip: 'My Chats',
              child: const Icon(Icons.chat_bubble_rounded),
            ),
            FloatingActionButton(
              onPressed: _myLocation,
              tooltip: 'My Location',
              child: const Icon(Icons.gps_fixed_rounded),
            ),
          ],
        ),
      )
    );
  }
}