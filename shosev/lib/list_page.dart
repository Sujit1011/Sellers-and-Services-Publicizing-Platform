import 'package:cloud_firestore/cloud_firestore.dart' show QueryDocumentSnapshot, QuerySnapshot;
import 'package:flutter/material.dart' show AlertDialog, AsyncSnapshot, BoxFit, BuildContext, Center, CircleAvatar, CircularProgressIndicator, Color, Colors, Column, Container, CrossAxisAlignment, EdgeInsets, Expanded, FloatingActionButton, FloatingActionButtonLocation, Icon, Icons, Image, Key, ListView, MainAxisAlignment, MaterialPageRoute, Navigator, Padding, Row, Scaffold, SingleChildScrollView, SizedBox, Spacer, Stack, State, StatefulWidget, StreamBuilder, Text, TextButton, Theme, Widget, showDialog;
import 'package:shosev/add_shop.dart';

import 'package:shosev/assets/design.dart' as design;
import 'package:shosev/service_profile.dart' show ServiceProfilePage;
import 'package:shosev/shop_profile.dart' show ShopProfilePage;

enum listPageType {
  shop,
  service,
  chat,
  history
}

const Map<int,String> monthsToString = {
 1: "Jan",
 2: "Feb",
 3: "Mar",
 4: "Apr",
 5: "May",
 6: "Jun",
 7: "Jul",
 8: "Aug",
 9: "Sep",
 10: "Oct",
 11: "Nov",
 12: "Dec",
};

class ListPage extends StatefulWidget {

  final String username;
  final String phoneNo;
  final String title;
  final bool isLeftFloattingButton;
  final bool isEditFloattingButton;
  final bool isRightFloattingButton;
  final Icon leftIcon;
  final Icon rightIcon;
  final String heroLeft;
  final String heroRight;
  final bool onClickWidget;

  final Function leftClick;
  final Function rightClick;
  final void Function(String id) deleteItemFn;
  final void Function(String id, dynamic document) updateItemFn;

  final listPageType type;

  final Stream<QuerySnapshot> documentFieldStream;

  const ListPage(
    {
      Key? key, 
      required this.username, 
      required this.phoneNo, 
      required this.title, 
      required this.isLeftFloattingButton, 
      required this.isRightFloattingButton, 
      required this.leftClick, 
      required this.rightClick, 
      required this.leftIcon, 
      required this.rightIcon,
      required this.heroLeft,
      required this.heroRight, 
      required this.documentFieldStream,
      required this.onClickWidget, 
      required this.type, 
      required this.isEditFloattingButton, 
      required this.deleteItemFn, 
      required this.updateItemFn
    }
  ): super(key: key);

  void _left() {
    // appbar.fadeSystemUI();
    // setState(() {
    //   // (_controller.index == 0) ? null : --_controller.index;
    // });
    leftClick();
  }

