import 'dart:math' show Random;

import 'package:cloud_firestore/cloud_firestore.dart' show DocumentSnapshot, FieldValue, QueryDocumentSnapshot, QuerySnapshot, dataSnapshot;
import 'package:firebase_core/firebase_core.dart' show Firebase;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' show Animation, Border, BorderRadius, BorderSide, BottomSheet, BoxConstraints, BoxDecoration, BoxShadow, BuildContext, CircularProgressIndicator, Color, Colors, Column, Container, CrossAxisAlignment, Divider, EdgeInsets, Expanded, FloatingActionButton, FloatingActionButtonLocation, FocusManager, FontStyle, FontWeight, GestureDetector, GlobalKey, Icon, IconButton, Icons, InkWell, InputBorder, InputDecoration, Key, ListView, MainAxisAlignment, MaterialApp, MaterialPageRoute, Offset, Padding, PopupRoute, Positioned, Radius, Row, Scaffold, ScaffoldState, SizedBox, Spacer, Stack, State, StatefulWidget, StatelessWidget, StreamBuilder, Text, TextBaseline, TextButton, TextEditingController, TextField, TextInputAction, TextInputType, TextStyle, VerticalDivider, Visibility, Widget, WidgetsFlutterBinding, runApp;
import 'package:geocoding/geocoding.dart' show Placemark, placemarkFromCoordinates;
import 'package:geolocator/geolocator.dart' show Geolocator, LocationPermission, Position;
import 'package:google_maps_flutter/google_maps_flutter.dart' show CameraPosition, CameraUpdate, GoogleMap, GoogleMapController, LatLng, MapType, Marker;
import 'package:provider/provider.dart' show Provider, StreamProvider;

import 'package:shosev/appbar.dart' as appbar;
import 'package:shosev/assets/design.dart' as design;
import 'package:shosev/firebase_options.dart' show DefaultFirebaseOptions;
import 'package:shosev/licenses.dart' as lic;
import 'package:shosev/list_page.dart';
import 'package:shosev/models/SS_User.dart' show SS_User;
import 'package:shosev/nav_drawer.dart' as nav;
import 'package:shosev/service_profile.dart';
import 'package:shosev/services/auth.dart' show AuthService;
import 'package:shosev/services/data_repository.dart' show DataRepository;
import 'package:shosev/shop_profile.dart';
import 'package:shosev/splash.dart' as splash;
import 'package:shosev/ratings_and_reviews.dart' as ratings_and_reviews; 

