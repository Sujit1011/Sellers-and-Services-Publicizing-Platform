import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth;
import 'package:flutter/material.dart' show AlertDialog, AlwaysStoppedAnimation, Axis, BorderRadius, BoxDecoration, BoxFit, BuildContext, Center, ChoiceChip, ClipOval, ClipRRect, Color, Colors, Column, Container, CrossAxisAlignment, Divider, EdgeInsets, Expanded, FloatingActionButton, FloatingActionButtonLocation, FontStyle, FontWeight, Icon, Icons, IgnorePointer, Image, Key, LinearProgressIndicator, ListView, MainAxisAlignment, MaterialPageRoute, Navigator, NeverScrollableScrollPhysics, Padding, Positioned, Radius, RoundedRectangleBorder, Row, Scaffold, SingleChildScrollView, SingleTickerProviderStateMixin, Size, SizedBox, Spacer, Stack, State, StatefulWidget, Tab, TabBar, TabBarView, TabController, Text, TextAlign, TextButton, TextStyle, Theme, VerticalDivider, Visibility, VisualDensity, Widget, showDialog;
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart' show FlutterPhoneDirectCaller;
import 'package:flutter_rating_bar/flutter_rating_bar.dart' show RatingBarIndicator;
import 'package:marquee_widget/marquee_widget.dart' show Marquee;
import 'package:shosev/ratings_and_reviews.dart';
import 'package:shosev/services/data_repository.dart';
import 'package:url_launcher/url_launcher.dart' show launch;
import 'package:whatsapp_unilink/whatsapp_unilink.dart' show WhatsAppUnilink;


class ServiceProfilePage extends StatefulWidget {
  final String username;
  final String phoneno;
  final List<dynamic> rating;
  final String shopName;
  final String joined;
  final List<dynamic> reviews;
  final int contacted;
  final String aboutUs;
  final List<dynamic> services;
  final dynamic data;

  const ServiceProfilePage(
      {Key? key,
      required this.username,
      required this.phoneno,
      required this.rating,
      required this.shopName,
      required this.joined,
      required this.reviews,
      required this.contacted,
      required this.aboutUs, 
      required this.services, 
      required this.data})
      : super(key: key);

  @override
  State<ServiceProfilePage> createState() => _ServicelePageState();
}