  void _right() {
    // appbar.fadeSystemUI();
    // setState(() {});
    rightClick();
  }

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {

  bool _showUpdate = false;
  bool _showDelete = false;
  
  @override
  void initState() {
    super.initState();
    _showUpdate = false;
    _showDelete = false;
  }

  @override
  Widget build(BuildContext context) {
    // final _myUser = Provider.of<SS_User?>(context);
    // print(_myUser);
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Column(
            children: [
              //Cover
              Container(
                height: 146,
                width: double.infinity,
                color: const Color(0xFFD1D1D1),
                child: Padding(
                  padding: const EdgeInsets.only(left: 26, right: 26),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        backgroundColor: Colors.black,
                        minRadius: 44.5,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.username,
                              style: Theme.of(context).textTheme.headline2
                            ),
                            Text(
                              widget.phoneNo,
                              style: Theme.of(context).textTheme.headline5
                            )
                          ],
                        ),
                      ),
                      const Spacer()
                    ],
                  ),
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(35, 120, 30, 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 12, top: 38),
                  child: Center(
                    child: Text(
                      widget.title,
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  ),
                ),
                Expanded(
                  child: 
                  // SingleChildScrollView(
                  //   padding: const EdgeInsets.only(bottom: 47, right: 15),
                    // child: 
                    // Column(
                    //   children: [
                        StreamBuilder(
                          stream: widget.documentFieldStream,
                          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (!snapshot.hasData) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            if(snapshot.data!.size < 1) {
                              return const Center(child: Text("empty"),);
                            }
                            return ListView(
                              children: snapshot.data!.docs.map((document) {

                                Widget clickWidget = const SizedBox();
                                Image img = Image.asset(
                                  'lib/assets/img/img.png',
                                  width: 60,
                                  height: 60,
                                  fit: BoxFit.fitWidth,
                                );

                                if (widget.onClickWidget) {
                                  if (widget.type == listPageType.shop) {
                                    img = Image.asset(
                                      'lib/assets/img/shop.png',
                                      width: 60,
                                      height: 60,
                                      fit: BoxFit.fitWidth,
                                    );
                                    clickWidget = ShopProfilePage(
                                      // shopname: document["businessId"],
                                      username: widget.username,
                                      phoneno: widget.phoneNo,
                                      shopName: document["name"], 
                                      rating: document["rating"], 
                                      joined: monthsToString[document["joined"].toDate().month]! + " " + document["joined"].toDate().year.toString().substring(2,4), 
                                      reviews: document["reviews"], 
                                      contacted: document["contacted"], 
                                      aboutUs: document["description"],
                                      products: document["products"],
                                      reviewsCount: document["reviewsCount"],
                                      data: document,
                                    );
                                  } else if (widget.type == listPageType.service) {
                                    img = Image.asset(
                                      'lib/assets/img/service.jpg',
                                      width: 60,
                                      height: 60,
                                      fit: BoxFit.fitWidth,
                                    );
                                    clickWidget = ServiceProfilePage(
                                      username: widget.username,
                                      phoneno: widget.phoneNo,
                                      shopName: document["name"], 
                                      rating: document["rating"], 
                                      joined: monthsToString[document["joined"].toDate().month]! + " " + document["joined"].toDate().year.toString().substring(2,4), 
                                      reviews: document["reviews"], 
                                      contacted: document["contacted"], 
                                      aboutUs: document["description"],
                                      services: document["services"],
                                      reviewsCount: document["reviewsCount"],
                                      data: document,
                                    );
                                  } else if (widget.type == listPageType.history) {
                                    
                                  } else if (widget.type == listPageType.chat) {
                                    
                                  }
                                }
                                return design.CardDesign1(
                                  isHeading: true,
                                  isPhoto: true,
                                  isText1: true,
                                  isText2: true,
                                  img: img,
                                  deleteShow: _showDelete,
                                  updateShow: _showUpdate,
                                  heading: document["name"],
                                  text1: document["phoneNo"],
                                  text2: (widget.type == listPageType.shop || widget.type == listPageType.service)?document["address"]:"",
                                  onClick: () => {
                                    if (widget.onClickWidget) {
                                      Navigator.push(context,
                                      MaterialPageRoute(builder: (context) => clickWidget)
                                      ) 
                                    }
                                  },
                                  deleteOnClick: (){
                                    showDialog(
                                      context: context, 
                                      builder: (BuildContext builderContext) {
                                        return AlertDialog(
                                          title: const Text("Are you sure you want to delete?"),
                                          content: Text(document["name"]),
                                          actions: [
                                            TextButton(
                                              child: const Text("Yes"),
                                              onPressed: () async {
                                                widget.deleteItemFn(document == null? "": document.id.toString());
                                                Navigator.of(builderContext).pop();
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
                                  },
                                  updateOnClick: (){
                                    widget.updateItemFn(document.id.toString(), document);
                                  },
                              );
                            }).toList(),
                          );
                        }
                      ),
                  ),
                  const SizedBox(
                    height: 47,
                  )
                ],
              ),
            )
        ],
      ),
      //Floating Buttons
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            if(widget.isLeftFloattingButton)
              FloatingActionButton(
                heroTag: widget.heroLeft,
                mini: true,
                onPressed: widget._left,
                child: widget.leftIcon,
              ),
            if(widget.isEditFloattingButton)
              FloatingActionButton(
                heroTag: "edit",
                mini: false,
                onPressed: () {
                  _showDelete = !_showDelete;
                  _showUpdate = !_showUpdate;
                  setState(() {});
                },
                child: const Icon(Icons.edit_rounded, size: 30),
              ),
            if(widget.isRightFloattingButton)
              FloatingActionButton(
                heroTag: widget.heroRight,
                mini: true,
                onPressed: widget._right,
                child: widget.rightIcon,
              ),
          ]
        ),
      )
    );
  }
}