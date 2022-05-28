import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:shosev/services/data_repository.dart' show DataRepository;
import 'package:flutter/material.dart' show Align, Alignment, AnnotatedRegion, AsyncSnapshot, BuildContext, Center, ChoiceChip, CircularProgressIndicator, Color, Column, Container, CrossAxisAlignment, EdgeInsets, Expanded, FloatingActionButton, FloatingActionButtonLocation, FontWeight, Icon, Icons, IntrinsicHeight, Key, MainAxisAlignment, Navigator, Padding, Positioned, Row, SafeArea, Scaffold, SingleChildScrollView, SizedBox, Stack, State, StatefulWidget, StreamBuilder, Text, TextAlign, TextStyle, Theme, VerticalDivider, VisualDensity, Widget;
import 'package:shosev/assets/design.dart' as design;

class MyAboutUs extends StatefulWidget {

  const MyAboutUs({Key? key,}): super(key: key);

  @override
  State<MyAboutUs> createState() => _MyAboutUsState();
}

class _MyAboutUsState extends State<MyAboutUs>{
  bool _shareValue = false;
  String data = '';

  final DataRepository repository = DataRepository();
  String shops = "";

  // fetchFileData() async{
  //   // String responceText;
  //   // responceText = await rootBundle.loadString('textFiles/about.txt');
  //   // setState(() {
  //   //   data = responceText;
  //   // });
  //   // print(widget.documentFieldStream.length);
  // }

  @override
  void initState() {
    super.initState();
    getshopno();
  }

