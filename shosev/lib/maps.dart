import 'package:flutter/material.dart';

class MyMap extends StatelessWidget {
  const MyMap({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'lib/assets/img/Map.png',
      fit: BoxFit.fitWidth,
    );
  }
}