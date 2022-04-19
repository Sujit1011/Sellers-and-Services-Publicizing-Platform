import 'package:flutter/material.dart';
import 'package:shosev/shopProfile.dart' as shopProfile;
import 'package:shosev/serviceProfile.dart' as serviceProfile;

// My Colors
const Color _primiaryColor = Color(0xFFFFC804);
const Color _secondaryColor = Color(0xFFFCE48F);
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
final _boldButtonStyle = TextButton.styleFrom(
  backgroundColor: const Color(0xFFFFC804),
  primary: const Color(0xFF333333),
  minimumSize: const Size(108, 32),
  padding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 14),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(30.0)),
  ),
);

final _simpleButtonStyle = TextButton.styleFrom(
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
      surface: _placeholder,
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
      child: const Center(
          child: Text(
        'ShoSev',
        style: _heading1,
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
      child: const Center(
          child: Text(
        'ShoSev',
        style: _heading1,
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
      child: const Center(
          child: Text(
        'ShoSev',
        style: _heading1,
      )),
    );
  }
}

class AllShopsServices extends StatefulWidget {
  const AllShopsServices({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<AllShopsServices> createState() => _AllShopsServicesState();
}

class _AllShopsServicesState extends State<AllShopsServices> {
  void _choice() {
    setState(() {
      (widget.title == "My Shops")
          ? Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const shopProfile.ShopProfilePage(
                      rating: 4,
                      shopName: "My Shops",
                      joined: '2022',
                      reviews: 22,
                      contacted: 22,
                      aboutUs: 'Hello World')),
            )
          : Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const serviceProfile.ServiceProfilePage(
                      rating: 4,
                      shopName: "My Services",
                      joined: '2022',
                      reviews: 22,
                      contacted: 22,
                      aboutUs: 'Hello World')),
            );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 13.0),
      child: InkWell(
        child: Container(
          height: 78,
          decoration: BoxDecoration(
            border: Border.all(
              color: Color(0xFFD1D1D1),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundColor: Colors.black,
                minRadius: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 0.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Sujit Soren",
                        style: Theme.of(context).textTheme.headline2),
                    Text("+91 987 654 3210"),
                  ],
                ),
              ),
              Icon(
                Icons.double_arrow,
                color: Color(0xFFD1D1D1),
                size: 44.0,
              )
            ],
          ),
        ),
        onTap: _choice,
      ),
    );
  }
}
