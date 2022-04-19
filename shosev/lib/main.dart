import 'package:flutter/material.dart';
import 'assets/design.dart' as design;
import 'maps.dart' as maps;
// import 'search.dart' as search;
import 'appbar.dart' as appbar;
import 'shopProfile.dart' as shopProfile;
import 'serviceProfile.dart' as serviceProfile;
import 'splash.dart' as splash;
import 'nav_drawer.dart' as nav;
import 'about.dart' as about;
import 'all_shops_services.dart' as all_shops_services;
import 'dart:math';
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
      theme: design.myThemeData,
      home: const splash.Splash(),
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
      // home: shopProfile.ShopProfilePage(shopName: "My Shop Name", rating: 3.5, joined: "Feb 22", reviews: 350, contacted: 1000, aboutUs: generateRandomString(1000),),
      // home: serviceProfile.ServiceProfilePage(shopName: "My Service Name", rating: 3.5, joined: "Feb 22", reviews: 350, contacted: 1000, aboutUs: generateRandomString(1000),),
      // home: about.MyAboutUs(title: "About Us", aboutUs: generateRandomString(1000))
      // home: all_shops_services.All_Shops_Services(title: "My Services", aboutUs: generateRandomString(5000)),
    );
  }

  String generateRandomString(int len) {
    var r = Random();
    const _chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    return List.generate(len, (index) => _chars[r.nextInt(_chars.length)])
        .join();
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool fab = true;
  String result = "";
  bool showResult = false;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isSwitched = false;

  void _clear() {
    appbar.fadeSystemUI();
    FocusManager.instance.primaryFocus?.unfocus();
  }

  void _myChats() {
    setState(() {
      _clear();
    });
  }

  void _myLocation() {
    setState(() {
      _clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    // fab = MediaQuery.of(context).viewInsets.bottom != 0; //keyboard is open or not

    fabFn(bool ans) {
      setState(() {
        fab = ans;
      });
    }

    showResultDropbox(String res) {
      setState(() {
        result = res;
        showResult = true;
      });
    }

    hideResultDropbox() {
      setState(() {
        result = "";
        showResult = false;
      });
    }

    // Home Page
    // |____empty Appbar
    // |____Maps
    // |____Appbar
    // |____Search bar
    // |____Floating buttons
    return Scaffold(
        key: _scaffoldKey,
        endDrawer: const nav.signindrawer1(),
        body: Stack(
          children: <Widget>[
            Column(
              children: [
                // empty Appbar
                const SizedBox(
                  height: 146.0,
                ),
                // Maps
                Expanded(
                    child: GestureDetector(
                  onTap: () {
                    // _clear;
                    hideResultDropbox();
                    fabFn(true);
                  },
                  child: Container(
                      constraints: const BoxConstraints.expand(),
                      child: const maps.MyMap()),
                )),
              ],
            ),
            // Appbar
            Container(
              height: 146.0,
              color: const Color(0xFFFFC804),
              child: appbar.AppBarContents(
                title: widget.title,
                scaffoldKey: _scaffoldKey,
              ),
            ),
            // Search bar
            Positioned(
              top: 124,
              right: 30,
              left: 30,
              child: MySearch(
                history: [
                  "Place 1",
                  "Place 2",
                  "Place 3",
                  "Place 4",
                  "Place 5",
                  "Place 6"
                ],
                history_loc: [
                  "Sadar Point",
                  "Jawal Point",
                  "Rajdan Chowk",
                  "Sretha St",
                  "Sadar Point",
                  "Jawal Point"
                ],
                fabFn: fabFn,
                showResultDropbox: showResultDropbox,
                hideResultDropbox: hideResultDropbox,
              ),
            ),
            // Scrollable Dropbox
            Visibility(
              visible: showResult,
              child: Container(
                margin: const EdgeInsets.only(
                    left: 17, right: 17, bottom: 0, top: 343),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0)),
                  border: Border(
                      top: BorderSide(color: Color(0xFFFFC804), width: 3.0),
                      left: BorderSide(color: Color(0xFFFFC804), width: 3.0),
                      right: BorderSide(color: Color(0xFFFFC804), width: 3.0),
                      bottom: BorderSide(color: Color(0xFFFFC804), width: 3.0)),
                  boxShadow: [
                    BoxShadow(
                        color: Color(0xFFAAAAAA),
                        blurRadius: 4.0,
                        offset: Offset(0, 4),
                        spreadRadius: 3.0)
                  ],
                ),
                child: ListView(
                  children: [
                    Text(result),
                  ],
                ),
              ),
            )
          ],
        ),
        // Floating buttons
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Visibility(
          visible: fab,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                FloatingActionButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const all_shops_services.All_Shops_Services(
                                title: "My Chats",
                                aboutUs: "Sujit Soren",
                              )),
                    );
                  },
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
          ),
        ));
  }
}

