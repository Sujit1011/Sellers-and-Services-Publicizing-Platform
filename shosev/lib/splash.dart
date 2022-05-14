import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shosev/main.dart';
import 'package:shosev/services/auth.dart';
import 'package:shosev/assets/design.dart' as design;
import 'package:shosev/models/SS_User.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    _navigatetohome();
  }

  _navigatetohome() async {
    await Future.delayed(const Duration(milliseconds: 1500), () {});
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => StreamProvider<SS_User?>.value(
          value: AuthService().user,
          initialData: null,
          child: const MyHomePage(title: 'Flutter Demo Home Page')
        )
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFC804),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    SizedBox(
                      height: 168, 
                      width: 168, 
                      child: design.LogoOnColored()
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 62,
                child: Center(
                  child: Text("Shops & Services",
                    style: Theme.of(context).textTheme.headline2),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
