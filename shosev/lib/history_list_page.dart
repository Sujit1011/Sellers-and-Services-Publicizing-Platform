import 'package:cloud_firestore/cloud_firestore.dart' show DocumentSnapshot, QuerySnapshot;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' show AlertDialog, AsyncSnapshot, BuildContext, Center, CircleAvatar, CircularProgressIndicator, Color, Colors, Column, Container, CrossAxisAlignment, Divider, EdgeInsets, Expanded, FloatingActionButton, FloatingActionButtonLocation, Icon, Icons, InkWell, Key, ListView, MainAxisAlignment, MaterialPageRoute, Navigator, Padding, Row, Scaffold, ScaffoldMessenger, SizedBox, SnackBar, Spacer, Stack, State, StatefulWidget, StreamBuilder, Text, TextButton, Theme, Widget, showDialog;
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:shosev/assets/design.dart' as design;
import 'package:shosev/models/SS_User.dart';
import 'package:shosev/service_profile.dart' show ServiceProfilePage;
import 'package:shosev/shop_profile.dart' show ShopProfilePage;
import 'package:shosev/services/data_repository.dart';


class HistoryListPage extends StatefulWidget {

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
  final void Function(String id) updateItemFn;


  final Stream<DocumentSnapshot> documentFieldStream;

  const HistoryListPage(
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
      required this.isEditFloattingButton, 
      required this.deleteItemFn, 
      required this.updateItemFn,
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
  State<HistoryListPage> createState() => _ListPageState();
}

class _ListPageState extends State<HistoryListPage> {

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
    final user = Provider.of<SS_User?>(context);
    String userId = user?.uid as String;
    DataRepository repository = DataRepository();
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
                    StreamBuilder(
                      stream: repository.ss_users_collection.doc(userId).snapshots(),
                      builder: ((context, snapshot) {
                        dynamic historys = [];
                        if(snapshot.hasData) {
                          var val = snapshot.data as DocumentSnapshot;
                          historys = val['searchHistory'];
                          return ListView.builder(
                            itemCount: historys.length,
                            itemBuilder: (context, index) => Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                InkWell(
                                  child: SizedBox(
                                    height: 25,
                                    width: double.infinity,
                                    child: Text(
                                      historys[index], 
                                      textScaleFactor: 1.2,
                                      textAlign: TextAlign.center,
                                    )
                                  ),
                                  onTap: () {
                                    Clipboard.setData(ClipboardData(text: historys[index])).then((_){
                                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Text has been copied to clipboard")));
                                    });
                                  },
                                ),
                                const Divider()
                              ],
                            )
                          );
                        }
                        return const SizedBox();
                        
                      }
                      )
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