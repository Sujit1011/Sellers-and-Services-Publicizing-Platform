import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'appbar.dart' as appbar;
import 'assets/design.dart' as design;
import 'models/SS_User.dart';

class ListPage extends StatelessWidget {

  final String username;
  final String phoneNo;
  final String title;
  final bool isLeftFloattingButton;
  final bool isRightFloattingButton;
  final Icon leftIcon;
  final Icon rightIcon;
  final String heroLeft;
  final String heroRight;

  final Function leftClick;
  final Function rightClick;

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
      required this.heroRight
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
  Widget build(BuildContext context) {
    final _myUser = Provider.of<SS_User?>(context);
    print(_myUser);
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
                              username,
                              style: Theme.of(context).textTheme.headline2
                            ),
                            Text(
                              phoneNo,
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
                        title,
                        style: Theme.of(context).textTheme.headline4,
                      ),
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.only(bottom: 47, right: 15),
                      child: Column(
                        children: [
                          design.CardDesign1(
                            isHeading: true,
                            isPhoto: true,
                            isText1: true,
                            isText2: true,
                            heading: "Shop Name",
                            text1: "phoneNo",
                            text2: "address",
                            onClick: () => {

                            },
                          ),
                          design.CardDesign1(
                            isHeading: true,
                            isPhoto: true,
                            isText1: true,
                            isText2: true,
                            heading: "Shop Name",
                            text1: "phoneNo",
                            text2: "address",
                            onClick: () => {

                            },
                          ),
                          // if (widget.username == "Edit Profile")
                          //   Wrap(children: [
                          //     Padding(
                          //       padding: const EdgeInsets.fromLTRB(0, 0, 0, 11),
                          //       child: Container(
                          //         decoration: BoxDecoration(
                          //           borderRadius: BorderRadius.circular(30),
                          //           border: Border.all(color: const Color(0xFFD1D1D1))
                          //         ),
                          //         child: Row(
                          //           children: [
                          //             Switch(
                          //               value: isSwitched,
                          //               onChanged: (value) {
                          //                 setState(() {
                          //                   isSwitched = value;
                          //                   print(isSwitched);
                          //                 });
                          //               },
                          //               activeTrackColor: Colors.lightGreenAccent,
                          //               activeColor: Colors.green,
                          //             ),
                          //             const Flexible(
                          //               child: Text(
                          //                 "Become a Seller or Service provider",
                          //               )
                          //             ),
                          //           ],
                          //         ),
                          //       )
                          //     ),
                          //   ]),
                          design.CardDesign1(
                            isHeading: true,
                            isPhoto: true,
                            isText1: true,
                            isText2: true,
                            heading: "Shop Name",
                            text1: "phoneNo",
                            text2: "address",
                            onClick: () => {

                            },
                          ),
                          design.CardDesign1(
                            isHeading: true,
                            isPhoto: true,
                            isText1: true,
                            isText2: true,
                            heading: "Shop Name",
                            text1: "phoneNo",
                            text2: "address",
                            onClick: () => {

                            },
                          ),
                        ],
                      ),
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
            if(isLeftFloattingButton)
              FloatingActionButton(
                heroTag: heroLeft,
                mini: true,
                onPressed: _left,
                child: leftIcon,
              ),
            if(isRightFloattingButton)
              FloatingActionButton(
                heroTag: heroRight,
                mini: true,
                onPressed: _right,
                child: rightIcon,
              ),
          ]
        ),
      )
    );
  }
}

// class _ListPage extends StatefulWidget {
//   final String username;
//   final String phoneNo;
//   final String title;
//   final bool isLeftFloattingButton;
//   final bool isRightFloattingButton;
//   final Icon leftIcon;
//   final Icon rightIcon;

//   final Function leftClick;
//   final Function rightClick;


//   const _ListPage(
//     {
//       Key? key, 
//       required this.username, 
//       required this.phoneNo, 
//       required this.title, 
//       required this.isLeftFloattingButton, 
//       required this.isRightFloattingButton, 
//       required this.leftClick, 
//       required this.rightClick, 
//       required this.leftIcon, 
//       required this.rightIcon
//     }
//   ): super(key: key);

//   @override
//   State<_ListPage> createState() => __ListPageState();
// }

// class __ListPageState extends State<_ListPage>{
//   // late final TabController _controller;