class _ServicelePageState extends State<ServiceProfilePage> with SingleTickerProviderStateMixin {
  bool _shareValue = false;
  final int pages = 3;
  late final TabController _controller;
  final _boldButtonStyle = TextButton.styleFrom(
    backgroundColor: const Color(0xFFFFC804),
    primary: const Color(0xFF333333),
    minimumSize: const Size(108, 32),
    padding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 14),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(30.0)),
    ),
  );

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _left() {
    // appbar.fadeSystemUI();
    setState(() {
      (_controller.index == 0) ? Navigator.pop(context) : --_controller.index;
    });
  }

  void _right() {
    // appbar.fadeSystemUI();
    setState(() {
      (_controller.index == pages - 1) ? null : ++_controller.index;
    });
  }

  void _chat(String? name) async {
    if(name == null) {
      return;
    }
    String text = "Hi, this  is $name";
    var link = WhatsAppUnilink(
      phoneNumber: widget.data['phoneNo'].toString(),
      text: text,
    );
    await launch('$link');
  }

  void _call() async {
    String url = 'tel:' + widget.data['phoneNo'].toString();
    showDialog(
      context: context, 
      builder: (BuildContext builderContext) {
        return AlertDialog(
          title: Text("Call " + widget.shopName),
          content: Text(widget.data['phoneNo']),
          actions: [
            TextButton(
              child: const Text("Yes"),
              onPressed: () async {
                DataRepository repository = DataRepository();
                repository.ss_shops_collection.doc(widget.data['id']).update(widget.data['contacted'] + 1);
                FlutterPhoneDirectCaller.callNumber(url);
              },
            ),
            TextButton(
              child: const Text("Cancel"),
              onPressed: () async {
                Navigator.of(builderContext).pop();
              },
            )
          ],
        );
      }).then((val) {
        Navigator.of(context).pop();
      });
    
    // await launch(url);
  }

  void _writeReview() {
    print(widget.data);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => RatingandReview(
                // Id: widget.data['id'],
                username: widget.username,
                phoneNo: widget.phoneno,
                type:"service",
                isLeftFloattingButton: true,
                isRightFloattingButton: false,
                leftIcon: const Icon(Icons.chevron_left_rounded),
                rightIcon: const Icon(Icons.add_rounded),
                data1: widget.data)));
  }

  @override
  Widget build(BuildContext context) {
    // Shop Profile Page
    // |____Cover
    // |____Profile Picture
    // |____Shop Name
    // |____Page 1, Page 2, Page 3
    // |____Floating buttons
    //      |____left button
    //      |____right button
    //      |____share button
    //      |____paginator
    //      |____favourite button
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Column(
            children: [
              // Cover
              SizedBox(
                height: 146.0,
                width: double.infinity,
                child: Image.asset(
                  'lib/assets/img/cover.jpg',
                  fit: BoxFit.fitWidth,
                )
              ),
              // Page 1, Page 2, Page 3
              Expanded(
                child: Container(
                  padding: const EdgeInsets.fromLTRB(35, 136, 30, 10),
                  child: TabBarView(
                    physics: const NeverScrollableScrollPhysics(),
                    controller: _controller,
                    children: [
                      // Page 1
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: SizedBox(
                              height: 106,
                              width: 243,
                              child: Column(
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      // Chat Button
                                      TextButton.icon(
                                        style: _boldButtonStyle,
                                        icon: const Icon(
                                          Icons.chat_bubble_rounded,
                                          size: 18
                                        ),
                                        onPressed: () {
                                          _chat(FirebaseAuth.instance.currentUser?.phoneNumber);
                                        },
                                        label: const Text("CHAT",
                                        style: TextStyle(
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF333333),
                                          letterSpacing: -0.5)
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 22,
                                      ),
                                      TextButton.icon(
                                        style: _boldButtonStyle,
                                        icon: const Icon(
                                          Icons.call_rounded,
                                          size: 18
                                        ),
                                        onPressed: _call,
                                        label: const Text("CALL",
                                          style: TextStyle(
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFF333333),
                                            letterSpacing: -0.5
                                          )
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 19,
                                  ),
                                  Column(
                                    // crossAxisAlignment: CrossAxisAlignment.center,
                                    // mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(bottom: 8.0, left: 0),
                                        child: Text(
                                          "Ratings (" +((widget.rating[0] +
                                                        widget.rating[1] +
                                                        widget.rating[2] +
                                                        widget.rating[3] +
                                                        widget.rating[4] + 
                                                        widget.rating[5]) /
                                                    6).toString() +")",
                                          style: Theme.of(context).textTheme.headline5,
                                        ),
                                      ),
                                      RatingBarIndicator(
                                        rating: ((widget.rating[0] +
                                                  widget.rating[1] +
                                                  widget.rating[2] +
                                                  widget.rating[3] +
                                                  widget.rating[4] + 
                                                  widget.rating[5]) /
                                              6),
                                        unratedColor: const Color(0xFFD1D1D1),
                                        itemBuilder: (context, index) => const Icon(
                                          Icons.star,
                                          color: Color(0xFFFFC804),
                                        ),
                                        itemCount: 5,
                                        itemSize: 20.0,
                                        direction: Axis.horizontal,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 28.0),
                          Expanded(
                            child: ListView(
                            shrinkWrap: true,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: SizedBox(
                                  height: 62,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Spacer(),
                                      Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 10.0),
                                            child: Text("Joined",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .overline),
                                          ),
                                          Text(widget.joined.toString(),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline4),
                                        ],
                                      ),
                                      const Spacer(),
                                      const VerticalDivider(
                                        width: 42,
                                        thickness: 2,
                                        indent: 15,
                                        endIndent: 20,
                                        color: Color(0xFFE5E5E5),
                                      ),
                                      const Spacer(),
                                      Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 10.0),
                                            child: Text("Reviews",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .overline),
                                          ),
                                          Text(widget.reviews.length.toString(),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline4),
                                        ],
                                      ),
                                      const Spacer(),
                                      const VerticalDivider(
                                        width: 42,
                                        thickness: 2,
                                        indent: 15,
                                        endIndent: 20,
                                        color: Color(0xFFE5E5E5),
                                      ),
                                      const Spacer(),
                                      Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 10.0),
                                            child: Text("Contacted",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .overline),
                                          ),
                                          Text(widget.contacted.toString(),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline4),
                                        ],
                                      ),
                                      const Spacer(),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(bottom: 12, top: 2),
                                child: Text(
                                  "Gallery",
                                  style: Theme.of(context).textTheme.headline4,
                                ),
                              ),
                              // Gallery
                              SizedBox(
                                height: 124,
                                child: ListView(
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    padding: const EdgeInsets.only(bottom: 12),
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 12),
                                        child: ClipRRect(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(10.0)),
                                          child: Image.asset(
                                            'lib/assets/img/service.jpg',
                                            width: 106,
                                            height: 124,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 12),
                                        child: ClipRRect(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(10.0)),
                                          child: Image.asset(
                                            'lib/assets/img/service.jpg',
                                            width: 106,
                                            height: 124,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 12),
                                        child: ClipRRect(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(10.0)),
                                          child: Image.asset(
                                            'lib/assets/img/service.jpg',
                                            width: 106,
                                            height: 124,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 12),
                                        child: ClipRRect(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(10.0)),
                                          child: Image.asset(
                                            'lib/assets/img/service.jpg',
                                            width: 106,
                                            height: 124,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ]),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(bottom: 12, top: 20),
                                child: Text(
                                  "About Us",
                                  style: Theme.of(context).textTheme.headline4,
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 12, right: 15),
                                  child: Text(
                                    widget.aboutUs,
                                    softWrap: true,
                                    style:
                                        Theme.of(context).textTheme.bodyText1,
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                              ),
                            ],
                          ))
                        ],
                      ),
                      // Page 2
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Text(
                              "Services",
                              style: Theme.of(context).textTheme.headline4,
                            ),
                          ),
                          Expanded(
                            child: ListView.builder(
                              itemCount: widget.services.length,
                              padding: const EdgeInsets.only(bottom: 12, right: 15, top: 8),
                              itemBuilder: (context,index){
                                return Column(
                                  children: [
                                    Row(
                                      children: [
                                        const Spacer(),
                                        Expanded(
                                            flex: 3,
                                            child: Text(
                                                widget.services[index]
                                                    ["productName"],
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline5)),
                                        const Spacer(),
                                        Expanded(
                                            flex: 1,
                                            child: Text(
                                              "₹" +
                                                  widget.services[index]
                                                          ["cost"]
                                                      .toString(),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline5,
                                              textAlign: TextAlign.end,
                                            )),
                                        const Spacer(),
                                      ],
                                    ),
                                    const Divider(
                                      height: 10,
                                      thickness: 1,
                                      indent: 50,
                                      endIndent: 50,
                                      color: Color(0xFFE5E5E5),
                                    ),
                                  ],
                                );
                              }),
                          ),
                          // Expanded(
                          //   child: Padding(
                          //     padding: const EdgeInsets.only(bottom: 12),
                          //     child: Text(
                          //       widget.aboutUs,
                          //       softWrap: true,
                          //       style: Theme.of(context).textTheme.bodyText1,
                          //       textAlign: TextAlign.left,
                          //     ),
                          //   ),
                          // ),
                          Expanded(
                            child: ListView(
                                padding: const EdgeInsets.only(
                                    bottom: 12, right: 15, top: 8),
                                // child: SizedBox(
                                //   height: 200,
                                children: [
                                  ListView.builder(
                                  itemCount: widget.services.length,
                                  padding: const EdgeInsets.only(bottom: 12, right: 15, top: 8),
                                  itemBuilder: (context, index) {
                                    return Column(
                                      children: [
                                        Row(
                                          children: [
                                            const Spacer(),
                                            Expanded(
                                                flex: 3,
                                                child: Text(widget.services[index]["productName"],
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline5)),
                                            const Spacer(),
                                            Expanded(
                                                flex: 1,
                                                child: Text(
                                                  "₹"+widget.services[index]["cost"].toString(),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline5,
                                                  textAlign: TextAlign.end,
                                                )),
                                            const Spacer(),
                                          ],
                                        ),
                                        const Divider(
                                          height: 10,
                                          thickness: 1,
                                          indent: 50,
                                          endIndent: 50,
                                          color: Color(0xFFE5E5E5),
                                        ),
                                      ],
                                    );
                                  }
                                )
                                ]
                              ),
                          ),
                          // Expanded(
                          //   child: Padding(
                          //     padding: const EdgeInsets.only(bottom: 12),
                          //     child: Text(
                          //       widget.aboutUs,
                          //       softWrap: true,
                          //       style: Theme.of(context).textTheme.bodyText1,
                          //       textAlign: TextAlign.left,
                          //     ),
                          //   ),
                          // ),
                          // Expanded(
                          //   flex: 2,
                          //   child: SingleChildScrollView(
                          //     padding: const EdgeInsets.only(bottom: 12, right: 15),
                          //     child: Text(
                          //       widget.aboutUs,
                          //       softWrap: true,
                          //       style: Theme.of(context).textTheme.bodyText1,
                          //       textAlign: TextAlign.left,
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                      // Page 3
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: Text(
                              "Ratings",
                              style: Theme.of(context).textTheme.headline4,
                            ),
                          ),
                          Center(
                            child: SizedBox(
                              height: 102,
                              width: 248,
                              child: Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      // Rating Progress Indicators
                                      Row(
                                        children: const [
                                          Text("5  "),
                                          SizedBox(
                                              width: 115,
                                              height: 5,
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(5)),
                                                child: LinearProgressIndicator(
                                                  backgroundColor:
                                                      Color(0xFFE5E5E5),
                                                  valueColor:
                                                      AlwaysStoppedAnimation<
                                                              Color>(
                                                          Color(0xFFFFC804)),
                                                  value: 0.5,
                                                ),
                                              )),
                                        ],
                                      ),
                                      const Spacer(),
                                      Row(
                                        children: const [
                                          Text("4  "),
                                          SizedBox(
                                              width: 115,
                                              height: 5,
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(5)),
                                                child: LinearProgressIndicator(
                                                  backgroundColor:
                                                      Color(0xFFE5E5E5),
                                                  valueColor:
                                                      AlwaysStoppedAnimation<
                                                              Color>(
                                                          Color(0xFFFFC804)),
                                                  value: 0.5,
                                                ),
                                              )),
                                        ],
                                      ),
                                      const Spacer(),
                                      Row(
                                        children: const [
                                          Text("3  "),
                                          SizedBox(
                                              width: 115,
                                              height: 5,
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(5)),
                                                child: LinearProgressIndicator(
                                                  backgroundColor:
                                                      Color(0xFFE5E5E5),
                                                  valueColor:
                                                      AlwaysStoppedAnimation<
                                                              Color>(
                                                          Color(0xFFFFC804)),
                                                  value: 0.5,
                                                ),
                                              )),
                                        ],
                                      ),
                                      const Spacer(),
                                      Row(
                                        children: const [
                                          Text("2  "),
                                          SizedBox(
                                              width: 115,
                                              height: 5,
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(5)),
                                                child: LinearProgressIndicator(
                                                  backgroundColor:
                                                      Color(0xFFE5E5E5),
                                                  valueColor:
                                                      AlwaysStoppedAnimation<
                                                              Color>(
                                                          Color(0xFFFFC804)),
                                                  value: 0.5,
                                                ),
                                              )),
                                        ],
                                      ),
                                      const Spacer(),
                                      Row(
                                        children: const [
                                          Text("1  "),
                                          SizedBox(
                                              width: 115,
                                              height: 5,
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(5)),
                                                child: LinearProgressIndicator(
                                                  backgroundColor:
                                                      Color(0xFFE5E5E5),
                                                  valueColor:
                                                      AlwaysStoppedAnimation<
                                                              Color>(
                                                          Color(0xFFFFC804)),
                                                  value: 0.5,
                                                ),
                                              )),
                                        ],
                                      ),
                                      // TextButton.icon(
                                      //   style: _boldButtonStyle,
                                      //   icon: const Icon(Icons.chat_bubble_rounded, size: 18),
                                      //   onPressed: _chat,
                                      //   label: const Text("CHAT", style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold, color: Color(0xFF333333), letterSpacing: -0.5)),
                                      // ),
                                      // const Spacer(),
                                      // TextButton.icon(
                                      //   style: _boldButtonStyle,
                                      //   icon: const Icon(Icons.call_rounded, size: 18),
                                      //   onPressed: _call,
                                      //   label: const Text("CALL", style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold, color: Color(0xFF333333), letterSpacing: -0.5)),
                                      // ),
                                    ],
                                  ),
                                  const VerticalDivider(
                                    width: 15,
                                    thickness: 2,
                                    indent: 20,
                                    endIndent: 20,
                                    color: Colors.transparent,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            bottom: 8.0, left: 0),
                                        child: Text(
                                          ((widget.rating[0] +
                                              widget.rating[1] +
                                              widget.rating[2] +
                                              widget.rating[3] +
                                              widget.rating[4] + 
                                              widget.rating[5]) /
                                          6).toString(),
                                          style: const TextStyle(
                                              fontSize: 40.0,
                                              fontWeight: FontWeight.normal,
                                              color: Color(0xFF333333),
                                              letterSpacing: -0.5),
                                        ),
                                      ),
                                      RatingBarIndicator(
                                      rating: ((widget.rating[0] +
                                                widget.rating[1] +
                                                widget.rating[2] +
                                                widget.rating[3] +
                                                widget.rating[4] + 
                                                widget.rating[5]) /
                                            6),
                                        unratedColor: const Color(0xFFD1D1D1),
                                        itemBuilder: (context, index) =>
                                            const Icon(
                                          Icons.star,
                                          color: Color(0xFFFFC804),
                                        ),
                                        itemCount: 5,
                                        itemSize: 20.0,
                                        direction: Axis.horizontal,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 18, bottom: 12),
                            child: Text(
                              "Reviews",
                              style: Theme.of(context).textTheme.headline4,
                            ),
                          ),
                          Expanded(
                                child: ListView.builder(
                              itemCount: widget.reviews.length,
                              padding:
                                  const EdgeInsets.only(bottom: 12, right: 15),
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(2),
                                      child: Row(
                                        children: [
                                          ClipOval(
                                            child: Image.asset(
                                              'lib/assets/img/user.png',
                                              height: 35,
                                              width: 35,
                                              fit: BoxFit.fitWidth,
                                            ),
                                          ),
                                          Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 5.0),
                                              child: Text(
                                                widget.reviews[index]["review"],
                                                style: const TextStyle(
                                                  fontSize: 12,
                                                  fontStyle: FontStyle.italic,
                                                ),
                                              ))
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              },
                            )),
                            Padding(
                              padding: const EdgeInsets.only(top: 5.0),
                              child: Center(
                                child: TextButton.icon(
                                  style: TextButton.styleFrom(
                                    backgroundColor: const Color(0xFFFFC804),
                                    primary: const Color(0xFF333333),
                                    minimumSize: const Size(204, 40),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 2.0, vertical: 14),
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(30.0)),
                                    ),
                                  ),
                                  onPressed: _writeReview,
                                  icon: const Icon(Icons.rate_review_rounded),
                                  label: const Text(
                                    "Write my review",
                                    style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.normal,
                                        color: Color(0xFF333333),
                                        letterSpacing: -0.5),
                                  ),
                                ),
                              ),
                            )
                            ],
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                  height: 60,
                  child: Center(
                    child: Column(
                      children: [
                        const Spacer(),
                        ChoiceChip(
                          padding: const EdgeInsets.fromLTRB(2, 0, 2, 0),
                          avatar: Icon(
                            Icons.share_rounded,
                            size: 14,
                            color: _shareValue
                                ? const Color(0xFFFFFFFF)
                                : const Color(0xFF333333),
                          ),
                          disabledColor: const Color(0xFFD1D1D1),
                          selectedColor: const Color(0xFF333333),
                          backgroundColor: const Color(0xFFFFC804),
                          tooltip: "Share Shop",
                          label: const Text('SHARE'),
                          labelStyle: TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.normal,
                              color: _shareValue
                                  ? const Color(0xFFFFFFFF)
                                  : const Color(0xFF333333),
                              letterSpacing: -0.5),
                          visualDensity: VisualDensity.compact,
                          selected: _shareValue,
                          onSelected: (bool selected) {
                            setState(() {
                              // appbar.fadeSystemUI();
                              _shareValue = selected ? true : false;
                            });
                          },
                        ),
                        const Spacer(),
                        SizedBox(
                            height: 10,
                            width: 62,
                            child: IgnorePointer(
                              child: TabBar(
                                  labelPadding:
                                      const EdgeInsets.fromLTRB(2, 1, 2, 1),
                                  indicator: null,
                                  indicatorColor: Colors.transparent,
                                  controller: _controller,
                                  physics: const NeverScrollableScrollPhysics(),
                                  tabs: [
                                    Tab(
                                        child: Container(
                                            height:
                                                _controller.index == 0 ? 5 : 2,
                                            decoration: BoxDecoration(
                                              color: _controller.index == 0
                                                  ? const Color(0xFFFFC804)
                                                  : const Color(0xFF333333),
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(5.0)),
                                            ))),
                                    Tab(
                                        child: Container(
                                            height:
                                                _controller.index == 1 ? 5 : 2,
                                            decoration: BoxDecoration(
                                              color: _controller.index == 1
                                                  ? const Color(0xFFFFC804)
                                                  : const Color(0xFF333333),
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(5.0)),
                                            ))),
                                    Tab(
                                        child: Container(
                                            height:
                                                _controller.index == 2 ? 5 : 2,
                                            decoration: BoxDecoration(
                                              color: _controller.index == 2
                                                  ? const Color(0xFFFFC804)
                                                  : const Color(0xFF333333),
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(5.0)),
                                            ))),
                                  ]),
                            )),
                        const Spacer(),
                      ],
                    ),
                  ))
            ],
          ),
          // Profile Image
          Positioned(
              top: 62,
              height: 143,
              left: 35,
              right: 35,
              child: Center(
                child: ClipOval(
                  child: Image.asset(
                    'lib/assets/img/service.jpg',
                    fit: BoxFit.fitWidth,
                  ),
                ),
              )),
          // Shop Name
          Positioned(
            top: 216,
            left: 35,
            right: 30,
            child: Center(
              child: Marquee(
                child: Text(widget.shopName,
                    style: Theme.of(context).textTheme.headline1),
                animationDuration: const Duration(seconds: 2),
                direction: Axis.horizontal,
                backDuration: const Duration(milliseconds: 1000),
                pauseDuration: const Duration(seconds: 2),
              ),
            ),
          ),
        ],
      ),
      // Floating buttons
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            FloatingActionButton(
              mini: true,
              onPressed: _left,
              tooltip: 'Back/Left',
              heroTag: 'Service Back/Left',
              child: const Icon(Icons.chevron_left_rounded, size: 30),
            ),
            Visibility(
              visible: _controller.index == pages - 1 ? false : true,
              child: FloatingActionButton(
                mini: true,
                onPressed: _right,
                tooltip: 'Right',
                heroTag: 'Service Right',
                child: const Icon(Icons.chevron_right_rounded, size: 30),
              ),
            )
          ],
        ),
      ),
    );
  }
}
