import 'package:flutter/material.dart';

class MySearch extends StatelessWidget {
  const MySearch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.white,
      height: 40,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: Colors.white, 
        borderRadius: BorderRadius.all(Radius.circular(30.0)),
        boxShadow: [
          BoxShadow(
            color: Color(0xFFAAAAAA),
            blurRadius: 4.0,
            offset: Offset(0, 4),
          )
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Expanded(
            child: TextField(
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Color(0xFF333333), letterSpacing: -0.5),
              cursorColor: Color(0xFF333333),
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.go,
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.fromLTRB(20, 0, 5, 5),
                hintText: "Search...",
                hintStyle: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Color(0xFFD1D1D1), letterSpacing: -0.5),
              ),
            ),
          ),
          IconButton(
            alignment: Alignment.center,
            tooltip: "Find Shops & Services",
            icon: const Icon(
              Icons.search, 
              color: Color(0xFFD1D1D1),
            ),
            onPressed: () {},
          )
        ],
      ),
    );
  }
}