Future<void> main() async {
  lic.lisences();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
  // appbar.fadeSystemUI();
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
        debugShowCheckedModeBanner: false,
        home: const splash.Splash(),
        // home: const ratings_and_reviews.RatingandReview(username: "username", phoneNo: "123456789"),
        // debugShowCheckedModeBanner: false,
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
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;
  String result = "";

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool fab = true;
  String address = 'Welcome to ShoSev';
  bool showResult = false;
  bool filterButtonIsSelected = true;
  double latitude = 23.176890894138687;
  double longitude = 80.0233220952035;
  final DraggableScrollableController _resultController = DraggableScrollableController();
  late GoogleMapController googleMapController;
  static const CameraPosition initialCameraPosition = CameraPosition(target: LatLng(23.176890894138687, 80.0233220952035), zoom: 14);

  Set<Marker> markers = {};
  final AuthService _authService = AuthService();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isSwitched = false;

  @override
  void initState() {
    super.initState();
    _resultController.dispose();
  }

  void _clear() {
    // appbar.fadeSystemUI();
    FocusManager.instance.primaryFocus?.unfocus();
  }

  // void _myChats() {
  //   setState(() {
  //     _clear();
  //   });
  // }

  Future<void> _myLocation() async {
    Position position = await _determinePosition();
    // print(position.latitude);
    // print(position.longitude);

    googleMapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
            target: LatLng(position.latitude, position.longitude), zoom: 21)));

    GetAddressFromLatLong(position);
    setState(() {
      _clear();
    });
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition();
  }

  Future<void> GetAddressFromLatLong(Position position) async {
    List<Placemark> placemark =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    // print(placemark);
    Placemark place = placemark[0];

    address = '${place.locality}';
    setState(() {});
  }

  Future<void> GetAddressFromLatLong1(double latitude, double longitude) async {
    List<Placemark> placemark =
        await placemarkFromCoordinates(latitude,longitude);
    // print(placemark);
    Placemark place = placemark[0];

    address = '${place.locality}';
    setState(() {});
  }

  fabFn(bool ans) {
    setState(() {
      fab = ans;
    });
  }

  showResultDropbox(String res) {
    setState(() {
      widget.result = res;
      showResult = true;
      // _resultController.animateTo(2, duration: const Duration(milliseconds: 1500), curve: Curves.linear);
    });
    // Navigator.of(context).push(ResultDialog());
  }

  hideResultDropbox() {
    setState(() {
      widget.result = "";
      showResult = false;
      // _resultController.dispose();
    });
  }

  Widget _buildSearchResultItem(BuildContext context, DocumentSnapshot<Object?> data) {

    Widget clickWidget = (data.exists && filterButtonIsSelected)?
      ShopProfilePage(
        shopName: data["name"], 
        ratings: data["rating"], 
        joined: monthsToString[data["joined"].toDate().month]! + " " + data["joined"].toDate().year.toString().substring(2,4), 
        reviewsCount: data["reviewsCount"], 
        contacted: data["contacted"], 
        aboutUs: data["description"],
        products: data["products"],
        data: data,
      ):
      ServiceProfilePage(
        shopName: data["name"], 
        ratings: data["rating"], 
        joined: monthsToString[data["joined"].toDate().month]! + " " + data["joined"].toDate().year.toString().substring(2,4), 
        reviewsCount: data["reviewsCount"], 
        contacted: data["contacted"], 
        aboutUs: data["description"],
        services: data["services"],
        data: data,
      );

    if (data.exists) {
      return design.CardDesign1(
        isHeading: true,
        isPhoto: true,
        isText1: true,
        isText2: true,
        updateShow: false,
        deleteShow: false,
        deleteOnClick: (){},
        updateOnClick: (){},
        heading: data["name"],
        text1: data["phoneNo"],
        text2: data["address"],
        onClick: () => {
          if (data.exists) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => clickWidget
              )
            )
          }
          
        },
      );
    }
    return const SizedBox();
    
  }

  Widget _buildSearchResultList(BuildContext context, List<DocumentSnapshot<Object?>> list) {
    return ListView(
      padding: const EdgeInsets.all(18),
      children: list.map<Widget>((data) => _buildSearchResultItem(context, data)).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    // fab = MediaQuery.of(context).viewInsets.bottom != 0; //keyboard is open or not
    final user = Provider.of<SS_User?>(context);
    final DataRepository repository = DataRepository();
    // print(user);

    // Home Page
    // |____empty Appbar
    // |____Maps
    // |____Appbar
    // |____Search bar
    // |____Floating buttons
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      endDrawer: (user == null)?(nav.RegisterDrawer(authService: _authService,)):(nav.SignedInDrawer(authService: _authService)),
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
                  // onTap: () {
                  //   // _clear;
                  //   hideResultDropbox();
                  //   fabFn(true);
                  // },
                  child: Container(
                    constraints: const BoxConstraints.expand(),
                    child: GoogleMap(
                      mapType: MapType.normal,
                      initialCameraPosition: initialCameraPosition,
                      onTap: (LatLng latLng) {
                        // print(latLng.latitude);
                        // print(latLng.longitude);
                        hideResultDropbox();
                        fabFn(true);
                        GetAddressFromLatLong1(latLng.latitude, latLng.longitude);
                      },
                      onLongPress: (c) {
                        hideResultDropbox();
                        fabFn(true);
                      },
                      onMapCreated: (GoogleMapController controller) {
                        googleMapController = controller;
                      },
                      myLocationButtonEnabled: true,
                      compassEnabled: true,
                      zoomControlsEnabled: false,
                      
                      // onLongPress: (c) {
                      //   // _clear;
                        
                      //   showResult = false;
                      //   hideResultDropbox();
                      //   fabFn(true);
                      // },
                    )
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
              title: address,
              scaffoldKey: _scaffoldKey,
            ),
          ),
          // Search bar
          Positioned(
            top: 124,
            right: 30,
            left: 30,
            child: MySearch(
              userId: user?.uid ?? "",
              fabFn: fabFn,
              showResultDropbox: showResultDropbox,
              hideResultDropbox: hideResultDropbox,
            ),
          ),
          Visibility(
            visible: showResult,
            child: DraggableScrollableSheet(
              // controller: _resultController,
              builder: (context, scrollController) {
                return Container(
                  margin: const EdgeInsets.only(left: 17, right: 17, bottom: 0, top: 0),
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
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 50, right: 50, top: 5),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            TextButton(
                              onPressed: () {
                                setState(() {filterButtonIsSelected = !filterButtonIsSelected;});
                              }, 
                              child: const Text(
                                "SHOPS",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              style: TextButton.styleFrom(
                                backgroundColor: (filterButtonIsSelected)?const Color(0xFF333333):const Color(0xFFFFC804),
                                primary: (filterButtonIsSelected)?const Color(0xFFFFC804):const Color(0xFF333333),
                                minimumSize: const Size(108, 23),
                                padding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 14),
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                ),
                              ),
                            ),
                            const Flexible(
                              child: VerticalDivider(
                                width: 42,
                                thickness: 2,
                                indent: 20,
                                endIndent: 20,
                                color: Color(0xFFE5E5E5),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                setState(() {filterButtonIsSelected = !filterButtonIsSelected;});
                              }, 
                              child: const Text(
                                "SERVICES",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              style: TextButton.styleFrom(
                                backgroundColor: (filterButtonIsSelected)?const Color(0xFFFFC804):const Color(0xFF333333),
                                primary: (filterButtonIsSelected)?const Color(0xFF333333):const Color(0xFFFFC804),
                                minimumSize: const Size(108, 23),
                                padding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 14),
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Flexible(
                        child: StreamBuilder<QuerySnapshot>(
                          stream: (filterButtonIsSelected)?repository.ss_shops_collection.where("searchKeywords", arrayContains: widget.result).snapshots():repository.ss_services_collection.where("searchKeywords", arrayContains: widget.result).snapshots(),
                          builder: (context, snapshot) {
                            if (widget.result.length > 2) {
                              List<String> history = [];
                              Stream historyStream = repository.ss_users_collection.doc(user?.uid).snapshots();
                              historyStream.forEach((element) {
                                List<dynamic> list = element["searchHistory"];
                                history = list.cast<String>();
                              });
                              if(history.length < 10 && widget.result.length > 3) {
                                repository.ss_users_collection.doc(user!.uid).update({
                                "searchHistory" : FieldValue.arrayUnion([widget.result.toLowerCase()])
                              });
                              } else if (widget.result.length > 3){
                                repository.ss_users_collection.doc(user!.uid).update({
                                "searchHistory" : FieldValue.delete()
                              });
                              }
                              
                            }
                            
                            if (!snapshot.hasData) {
                              return const Center(child: CircularProgressIndicator());
                            }
                            if (snapshot.data!.docs.isEmpty) {
                              return Center(child: Text("No " + ((filterButtonIsSelected)?"Shop":"Service") + " Results", textScaleFactor: 2));
                            }
            
                            return _buildSearchResultList(context, snapshot.data?.docs ?? []);
                          }
                        ),
                      )
                    ],
                  ),
                ); 
              }
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
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              // FloatingActionButton(
              //   onPressed: () {
              //     // Navigator.push(
              //     //   context,
              //     //   MaterialPageRoute(
              //     //     builder: (context) =>
              //     //       listpage.ListPage(
              //     //         title: "My Chats",
              //     //         username: "User Name",
              //     //         phoneNo: "+91 xxxxx xxxxx",
              //     //         isLeftFloattingButton: true,
              //     //         isRightFloattingButton: false,
              //     //         leftClick: () => {
              //     //           Navigator.pop(context)
              //     //         },
              //     //         rightClick: () => {},
              //     //         leftIcon: const Icon(Icons.chevron_left_rounded),
              //     //         rightIcon: const Icon(Icons.chevron_right_rounded),
              //     //         heroLeft: "chat_left",
              //     //         heroRight: "chat_right",
              //     //       )
              //     //     ),
              //     // );
              //   },
              //   tooltip: 'My Chats',
              //   heroTag: 'My Chats',
              //   child: const Icon(Icons.chat_bubble_rounded),
              // ),
              FloatingActionButton(
                onPressed: _myLocation,
                tooltip: 'My Location',
                heroTag: 'My Location',
                child: const Icon(Icons.gps_fixed_rounded),
              ),
            ],
          ),
        ),
      )
    );
  }

}

