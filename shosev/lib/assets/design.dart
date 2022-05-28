import 'package:flutter/material.dart';

// My Colors
const Color primaryColor = Color(0xFFFFC804);
const Color primaryDarkColor = Color(0xFF755c02);
const Color primaryLightColor = Color(0xFFFFFB51);
const Color secondaryColor = Color(0xFFD1D1D1);
const Color secondaryDarkColor = Color(0xFFA0A0A0);
const Color textColor = Color(0xFF333333);
const Color textColor2 = Color(0xFFAAAAAA);
const Color placeholder = Color(0xFFE5E5E5);
const Color placeholder2 = Color(0xFFD1D1D1);
const Color white = Color(0xFFFFFFFF);
const Color red = Color(0xFFEE4949);

// My TextStyles
const TextStyle displayLarge = TextStyle(
    fontSize: 48.0,
    fontWeight: FontWeight.bold,
    color: textColor,
    letterSpacing: -0.5);
const TextStyle displayMedium = TextStyle(
    fontSize: 40.0,
    fontWeight: FontWeight.bold,
    color: textColor,
    letterSpacing: -0.5);
const TextStyle displaySmall = TextStyle(
    fontSize: 36.0,
    fontWeight: FontWeight.bold,
    color: textColor,
    letterSpacing: -0.5);
const TextStyle headlineLarge = TextStyle(
    fontSize: 32.0,
    fontWeight: FontWeight.bold,
    color: textColor,
    letterSpacing: -0.5);
const TextStyle headlineMedium = TextStyle(
    fontSize: 24.0,
    fontWeight: FontWeight.bold,
    color: textColor,
    letterSpacing: -0.5);
const TextStyle headlineSmall = TextStyle(
    fontSize: 20.0,
    fontWeight: FontWeight.bold,
    color: textColor,
    letterSpacing: -0.5);
const TextStyle titleLarge = TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.bold,
    color: textColor,
    letterSpacing: -0.5);
const TextStyle titleMedium = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.normal,
    color: textColor,
    letterSpacing: -0.5);
const TextStyle titleSmall = TextStyle(
    fontSize: 12.0,
    fontWeight: FontWeight.normal,
    color: textColor,
    letterSpacing: -0.5);
const TextStyle labelLarge = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.normal,
    color: textColor2,
    letterSpacing: -0.5);
const TextStyle labelMedium = TextStyle(
    fontSize: 12.0,
    fontWeight: FontWeight.normal,
    color: textColor,
    letterSpacing: -0.5);
const TextStyle labelSmall = TextStyle(
    fontSize: 10.0,
    fontWeight: FontWeight.normal,
    color: textColor,
    letterSpacing: -0.5);
const TextStyle bodyLarge = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.normal,
    color: textColor,
    letterSpacing: -0.5);
const TextStyle bodyMedium = TextStyle(
    fontSize: 13.0,
    fontWeight: FontWeight.normal,
    color: textColor,
    letterSpacing: -0.5);
const TextStyle bodySmall = TextStyle(
    fontSize: 9.0,
    fontWeight: FontWeight.normal,
    color: textColor,
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
  // primarySwatch: _primaryColor,
  primaryColor: primaryColor,
  scaffoldBackgroundColor: white,
  dividerColor: placeholder2,
  fontFamily: 'Nunito Sans',
  splashColor: secondaryColor,
  visualDensity: VisualDensity.compact,
  colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: primaryColor,
      onPrimary: textColor,
      secondary: primaryColor,
      onSecondary: textColor,
      error: red,
      onError: textColor,
      background: placeholder,
      onBackground: textColor,
      surface: white,
      onSurface: textColor),
  textTheme: const TextTheme(
    displayLarge: displayLarge,
    displayMedium: displayMedium,
    displaySmall: displaySmall,
    headlineLarge: headlineLarge,
    headlineMedium: headlineMedium,
    headlineSmall: headlineSmall,
    titleLarge: titleLarge,
    titleMedium: titleMedium,
    titleSmall: titleSmall,
    labelLarge: labelLarge,
    labelMedium: labelMedium,
    labelSmall: labelSmall,
    bodyLarge: bodyLarge,
    bodyMedium: bodyMedium,
    bodySmall: bodySmall
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
        color: white,
        border: Border.all(
          width: 1,
          color: textColor,
        ),
      ),
      child: const FittedBox(
        fit: BoxFit.scaleDown,
          child: Text(
            'ShoSev',
            style: TextStyle(
              fontSize: 38.0,
              fontWeight: FontWeight.bold,
              color: textColor,
              letterSpacing: -0.5
            ),
          textScaleFactor: 1.0,
        )
      ),
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
        color: primaryColor,
      ),
      child: const FittedBox(
        fit: BoxFit.scaleDown,
          child: Text(
          'ShoSev',
          textScaleFactor: 1.0,
          style: TextStyle(
            fontSize: 38.0,
            fontWeight: FontWeight.bold,
            color: textColor,
            letterSpacing: -0.5
          ),
        )
      ),
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
        color: white,
      ),
      child: const FittedBox(
        fit: BoxFit.scaleDown,
          child: Text(
          'ShoSev',
          textScaleFactor: 1.0,
          style: TextStyle(
            fontSize: 38.0,
            fontWeight: FontWeight.bold,
            color: textColor,
            letterSpacing: -0.5
          ),
        )
      ),
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
  final Image img;

  final String heading;
  final String text1;
  final String text2;

  final void Function() onClick;
  final void Function() deleteOnClick;
  final void Function() updateOnClick;

  const CardDesign1({Key? key, required this.isHeading, required this.isText1, required this.isText2, required this.heading, required this.text1, required this.text2, required this.onClick, required this.isPhoto, required this.deleteShow, required this.updateShow, required this.deleteOnClick, required this.updateOnClick, required this.img}) : super(key: key);

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
                      child: img,
                    ),
                  ),
                Flexible(
                  fit: FlexFit.loose,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (isHeading)
                        Text(heading, style: Theme.of(context).textTheme.titleLarge, overflow: TextOverflow.ellipsis,),
                      if (isText1)
                        Text(text1, style: Theme.of(context).textTheme.bodyMedium, overflow: TextOverflow.ellipsis,),
                      if (isText2)
                        Text(text2, style: Theme.of(context).textTheme.bodyMedium, overflow: TextOverflow.ellipsis,),
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