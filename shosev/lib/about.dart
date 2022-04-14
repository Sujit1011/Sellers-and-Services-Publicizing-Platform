import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shosev/main.dart';
import 'assets/design.dart' as design;
import 'maps.dart' as maps;
// import 'search.dart' as search;
// import 'info.dart' as info;
import 'appbar.dart' as appbar;

class MyAboutUs extends StatefulWidget {
  final String title;
  final String aboutUs;

  const MyAboutUs({Key? key, required this.title, required this.aboutUs})
      : super(key: key);

  @override
  State<MyAboutUs> createState() => _MyAboutUsState();
}

class _MyAboutUsState extends State<MyAboutUs>
    with SingleTickerProviderStateMixin {
  bool _shareValue = false;
  late final TabController _controller;
  final int pages = 3;

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
    appbar.fadeSystemUI();
    setState(() {
      (_controller.index == 0) ? null : --_controller.index;
    });
  }

  void _right() {
    appbar.fadeSystemUI();
    setState(() {
      (_controller.index == pages - 1) ? null : ++_controller.index;
    });
  }

  void _chat() {
    appbar.fadeSystemUI();
  }

  void _call() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
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
                          height: 60,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 10.0),
                                    child: Text("Started",
                                        style: Theme.of(context)
                                            .textTheme
                                            .overline),
                                  ),
                                  Text("2022",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline4),
                                ],
                              ),
                              const VerticalDivider(
                                width: 42,
                                thickness: 2,
                                indent: 20,
                                endIndent: 20,
                                color: Color(0xFFE5E5E5),
                              ),
                              Column(
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 10.0),
                                    child: Text("Shops",
                                        style: Theme.of(context)
                                            .textTheme
                                            .overline),
                                  ),
                                  Text("101",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline4),
                                ],
                              ),
                              const VerticalDivider(
                                width: 42,
                                thickness: 2,
                                indent: 20,
                                endIndent: 20,
                                color: Color(0xFFE5E5E5),
                              ),
                              Column(
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 10.0),
                                    child: Text("Services",
                                        style: Theme.of(context)
                                            .textTheme
                                            .overline),
                                  ),
                                  Text("200",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline4),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 12, top: 12),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "About Us",
                            style: Theme.of(context).textTheme.headline4,
                          ),
                        ),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.only(bottom: 12, right: 15),
                          child: Text(
                            widget.aboutUs,
                            // softWrap: true,
                            style: Theme.of(context).textTheme.bodyText1,
                            textAlign: TextAlign.left,
                          ),
                        ),
                      )
                    ]),
              )),
              SizedBox(
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
                        appbar.fadeSystemUI();
                        _shareValue = selected ? true : false;
                      });
                    },
                  ),
                ),
              )
            ],
          ),
          const Positioned(
              top: 62, right: 30, left: 30, child: design.LogoSimple())
        ],
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
            FloatingActionButton(
              mini: true,
              onPressed: _right,
              tooltip: 'Right',
              child: const Icon(Icons.chevron_right_rounded, size: 30),
            ),
          ],
        ),
      ),
    );
  }
}
