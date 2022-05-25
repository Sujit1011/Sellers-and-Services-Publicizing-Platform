import 'package:flutter/material.dart';

// My Colors
const Color _primiaryColor = Color(0xFFFFC804);
const Color _secondaryColor = Color(0xFFD1D1D1);
const Color _textColor = Color(0xFF333333);
const Color _textColor2 = Color(0xFFAAAAAA);
const Color _placeholder = Color(0xFFE5E5E5);
const Color _placeholder2 = Color(0xFFD1D1D1);
const Color _white = Color(0xFFFFFFFF);
const Color _red = Color(0xFFEE4949);

// My TextStyles
const TextStyle _heading1 = TextStyle(
    fontSize: 40.0,
    fontWeight: FontWeight.bold,
    color: _textColor,
    letterSpacing: -0.5);
const TextStyle _heading2 = TextStyle(
    fontSize: 24.0,
    fontWeight: FontWeight.bold,
    color: _textColor,
    letterSpacing: -0.5);
const TextStyle _heading3 = TextStyle(
    fontSize: 20.0,
    fontWeight: FontWeight.normal,
    color: _textColor,
    letterSpacing: -0.5);
const TextStyle _heading4 = TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.bold,
    color: _textColor,
    letterSpacing: -0.5);
const TextStyle _heading5 = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.bold,
    color: _textColor,
    letterSpacing: -0.5);
const TextStyle _heading6 = TextStyle(
    fontSize: 12.0,
    fontWeight: FontWeight.normal,
    color: _textColor,
    letterSpacing: -0.5);
const TextStyle _heading6Placeholder = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.bold,
    color: _textColor2,
    letterSpacing: -0.5);
const TextStyle _bodyText = TextStyle(
    fontSize: 12.0,
    fontWeight: FontWeight.bold,
    color: _textColor,
    letterSpacing: -0.5);

// My Buttton Styles
final simpleButtonStyle = TextButton.styleFrom(
  backgroundColor: const Color(0xFFFFC804),
  primary: const Color(0xFF333333),
  minimumSize: const Size(108, 23),
  padding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 14),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(30.0)),
  ),
);

// My ThemeData
final myThemeData = ThemeData(
  // primarySwatch: _primiary_color,
  primaryColor: _primiaryColor,
  scaffoldBackgroundColor: _white,
  dividerColor: _placeholder2,
  fontFamily: 'Nunito Sans',
  splashColor: _secondaryColor,
  visualDensity: VisualDensity.compact,
  colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: _primiaryColor,
      onPrimary: _textColor,
      secondary: _primiaryColor,
      onSecondary: _textColor,
      error: _red,
      onError: _textColor,
      background: _placeholder,
      onBackground: _textColor,
      surface: _white,
      onSurface: _textColor),
  textTheme: const TextTheme(
    headline1: _heading1,
    headline2: _heading2,
    headline3: _heading3,
    headline4: _heading4,
    headline5: _heading5,
    headline6: _heading6,
    bodyText1: _bodyText,
    overline: _heading6Placeholder,
  ),
  // dividerTheme: const DividerThemeData(
  //   space: 42,
  //   thickness: 2,
  //   indent: 20,
  //   endIndent: 20,
  //   color: Color(0xFFE5E5E5),
  // ),
);

// My Logos
class LogoSimple extends StatelessWidget {
  const LogoSimple({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 155,
      width: 155,
      margin: const EdgeInsets.all(5.0),
      padding: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _white,
        border: Border.all(
          width: 1,
          color: _textColor,
        ),
      ),
      child: const FittedBox(
        fit: BoxFit.scaleDown,
          child: Text(
        'ShoSev',
        style: TextStyle(
          fontSize: 34.0,
          fontWeight: FontWeight.bold,
          color: _textColor,
          letterSpacing: -0.5
        ),
      )),
    );
  }
}

class LogoOnWhite extends StatelessWidget {
  const LogoOnWhite({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 155,
      width: 155,
      margin: const EdgeInsets.all(5.0),
      padding: const EdgeInsets.all(5.0),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: _primiaryColor,
      ),
      child: const FittedBox(
        fit: BoxFit.scaleDown,
          child: Text(
        'ShoSev',
        style: TextStyle(
          fontSize: 34.0,
          fontWeight: FontWeight.bold,
          color: _textColor,
          letterSpacing: -0.5
        ),
      )),
    );
  }
}

class LogoOnColored extends StatelessWidget {
  const LogoOnColored({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 155,
      width: 155,
      margin: const EdgeInsets.all(5.0),
      padding: const EdgeInsets.all(5.0),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: _white,
      ),
      child: const FittedBox(
        fit: BoxFit.scaleDown,
          child: Text(
        'ShoSev',
        style: TextStyle(
          fontSize: 34.0,
          fontWeight: FontWeight.bold,
          color: _textColor,
          letterSpacing: -0.5
        ),
      )),
    );
  }
}

class CardDesign1 extends StatelessWidget {

  final bool isHeading;
  final bool isText1;
  final bool isText2;
  final bool isPhoto;
  final bool deleteShow;
  final bool updateShow;

  final String heading;
  final String text1;
  final String text2;

  final void Function() onClick;
  final void Function() deleteOnClick;
  final void Function() updateOnClick;

  const CardDesign1({Key? key, required this.isHeading, required this.isText1, required this.isText2, required this.heading, required this.text1, required this.text2, required this.onClick, required this.isPhoto, required this.deleteShow, required this.updateShow, required this.deleteOnClick, required this.updateOnClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom:12),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(20.0)
        ),
        border: Border.all(
          color: const Color(0xFFD1D1D1), 
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Visibility(
            visible: updateShow,
            child: IconButton(
              onPressed: updateOnClick,
              color: Colors.blue.shade700,
              icon: const Icon(Icons.update_rounded)
            ),
          ),
          Expanded(
            flex: 5,
            child: InkWell(
              onTap: onClick,
              child: Row(
                children: [
                if (isPhoto)
                  Padding(
                    padding: const EdgeInsets.only(left:9, bottom:9, top:9, right:12),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                      child: Image.asset(
                        'lib/assets/img/shop.png',
                        width: 60,
                        height: 60,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                Flexible(
                  fit: FlexFit.loose,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (isHeading)
                        Text(heading, style: Theme.of(context).textTheme.headline4, overflow: TextOverflow.ellipsis,),
                      if (isText1)
                        Text(text1, style: Theme.of(context).textTheme.headline5, overflow: TextOverflow.ellipsis,),
                      if (isText2)
                        Text(text2, style: Theme.of(context).textTheme.headline5, overflow: TextOverflow.ellipsis,),
                    ],
                  )
                ),
              ],),
            ),
          ),
          Visibility(
            visible: deleteShow,
            child: IconButton(
              onPressed: deleteOnClick,
              color: Colors.red.shade900,
              icon: const Icon(Icons.delete_rounded)
            ),
          ),
          
          
          
        ],
      ),
    );
  }
}