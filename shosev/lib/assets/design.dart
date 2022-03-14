import 'package:flutter/material.dart';


// My Colors
const Color _primiaryColor = Color(0xFFFFC804);
const Color _secondaryColor = Color(0xFFF9C201);
const Color _textColor = Color(0xFF333333);
const Color _textColor2 = Color(0xFFAAAAAA);
const Color _placeholder = Color(0xFFE5E5E5);
const Color _placeholder2 = Color(0xFFD1D1D1);
const Color _white = Color(0xFFFFFFFF);
const Color _red = Color(0xFFEE4949);

// My TextStyles
const TextStyle _heading1 = TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold, color: _textColor, letterSpacing: -0.5);
const TextStyle _heading2 = TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: _textColor, letterSpacing: -0.5);
const TextStyle _heading3 = TextStyle(fontSize: 20.0, fontWeight: FontWeight.normal, color: _textColor, letterSpacing: -0.5);
const TextStyle _heading4 = TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: _textColor, letterSpacing: -0.5);
const TextStyle _heading5 = TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold, color: _textColor, letterSpacing: -0.5);
const TextStyle _heading6 = TextStyle(fontSize: 12.0, fontWeight: FontWeight.normal, color: _textColor, letterSpacing: -0.5);
const TextStyle _heading6Placeholder = TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold, color: _textColor2, letterSpacing: -0.5);
const TextStyle _bodyText = TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold, color: _textColor, letterSpacing: -0.5);


final my_theme_data = ThemeData(
  // primarySwatch: _primiary_color,
  primaryColor : _primiaryColor,
  scaffoldBackgroundColor : _white,
  dividerColor : _placeholder2,
  fontFamily : 'Nunito Sans',
  splashColor: _textColor,
  colorScheme: const ColorScheme(
    brightness: Brightness.light, 
    primary: _primiaryColor, 
    onPrimary: _textColor, 
    secondary: _secondaryColor, 
    onSecondary: _textColor, 
    error: _red, 
    onError: _textColor, 
    background: _placeholder, 
    onBackground: _textColor, 
    surface: _placeholder, 
    onSurface: _textColor
  ),
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
  
);


class LogoSimple extends StatelessWidget {
  const LogoSimple({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}