  getshopno() async{
    setState(() async{
      shops = repository.ss_shops_collection.snapshots().length.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          systemNavigationBarColor: design.textColor, // navigation bar color
          statusBarColor: design.primaryColor, // status bar color
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.light // status bar color
        ),
        child: Stack(
          children: <Widget>[
            Column(
              children: [
                Container(
                  height: 146,
                  // width: double.infinity,
                  color: const Color(0xFFFFC804),
                ),
                Expanded(
                    child: Container(
                  padding: const EdgeInsets.fromLTRB(35, 120, 30, 10),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 0, bottom: 10.0),
                          child: SizedBox(
                            child: IntrinsicHeight(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // const Spacer(),
                                  Column(
                                    children: const [
                                      Padding(
                                        padding: EdgeInsets.only(bottom: 10.0),
                                        child: Text(
                                          "Started",
                                          style: TextStyle(
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.bold,
                                            color: design.textColor2,
                                            letterSpacing: -0.5
                                          ),
                                          textScaleFactor: 1.0,
                                        ),
                                      ),
                                      Text(
                                        "2022",
                                        style: TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold,
                                          color: design.textColor,
                                          letterSpacing: -0.5
                                        ),
                                        textScaleFactor: 1.0,
                                      ),
                                    ],
                                  ),
                                  const VerticalDivider(
                                    width: 42,
                                    thickness: 2,
                                    indent: 10,
                                    endIndent: 10,
                                    color: Color(0xFFE5E5E5),
                                  ),
                                  StreamBuilder(
                                    stream: repository.ss_shops_collection.snapshots(),
                                    builder: (context,AsyncSnapshot<QuerySnapshot> snapshot) {
                                      String count = snapshot.data!.size.toString();
                                      if (!snapshot.hasData) {
                                        return const CircularProgressIndicator(strokeWidth: 1.0);
                                      }
                                      return Column(
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.only(bottom: 10.0),
                                            child: Text(
                                              "Shops",
                                              style: TextStyle(
                                                fontSize: 14.0,
                                                fontWeight: FontWeight.bold,
                                                color: design.textColor2,
                                                letterSpacing: -0.5
                                              ),
                                              textScaleFactor: 1.0,
                                            ),
                                          ),
                                          Text(
                                            count,
                                            style: const TextStyle(
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.bold,
                                              color: design.textColor,
                                              letterSpacing: -0.5
                                            ),
                                            textScaleFactor: 1.0,
                                          )
                                        ],
                                      );
                                    }
                                  ),
                                  const VerticalDivider(
                                    width: 42,
                                    thickness: 2,
                                    indent: 10,
                                    endIndent: 10,
                                    color: Color(0xFFE5E5E5),
                                  ),
                                  StreamBuilder(
                                    stream: repository.ss_services_collection.snapshots(),
                                    builder: (context,AsyncSnapshot<QuerySnapshot> snapshot) {
                                      String count = snapshot.data!.size.toString();
                                      if (!snapshot.hasData) {
                                        return const CircularProgressIndicator(strokeWidth: 1.0);
                                      }
                                      return Column(
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.only(bottom: 10.0),
                                            child: Text(
                                              "Services",
                                              style: TextStyle(
                                                fontSize: 14.0,
                                                fontWeight: FontWeight.bold,
                                                color: design.textColor2,
                                                letterSpacing: -0.5
                                              ),
                                              textScaleFactor: 1.0,
                                            ),
                                          ),
                                          Text(
                                            count,
                                            style: const TextStyle(
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.bold,
                                              color: design.textColor,
                                              letterSpacing: -0.5
                                            ),
                                            textScaleFactor: 1.0,
                                          )
                                        ],
                                      );
                                    }
                                  )
                                ],
                              ),
                            ),
                          ),
                          // SizedBox(
                          //   height: 60,
                          //   child: Row(
                          //     crossAxisAlignment: CrossAxisAlignment.center,
                          //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          //     children: [
                          //       Column(
                          //         children: [
                          //           Padding(
                          //             padding:
                          //                 const EdgeInsets.only(bottom: 10.0),
                          //             child: Text("Started",
                          //                 style: Theme.of(context)
                          //                     .textTheme
                          //                     .overline),
                          //           ),
                          //           Text("2022",
                          //               style: Theme.of(context)
                          //                   .textTheme
                          //                   .headline4),
                          //         ],
                          //       ),
                          //       const VerticalDivider(
                          //         width: 42,
                          //         thickness: 2,
                          //         indent: 20,
                          //         endIndent: 20,
                          //         color: Color(0xFFE5E5E5),
                          //       ),
                          //       StreamBuilder(
                          //         stream: repository.ss_shops_collection.snapshots(),
                          //         builder: (context,AsyncSnapshot<QuerySnapshot> snapshot){
                          //           String count = snapshot.data!.size.toString();
                          //           return Column(
                          //             children: [
                          //               Padding(
                          //                 padding:
                          //                     const EdgeInsets.only(bottom: 10.0),
                          //                 child: Text("Shops",
                          //                     style: Theme.of(context).textTheme.overline),
                          //               ),
                          //               Text(count,
                          //                   style: Theme.of(context).textTheme.headline4),
                          //             ],
                          //           );
                          //         }, 
                          //       ),
                          //       const VerticalDivider(
                          //         width: 42,
                          //         thickness: 2,
                          //         indent: 20,
                          //         endIndent: 20,
                          //         color: Color(0xFFE5E5E5),
                          //       ),
                          //       StreamBuilder(
                          //         stream: repository.ss_services_collection.snapshots(),
                          //         builder: (context,AsyncSnapshot<QuerySnapshot> snapshot){
                          //           String count = snapshot.data!.size.toString();
                          //           return Column(
                          //           children: [
                          //             Padding(
                          //               padding:
                          //                   const EdgeInsets.only(bottom: 10.0),
                          //               child: Text("Service",
                          //                   style: Theme.of(context).textTheme.overline),
                          //             ),
                          //             Text(count,
                          //                 style: Theme.of(context).textTheme.headline4),
                          //             ],
                          //           );
                          //         }, 
                          //       ),
                          //     ],
                          //   ),
                          // ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 12, top: 12),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "About Us",
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ),
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            padding: const EdgeInsets.only(bottom: 12, right: 15),
                            child: Text(
                              "Description",
                              // softWrap: true,
                              style: Theme.of(context).textTheme.bodyMedium,
                              textAlign: TextAlign.left,
                            ),
                          ),
                        )
                      ]
                    ),
                  )
                ),
                SafeArea(
                  child: SizedBox(
                    height: 60,
                    child: Center(
                      child: ChoiceChip(
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
                    ),
                  ),
                )
              ],
            ),
            const Positioned(top: 62, right: 30, left: 30, child: design.LogoSimple())
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            FloatingActionButton(
              mini: true,
              onPressed: () {
                Navigator.pop(context);
              },
              tooltip: 'Back/Left',
              child: const Icon(Icons.chevron_left_rounded, size: 30),
            ),
            // FloatingActionButton(
            //   mini: true,
            //   onPressed: _right,
            //   tooltip: 'Right',
            //   child: const Icon(Icons.chevron_right_rounded, size: 30),
            // ),
          ],
        ),
      ),
    );
  }
}