//   void _left() {
//     appbar.fadeSystemUI();
//     // setState(() {
//     //   // (_controller.index == 0) ? null : --_controller.index;
//     // });
//     widget.leftClick();
//   }

//   void _right() {
//     appbar.fadeSystemUI();
//     // setState(() {});
//     widget.rightClick();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: <Widget>[
//           Column(
//             children: [
//               //Cover
//               Container(
//                 height: 146,
//                 width: double.infinity,
//                 color: const Color(0xFFD1D1D1),
//                 child: Padding(
//                   padding: const EdgeInsets.only(left: 26, right: 26),
//                   child: Row(
//                     children: [
//                       const CircleAvatar(
//                         backgroundColor: Colors.black,
//                         minRadius: 44.5,
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.only(left: 20.0),
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               widget.username,
//                               style: Theme.of(context).textTheme.headline2
//                             ),
//                             Text(
//                               widget.phoneNo,
//                               style: Theme.of(context).textTheme.headline5
//                             )
//                           ],
//                         ),
//                       ),
//                       const Spacer()
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           Expanded(
//             child: Container(
//               padding: const EdgeInsets.fromLTRB(35, 120, 30, 10),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.only(bottom: 12, top: 38),
//                     child: Center(
//                       child: Text(
//                         widget.username,
//                         style: Theme.of(context).textTheme.headline4,
//                       ),
//                     ),
//                   ),
//                   Expanded(
//                     child: SingleChildScrollView(
//                       padding: const EdgeInsets.only(bottom: 47, right: 15),
//                       child: Column(
//                         children: [
//                           design.CardDesign1(
//                             isHeading: true,
//                             isPhoto: true,
//                             isText1: true,
//                             isText2: true,
//                             heading: "Shop Name",
//                             text1: "phoneNo",
//                             text2: "address",
//                             onClick: () => {

//                             },
//                           ),
//                           design.CardDesign1(
//                             isHeading: true,
//                             isPhoto: true,
//                             isText1: true,
//                             isText2: true,
//                             heading: "Shop Name",
//                             text1: "phoneNo",
//                             text2: "address",
//                             onClick: () => {

//                             },
//                           ),
//                           // if (widget.username == "Edit Profile")
//                           //   Wrap(children: [
//                           //     Padding(
//                           //       padding: const EdgeInsets.fromLTRB(0, 0, 0, 11),
//                           //       child: Container(
//                           //         decoration: BoxDecoration(
//                           //           borderRadius: BorderRadius.circular(30),
//                           //           border: Border.all(color: const Color(0xFFD1D1D1))
//                           //         ),
//                           //         child: Row(
//                           //           children: [
//                           //             Switch(
//                           //               value: isSwitched,
//                           //               onChanged: (value) {
//                           //                 setState(() {
//                           //                   isSwitched = value;
//                           //                   print(isSwitched);
//                           //                 });
//                           //               },
//                           //               activeTrackColor: Colors.lightGreenAccent,
//                           //               activeColor: Colors.green,
//                           //             ),
//                           //             const Flexible(
//                           //               child: Text(
//                           //                 "Become a Seller or Service provider",
//                           //               )
//                           //             ),
//                           //           ],
//                           //         ),
//                           //       )
//                           //     ),
//                           //   ]),
//                           design.CardDesign1(
//                             isHeading: true,
//                             isPhoto: true,
//                             isText1: true,
//                             isText2: true,
//                             heading: "Shop Name",
//                             text1: "phoneNo",
//                             text2: "address",
//                             onClick: () => {

//                             },
//                           ),
//                           design.CardDesign1(
//                             isHeading: true,
//                             isPhoto: true,
//                             isText1: true,
//                             isText2: true,
//                             heading: "Shop Name",
//                             text1: "phoneNo",
//                             text2: "address",
//                             onClick: () => {

//                             },
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 47,
//                   )
//                 ],
//               ),
//             )
//           )
//         ],
//       ),
//       //Floating Buttons
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//       floatingActionButton: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: <Widget>[
//             if(widget.isLeftFloattingButton)
//               FloatingActionButton(
//                 heroTag: "left",
//                 mini: true,
//                 onPressed: _left,
//                 child: widget.leftIcon,
//               ),
//             if(widget.isRightFloattingButton)
//               FloatingActionButton(
//                 heroTag: "right",
//                 mini: true,
//                 onPressed: _right,
//                 child: widget.rightIcon,
//               ),
//           ]
//         ),
//       )
//     );
//   }
// }
