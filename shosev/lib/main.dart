import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shosev/appbar.dart' as appbar;
import 'package:shosev/assets/design.dart' as design;
import 'package:shosev/firebase_options.dart';
import 'package:shosev/licenses.dart' as lic;
import 'package:shosev/list_page.dart' as listpage;
import 'package:shosev/maps.dart' as maps;
import 'package:shosev/models/SS_User.dart';
import 'package:shosev/nav_drawer.dart' as nav;
import 'package:shosev/services/auth.dart';
import 'package:shosev/services/data_repository.dart';
import 'package:shosev/splash.dart' as splash;

Future<void> main() async {
  lic.lisences();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
  appbar.fadeSystemUI();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<SS_User?>.value(
      value: AuthService().user,
      initialData: null,
      child: MaterialApp(
        title: 'ShoSev',
        theme: design.myThemeData,
        home: const splash.Splash(),
        // home: const MyHomePage(title: 'Flutter Demo Home Page'),
        // home: shopProfile.ShopProfilePage(shopName: "My Shop Name", rating: 3.5, joined: "Feb 22", reviews: 350, contacted: 1000, aboutUs: generateRandomString(1000),),
        // home: serviceProfile.ServiceProfilePage(shopName: "My Service Name", rating: 3.5, joined: "Feb 22", reviews: 350, contacted: 1000, aboutUs: generateRandomString(1000),),
        // home: about.MyAboutUs(title: "About Us", aboutUs: generateRandomString(1000))
        // home: listpage.listpage(title: "My Services", aboutUs: generateRandomString(5000)),
        // home: const chat.Chat(name: "Shop Name", phoneNo: "+91 XXX XXX XXXX", address: "Address, XYZ Street",),
      )
    );
  }

  String generateRandomString(int len) {
    var r = Random();
    const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    return List.generate(len, (index) => _chars[r.nextInt(_chars.length)]).join();
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
  AuthService _authService = AuthService();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isSwitched = false;

  void _clear() {
    // appbar.fadeSystemUI();
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
    final user = Provider.of<SS_User?>(context);
    final DataRepository repository = DataRepository();
    // print(user);

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
        endDrawer: (user == null)?(nav.RegisterDrawer(authService: _authService,)):(nav.SignedInDrawer(authService: _authService)),
        // endDrawer: const nav.signindrawer1(businessmember: true),
        // endDrawer: nav.signupdrawer(),
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
                      child: const maps.MyMap()
                    ),
                  )
                ),
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
                history: const ["Place 1", "Place 2", "Place 3", "Place 4", "Place 5", "Place 6"],
                history_loc: const ["Sadar Point", "Jawal Point", "Rajdan Chowk", "Sretha St", "Sadar Point", "Jawal Point"],
                fabFn: fabFn,
                showResultDropbox: showResultDropbox,
                hideResultDropbox: hideResultDropbox,
              ),
            ),
            // Scrollable Dropbox
            Visibility(
              visible: showResult,
              child: Container(
                margin: const EdgeInsets.only(left: 17, right: 17, bottom: 0, top: 343),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0)),
                  border: Border(
                    top: BorderSide(color: Color(0xFFFFC804), width: 3.0),
                    left: BorderSide(color: Color(0xFFFFC804), width: 3.0),
                    right: BorderSide(color: Color(0xFFFFC804), width: 3.0),
                    bottom: BorderSide(color: Color(0xFFFFC804), width: 3.0)
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFFAAAAAA),
                      blurRadius: 4.0,
                      offset: Offset(0, 4),
                      spreadRadius: 3.0
                    )
                  ],
                ),
                child: StreamBuilder<QuerySnapshot>(
                  stream: repository.getStream_SS_Shop(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) return const CircularProgressIndicator();

                    return _buildSearchResultList(context, snapshot.data?.docs ?? []);
                  }
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
                          listpage.ListPage(
                            title: "My Chats",
                            username: "User Name",
                            phoneNo: "+91 xxxxx xxxxx",
                            isLeftFloattingButton: true,
                            isRightFloattingButton: false,
                            leftClick: () => {
                              Navigator.pop(context)
                            },
                            rightClick: () => {},
                            leftIcon: const Icon(Icons.chevron_left_rounded),
                            rightIcon: const Icon(Icons.chevron_right_rounded),
                            heroLeft: "chat_left",
                            heroRight: "chat_right",
                          )
                        ),
                    );
                  },
                  tooltip: 'My Chats',
                  heroTag: 'My Chats',
                  child: const Icon(Icons.chat_bubble_rounded),
                ),
                FloatingActionButton(
                  onPressed: _myLocation,
                  tooltip: 'My Location',
                  heroTag: 'My Location',
                  child: const Icon(Icons.gps_fixed_rounded),
                ),
              ],
            ),
          ),
        ));
  }

  Widget _buildSearchResultList(BuildContext context, List<DocumentSnapshot<Object?>> list) {
    return ListView(
      padding: const EdgeInsets.all(18),
      children: list.map((data) => _buildSearchResultItem(context, data)).toList(),
    );
  }

  Widget _buildSearchResultItem(BuildContext context, DocumentSnapshot<Object?> data) {
    return design.CardDesign1(
      isHeading: true,
      isPhoto: true,
      isText1: true,
      isText2: true,
      heading: "Shop Name",
      text1: "phoneNo",
      text2: "address",
      onClick: () => {

      },
    );
    // return Container(
    //   margin: const EdgeInsets.only(bottom:12),
    //   decoration: BoxDecoration(
    //     borderRadius: const BorderRadius.all(Radius.circular(20.0)
    //     ),
    //     border: Border.all(
    //       color: Colors.grey.shade400, 
    //       width: 1.0,
    //     ),
    //   ),
    //   child: Row(
    //     children: [
    //       Padding(
    //         padding: const EdgeInsets.only(left:9, bottom:9, top:9, right:12),
    //         child: ClipRRect(
    //           borderRadius: const BorderRadius.all(Radius.circular(10.0)),
    //           child: Image.asset(
    //             'lib/assets/img/shop.png',
    //             width: 60,
    //             height: 60,
    //             fit: BoxFit.fitWidth,
    //           ),
    //         ),
    //       ),
    //       Flexible(
    //         fit: FlexFit.tight,
    //         child: Column(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: [
    //             Text("Shop Name", style: Theme.of(context).textTheme.headline4, overflow: TextOverflow.ellipsis,)  ,
    //             Text("phoneNo", style: Theme.of(context).textTheme.headline5, overflow: TextOverflow.ellipsis,),
    //             Text("address", style: Theme.of(context).textTheme.headline5, overflow: TextOverflow.ellipsis,),
    //           ],
    //         )
    //       ),
    //     ],
    //   )
    // );
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
      // appbar.fadeSystemUI();
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
                letterSpacing: -0.5
              ),
            ),
            const Spacer(),
            Text(
              widget.history_loc[i],
              style: const TextStyle(
                fontSize: 11.0,
                fontStyle: FontStyle.italic,
                color: Color(0xFF333333),
                letterSpacing: -0.5
              ),
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
                  letterSpacing: -0.5
                ),
                cursorColor: const Color(0xFF333333),
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.go,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () {
                      if (!_short) {
                        widget.hideResultDropbox();
                        widget.fabFn(true);
                        _controller.clear();
                        _shrink();
                      } else {
                        _extend();
                      }
                    },
                    icon: Icon(
                      (_short ? Icons.search : Icons.close),
                      color: const Color(0xFFD1D1D1),
                    )
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.fromLTRB(17, 7, 13, 2),
                  hintText: "Search...",
                  hintStyle: const TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.normal,
                    color: Color(0xFFD1D1D1),
                    letterSpacing: -0.5
                  ),
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
