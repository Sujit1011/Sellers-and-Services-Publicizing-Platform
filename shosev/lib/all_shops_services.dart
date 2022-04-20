import 'package:flutter/material.dart';
import 'package:marquee_widget/marquee_widget.dart';
import 'assets/design.dart' as design;
import 'appbar.dart' as appbar;

class All_Shops_Services extends StatefulWidget {
  final String aboutUs;
  final String title;
  const All_Shops_Services(
      {Key? key, required this.title, required this.aboutUs})
      : super(key: key);

  @override
  State<All_Shops_Services> createState() => _All_Shops_ServicesState();
}

class _All_Shops_ServicesState extends State<All_Shops_Services>
    with SingleTickerProviderStateMixin {
  late final TabController _controller;

  void _left() {
    appbar.fadeSystemUI();
    setState(() {
      (_controller.index == 0) ? null : --_controller.index;
    });
  }

  void _add() {
    appbar.fadeSystemUI();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    bool isSwitched = false;

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
                              Text("Sujit Soren",
                                  style: Theme.of(context).textTheme.headline2),
                              const Text("+91 987 654 3210")
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
            Expanded(
                child: Container(
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
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.only(bottom: 47, right: 15),
                      child: Column(
                        children: [
                          design.AllShopsServices(title: widget.title),
                          design.AllShopsServices(title: widget.title),
                          if (widget.title == "Edit Profile")
                            Wrap(children: [
                              Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 0, 11),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        border: Border.all(
                                            color: const Color(0xFFD1D1D1))),
                                    child: Row(
                                      children: [
                                        Switch(
                                          value: isSwitched,
                                          onChanged: (value) {
                                            setState(() {
                                              isSwitched = value;
                                              print(isSwitched);
                                            });
                                          },
                                          activeTrackColor:
                                              Colors.lightGreenAccent,
                                          activeColor: Colors.green,
                                        ),
                                        const Flexible(
                                            child: Text(
                                          "Become a Seller or Service provider",
                                          // overflow: TextOverflow.clip,
                                        )),
                                      ],
                                    ),
                                  )),
                            ]),
                          design.AllShopsServices(title: widget.title),
                          design.AllShopsServices(title: widget.title),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 47,
                  )
                ],
              ),
            ))
          ],
        ),
        //Floating Buttons
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                widget.title == "Edit Profile"
                    ? FloatingActionButton(
                        mini: true,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        tooltip: 'Back/Left',
                        child: const Icon(Icons.not_interested, size: 30),
                      )
                    : FloatingActionButton(
                        mini: true,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        tooltip: 'Back/Left',
                        child: const Icon(Icons.chevron_left_rounded, size: 30),
                      ),
                widget.title == "My Shops" ||
                        widget.title == "My Services" ||
                        widget.title == "My Chats"
                    ? FloatingActionButton(
                        mini: true,
                        onPressed: _add,
                        tooltip: 'Right',
                        child: const Icon(Icons.add, size: 30),
                      )
                    : widget.title == "Edit Profile"
                        ? FloatingActionButton(
                            mini: true,
                            onPressed: _add,
                            tooltip: 'Right',
                            child: const Icon(Icons.done_rounded, size: 30),
                          )
                        : Visibility(
                            visible: false,
                            child: FloatingActionButton(onPressed: _add)),
              ]),
        ));
  }
}