class MySearch extends StatefulWidget {
  MySearch(
      {Key? key,
      required this.history,
      required this.history_loc,
      required this.fabFn,
      required this.showResultDropbox,
      required this.hideResultDropbox})
      : super(key: key);

  final List<String> history;
  final List<String> history_loc;

  Function fabFn;
  Function showResultDropbox;
  Function hideResultDropbox;

  @override
  State<MySearch> createState() => _MySearchState();
}

class _MySearchState extends State<MySearch> {
  bool _short = true;
  final TextEditingController _controller = TextEditingController();
  Widget divider() {
    return const Divider(
      height: 2,
    );
  }

  void _extend() {
    setState(() {
      _short = false;
      widget.hideResultDropbox();
      widget.fabFn(false);
    });
  }

  void _shrink() {
    setState(() {
      _short = true;
      appbar.fadeSystemUI();
      FocusManager.instance.primaryFocus?.unfocus();
    });
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final historyWidgets = <Widget>[];
    for (int i = 0; i < widget.history.length; i++) {
      historyWidgets.add(divider());
      historyWidgets.add(GestureDetector(
        onTap: () {},
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              widget.history[i],
              style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.normal,
                  color: Color(0xFF333333),
                  letterSpacing: -0.5),
            ),
            const Spacer(),
            Text(
              widget.history_loc[i],
              style: const TextStyle(
                  fontSize: 11.0,
                  fontStyle: FontStyle.italic,
                  color: Color(0xFF333333),
                  letterSpacing: -0.5),
            ),
          ],
        ),
      ));
    }
    return Container(
        height: _short ? 40 : 169,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(23.0)),
          boxShadow: [
            BoxShadow(
              color: Color(0xFFAAAAAA),
              blurRadius: 4.0,
              offset: Offset(0, 4),
            )
          ],
        ),
        child: Column(
          children: [
            SizedBox(
              height: 40,
              child: TextField(
                controller: _controller,
                style: const TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF333333),
                    letterSpacing: -0.5),
                cursorColor: const Color(0xFF333333),
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.go,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                      onPressed: () {
                        // setState(() {
                        if (!_short) {
                          widget.hideResultDropbox();
                          widget.fabFn(true);
                          _controller.clear();
                          _shrink();
                        } else {
                          _extend();
                        }
                        // });
                      },
                      icon: Icon(
                        (_short ? Icons.search : Icons.close),
                        color: const Color(0xFFD1D1D1),
                      )),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.fromLTRB(17, 7, 13, 2),
                  hintText: "Search...",
                  hintStyle: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.normal,
                      color: Color(0xFFD1D1D1),
                      letterSpacing: -0.5),
                ),
                onTap: _extend,
                onSubmitted: (String query) {
                  widget.fabFn(false);
                  widget.showResultDropbox(_controller.text);
                  _controller.clear();
                  _shrink();
                },
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.only(left: 17, right: 13),
                children: historyWidgets,
              ),
            )
          ],
        ));
  }
}
