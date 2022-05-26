import 'package:flutter/material.dart' show Alignment, Axis, BorderRadius, BorderSide, BoxDecoration, BoxShadow, BuildContext, ButtonStyle, ChoiceChip, Color, Column, Container, CrossAxisAlignment, EdgeInsets, Expanded, FontWeight, GlobalKey, Icon, IconButton, Icons, Key, MainAxisAlignment, MaterialPageRoute, MaterialStateProperty, Navigator, Offset, OutlinedButton, Padding, RoundedRectangleBorder, Row, ScaffoldState, SingleChildScrollView, State, StatefulWidget, StatelessWidget, Text, TextBaseline, TextStyle, Theme, VisualDensity, Widget, Wrap, WrapCrossAlignment;
import 'package:marquee_widget/marquee_widget.dart' show Marquee;
import 'package:shosev/view_categories.dart' show Categories;


// void fadeSystemUI() {
//   SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
// }

class AppBarContents extends StatelessWidget {
  const AppBarContents({Key? key, required this.title, required this.scaffoldKey}) : super(key: key);

  final GlobalKey<ScaffoldState> scaffoldKey;
  final String title;

  void onPressed() {
    // fadeSystemUI();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFFFFC804),
        boxShadow: [
          BoxShadow(
            color: Color(0xFFAAAAAA),
            blurRadius: 4.0,
            offset: Offset(0, 4),
          )
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(35.0, 20.0, 30.0, 0.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Expanded(
                  child: Marquee(
                    child: Text(title, style: Theme.of(context).textTheme.headline1),
                    animationDuration: const Duration(seconds: 2),
                    direction: Axis.horizontal,
                    backDuration: const Duration(milliseconds: 1000),
                    pauseDuration: const Duration(seconds: 2),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    scaffoldKey.currentState?.openEndDrawer();
                  },
                  tooltip: "User Menu",
                  icon: const Icon(
                    Icons.menu_rounded,
                    size: 40,
                  )
                )
              ],
            ),
          ),
          Container(
            alignment: Alignment.topCenter,
            child: const Padding(
                padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 7.0),
                child: MyThreeOptions(),
              ),
          ),
        ],
      )
    );
  }
}

class MyThreeOptions extends StatefulWidget {
  const MyThreeOptions({Key? key}) : super(key: key);

  @override
  State<MyThreeOptions> createState() => _MyThreeOptionsState();
}

class _MyThreeOptionsState extends State<MyThreeOptions> {
  int? _value = 0;
  // 0 = SEARCH
  // 1 = SUGGESTIONS
  // 2 = FAVOURITES
  // 3 = CATEGORIES

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Wrap(
        spacing: 7.0,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: <Widget>[
          OutlinedButton(
            style: ButtonStyle(
              backgroundColor:MaterialStateProperty.all<Color>(const Color(0xFFFCE48F)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius:BorderRadius.circular(18.0),
                  side: BorderSide.none
                ),
              ),
            ),
            onPressed: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => about.MyAboutUs(
              //       title: "About Us",
              //       aboutUs: widget.generateRandomString(2000),
              //       documentFieldStream: repository.ss_shops_collection.where("businessId", isEqualTo: user_id).snapshots(),
              //       documentFieldStream1: repository.ss_services_collection.where("businessId", isEqualTo: user_id).snapshots(),
              //     )
              //   ),
              // );
            },
            child: const Text(
              "SUGGESTIONS",
              style: TextStyle(
                color: Color(0xFF333333),
                fontSize: 12,
              ),
            ),
          ),
          OutlinedButton(
            style: ButtonStyle(
              backgroundColor:MaterialStateProperty.all<Color>(const Color(0xFFFCE48F)),
              visualDensity: VisualDensity.compact,
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius:BorderRadius.circular(18.0),
                  side: BorderSide.none
                ),
              ),
            ),
            onPressed: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => about.MyAboutUs(
              //       title: "About Us",
              //       aboutUs: widget.generateRandomString(2000),
              //       documentFieldStream: repository.ss_shops_collection.where("businessId", isEqualTo: user_id).snapshots(),
              //       documentFieldStream1: repository.ss_services_collection.where("businessId", isEqualTo: user_id).snapshots(),
              //     )
              //   ),
              // );
            },
            child: const Text(
              "FAVOURITES",
              style: TextStyle(
                color: Color(0xFF333333),
                fontSize: 12,
              ),
            ),
          ),
          OutlinedButton(
            style: ButtonStyle(
              backgroundColor:MaterialStateProperty.all<Color>(const Color(0xFFFCE48F)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius:BorderRadius.circular(18.0),
                  side: BorderSide.none
                ),
              ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => 
                  Categories(
                    title:"Categories",
                    isLeftFloattingButton: true,
                    leftClick: () => {
                      Navigator.pop(context)
                    },
                    leftIcon: const Icon(Icons.chevron_left_rounded),
                    rightIcon: const Icon(Icons.chevron_right_rounded),
                    heroLeft: "reviews_left",
                    heroRight: "reviews_right",
                  )
                ),
              );
            },
            child: const Text(
              "CATEGORIES",
              style: TextStyle(
                color: Color(0xFF333333),
                fontSize: 12,
              ),
            ),
          )
        ],
      ),
    );
  }
}