class MySearch extends StatefulWidget {
  MySearch(
    {Key? key,
    required this.fabFn,
    required this.showResultDropbox,
    required this.hideResultDropbox, 
    required this.userId})
    : super(key: key);

  Function fabFn;
  Function showResultDropbox;
  Function hideResultDropbox;

  final String userId;

  @override
  State<MySearch> createState() => _MySearchState();
}

class _MySearchState extends State<MySearch> {
  List<String> history = [];
  List<String> historyLocation = [];
  final historyWidgets = <Widget>[];
  final DataRepository repository = DataRepository();
  bool _short = true;
  final TextEditingController _controller = TextEditingController();
  Widget divider() {
    return const Divider(
      height: 2,
    );
  }

  void _extend() {
    if(history.length > 1) {
      setState(() {
        _short = false;
        widget.hideResultDropbox();
        widget.fabFn(false);
      });
    }
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
    history.clear();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    if(widget.userId != "") {
      Stream historyStream = repository.ss_users_collection.doc(widget.userId).snapshots();
      historyStream.forEach((element) {
        List<dynamic> list = element["searchHistory"];
        history = list.cast<String>().reversed.toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if(historyWidgets.length < history.length) {
      for (int i = 0; i < history.length; i++) {
        historyWidgets.add(divider());
        historyWidgets.add(GestureDetector(
          onTap: () {
            setState(() {
              _controller.text = history[i];
            });
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                history[i],
                style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.normal,
                  color: Color(0xFF333333),
                  letterSpacing: -0.5
                ),
              ),
              const Spacer(),
              // Text(
              //   historyLocation[i],
              //   style: const TextStyle(
              //     fontSize: 11.0,
              //     fontStyle: FontStyle.italic,
              //     color: Color(0xFF333333),
              //     letterSpacing: -0.5
              //   ),
              // ),
            ],
          ),
        ));
      }
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
      )
    );
  }
}