import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:marquee_widget/marquee_widget.dart';

void fadeSystemUI() {
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
}

class AppBarContents extends StatelessWidget {
  const AppBarContents({Key? key, required this.title}) : super(key: key);
  final String title;

  void onPressed() {
    fadeSystemUI();
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
            padding: const EdgeInsets.fromLTRB(30.0, 10.0, 25.0, 0.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  // flex: 10,
                  child: Marquee(
                    child: Text(title, style: Theme.of(context).textTheme.headline1),
                    animationDuration: const Duration(seconds: 2),
                    direction: Axis.horizontal,
                    backDuration: const Duration(milliseconds: 1000),
                    pauseDuration: const Duration(seconds: 2),
                  ),
                ),
                // const Spacer(),
                IconButton(
                  // alignment: Alignment.topCenter,
                  onPressed: onPressed,
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
                padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
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
          ChoiceChip(
            // shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(50))),
            disabledColor: const Color(0xFFD1D1D1),
            selectedColor: const Color(0xFF333333),
            backgroundColor: const Color(0xFFFCE48F),
            tooltip: "Get Suggestions",
            label: const Text('SUGGESTIONS'),
            labelStyle: TextStyle(
              fontSize: 12.0, 
              fontWeight: FontWeight.normal, 
              color: _value == 1 ? const Color(0xFFFFFFFF) : const Color(0xFF333333), 
              letterSpacing: -0.5
            ),
            visualDensity: VisualDensity.compact,
            selected: _value == 1,
            onSelected: (bool selected) {
              setState(() {
                fadeSystemUI();
                _value = selected ? 1 : 0;
              });
            },
          ),
          ChoiceChip(
            disabledColor: const Color(0xFFD1D1D1),
            selectedColor: const Color(0xFF333333),
            backgroundColor: const Color(0xFFFCE48F),
            tooltip: "My Favourites",
            label: const Text('FAVOURITES'),
            labelStyle: TextStyle(
              fontSize: 12.0, 
              fontWeight: FontWeight.normal, 
              color: _value == 2 ? const Color(0xFFFFFFFF) : const Color(0xFF333333), 
              letterSpacing: -0.5
            ),
            visualDensity: VisualDensity.compact,
            selected: _value == 2,
            onSelected: (bool selected) {
              setState(() {
                fadeSystemUI();
                _value = selected ? 2 : 0;
              });
            },
            
          ),
          ChoiceChip(
            disabledColor: const Color(0xFFD1D1D1),
            selectedColor: const Color(0xFF333333),
            backgroundColor: const Color(0xFFFCE48F),
            tooltip: "Find Categories",
            label: const Text('CATEGORIES'),
            labelStyle: TextStyle(
              fontSize: 12.0, 
              fontWeight: FontWeight.normal, 
              color: _value == 3 ? const Color(0xFFFFFFFF) : const Color(0xFF333333), 
              letterSpacing: -0.5
            ),
            visualDensity: VisualDensity.compact,
            selected: _value == 3,
            onSelected: (bool selected) {
              setState(() {
                fadeSystemUI();
                _value = selected ? 3 : 0;
              });
            },
          )
        ],
      ),
    );
  }
}