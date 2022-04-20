import 'package:flutter/material.dart';
// import 'package:marquee_widget/marquee_widget.dart';
import 'assets/design.dart' as design;
import 'appbar.dart' as appbar;
import 'all_shops_services.dart' as all_shops_services;
import 'about.dart' as about;
import 'dart:math';

class signupdrawer extends StatelessWidget {
  const signupdrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isSwitched = false;
    bool _shareValue = false;

    return Padding(
      padding: const EdgeInsets.all(11.0),
      child: SizedBox(
        width: 272,
        child: Drawer(
          backgroundColor: const Color(0xFFFFC804),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(30)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // const Spacer(),
              const design.LogoOnColored(),
              const SizedBox(
                height: 66,
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(34, 0, 34, 11),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.white,
                      ),
                      child: TextField(
                        style: const TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF333333),
                            letterSpacing: -0.5),
                        cursorColor: const Color(0xFF333333),
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.go,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0)),
                          contentPadding:
                              const EdgeInsets.fromLTRB(20, 0, 5, 5),
                          hintText: "phone number",
                          hintStyle: const TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFD1D1D1),
                              letterSpacing: -0.5),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(34, 0, 34, 11),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.white,
                      ),
                      child: TextField(
                        obscureText: true,
                        style: const TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF333333),
                            letterSpacing: -0.5),
                        cursorColor: const Color(0xFF333333),
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.go,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0)),
                          contentPadding:
                              const EdgeInsets.fromLTRB(20, 0, 5, 5),
                          hintText: "password",
                          hintStyle: const TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFD1D1D1),
                              letterSpacing: -0.5),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(34, 0, 34, 11),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(color: Colors.white)),
                        child: Row(
                          children: [
                            Center(
                              child: Switch(
                                value: isSwitched,
                                onChanged: (value) {
                                  setState(() {
                                    isSwitched = value;
                                    print(isSwitched);
                                  });
                                },
                                activeTrackColor: Colors.lightGreenAccent,
                                activeColor: Colors.green,
                              ),
                            ),
                            const Text(
                                "Become a seller or \na service provider")
                          ],
                        ),
                      )),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(34, 0, 34, 11),
                    child: Row(
                      children: [
                        InkWell(
                          child: Container(
                            width: 96.0,
                            height: 30.0,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                border:
                                    Border.all(color: const Color(0xFF333333))),
                            child: const Center(
                              child: Text("SIGN-IN"),
                            ),
                          ),
                          onTap: () {
                            print("Tapped on container");
                          },
                        ),
                        const Spacer(),
                        Container(
                          width: 96.0,
                          height: 30.0,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: const Color(0xFF333333)),
                          child: const Center(
                            child: Text(
                              "SIGN-UP",
                              style: TextStyle(color: Color(0xFFFFFFFF)),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 188,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(34, 0, 34, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(
                          child: ChoiceChip(
                            padding: const EdgeInsets.fromLTRB(2, 0, 2, 0),
                            disabledColor: const Color(0xFFD1D1D1),
                            selectedColor: const Color(0xFF333333),
                            backgroundColor: const Color(0xFFFCE48F),
                            tooltip: "",
                            label: const SizedBox(
                                width: 70,
                                height: 23,
                                child: Center(child: Text('ABOUT US'))),
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
                        Center(
                          child: ChoiceChip(
                            padding: const EdgeInsets.fromLTRB(2, 0, 2, 0),
                            disabledColor: const Color(0xFFD1D1D1),
                            selectedColor: const Color(0xFF333333),
                            backgroundColor: const Color(0xFFFCE48F),
                            tooltip: "Help",
                            label: SizedBox(
                                width: 70,
                                height: 23,
                                child: const Center(child: Text('HELP'))),
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
                        )
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void setState(Null Function() param0) {}
}

class signindrawer1 extends StatelessWidget {
  const signindrawer1({Key? key, required this.businessmember})
      : super(key: key);

  final bool businessmember;

  String generateRandomString(int len) {
    var r = Random();
    const _chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    return List.generate(len, (index) => _chars[r.nextInt(_chars.length)])
        .join();
  }

  @override
  Widget build(BuildContext context) {
    // bool isSwitched = false;
    bool _shareValue = false;
    return Padding(
        padding: const EdgeInsets.all(11.0),
        child: Container(
            width: 272,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                border: Border(
                    left: BorderSide(color: Color(0xFFFFC804), width: 2.0),
                    top: BorderSide(color: Color(0xFFFFC804), width: 2.0),
                    right: BorderSide(color: Color(0xFFFFC804), width: 2.0),
                    bottom: BorderSide(color: Color(0xFFFFC804), width: 2.0))),
            child: Drawer(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(30)),
              ),
              child: Stack(
                children: <Widget>[
                  Column(
                    children: [
                      Container(
                          height: 146,
                          // width: double.infinity,
                          // color: Color(0xFFFFC804),
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(28.0),
                                topRight: Radius.circular(28.0)),
                            color: Color(0xFFE5E5E5),
                          )),
                      Expanded(
                          child: Container(
                        padding: const EdgeInsets.fromLTRB(35, 80, 30, 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 0, bottom: 20.0),
                              child: SizedBox(
                                height: 55,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "User Name",
                                      style:
                                          Theme.of(context).textTheme.headline2,
                                    ),
                                    const Text("+91 XXXXX XXXXX",
                                        style: TextStyle(
                                            color: Color(0xFFAAAAAA),
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold))
                                  ],
                                ),
                              ),
                            ),
                            if (businessmember == true)
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: TextButton.icon(
                                  style: TextButton.styleFrom(
                                    backgroundColor: const Color(0xFFFFC804),
                                    primary: const Color(0xFF333333),
                                    minimumSize: const Size(204, 40),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 2.0, vertical: 14),
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(30.0)),
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const all_shops_services
                                                  .All_Shops_Services(
                                                title: "My Shops",
                                                aboutUs: "Sujit Soren",
                                              )),
                                    );
                                  },
                                  icon: const Icon(Icons.shopping_bag),
                                  label: const Text(
                                    "MY SHOPS",
                                    style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.normal,
                                        color: Color(0xFF333333),
                                        letterSpacing: -0.5),
                                  ),
                                ),
                              ),
                            if (businessmember == true)
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: TextButton.icon(
                                  style: TextButton.styleFrom(
                                    backgroundColor: const Color(0xFFFFC804),
                                    primary: const Color(0xFF333333),
                                    minimumSize: const Size(204, 40),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 2.0, vertical: 14),
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(30.0)),
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const all_shops_services
                                                  .All_Shops_Services(
                                                title: "My Services",
                                                aboutUs: "Sujit Soren",
                                              )),
                                    );
                                  },
                                  icon: const Icon(
                                      Icons.home_repair_service_rounded),
                                  label: const Text(
                                    "MY SERVICES",
                                    style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.normal,
                                        color: Color(0xFF333333),
                                        letterSpacing: -0.5),
                                  ),
                                ),
                              ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: TextButton.icon(
                                style: TextButton.styleFrom(
                                  backgroundColor: const Color(0xFFFFFFFF),
                                  primary: const Color(0xFF333333),
                                  minimumSize: const Size(204, 40),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 2.0, vertical: 14),
                                  // shape: const RoundedRectangleBorder(
                                  //   borderRadius:
                                  //       BorderRadius.all(Radius.circular(30.0)),
                                  // ),
                                  shape: RoundedRectangleBorder(
                                      side: const BorderSide(
                                          color: Color(0xFFFFC804),
                                          width: 1,
                                          style: BorderStyle.solid),
                                      borderRadius: BorderRadius.circular(30)),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const all_shops_services
                                                .All_Shops_Services(
                                              title: "My History",
                                              aboutUs: "Sujit Soren",
                                            )),
                                  );
                                },
                                icon: const Icon(Icons.history),
                                label: const Text(
                                  "MY HISTORY",
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.normal,
                                      color: Color(0xFF333333),
                                      letterSpacing: -0.5),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: TextButton.icon(
                                style: TextButton.styleFrom(
                                  backgroundColor: const Color(0xFFFFFFFF),
                                  primary: const Color(0xFF333333),
                                  minimumSize: const Size(204, 40),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 2.0, vertical: 14),
                                  // shape: const RoundedRectangleBorder(
                                  //   borderRadius:
                                  //       BorderRadius.all(Radius.circular(30.0)),
                                  // ),
                                  shape: RoundedRectangleBorder(
                                      side: const BorderSide(
                                          color: Color(0xFFFFC804),
                                          width: 1,
                                          style: BorderStyle.solid),
                                      borderRadius: BorderRadius.circular(30)),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const all_shops_services
                                                .All_Shops_Services(
                                              title: "My Favourites",
                                              aboutUs: "Sujit Soren",
                                            )),
                                  );
                                },
                                icon: const Icon(Icons.favorite),
                                label: const Text(
                                  "MY FAVOURITES",
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.normal,
                                      color: Color(0xFF333333),
                                      letterSpacing: -0.5),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: TextButton.icon(
                                style: TextButton.styleFrom(
                                  backgroundColor: const Color(0xFFFFFFFF),
                                  primary: const Color(0xFF333333),
                                  minimumSize: const Size(204, 40),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 2.0, vertical: 14),
                                  // shape: const RoundedRectangleBorder(
                                  //   borderRadius:
                                  //       BorderRadius.all(Radius.circular(30.0)),
                                  // ),
                                  shape: RoundedRectangleBorder(
                                      side: const BorderSide(
                                          color: Color(0xFFFFC804),
                                          width: 1,
                                          style: BorderStyle.solid),
                                      borderRadius: BorderRadius.circular(30)),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const all_shops_services
                                                .All_Shops_Services(
                                              title: "My Reviews",
                                              aboutUs: "Sujit Soren",
                                            )),
                                  );
                                },
                                icon: const Icon(Icons.reviews),
                                label: const Text(
                                  "MY REVIEWS",
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.normal,
                                      color: Color(0xFF333333),
                                      letterSpacing: -0.5),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: TextButton.icon(
                                style: TextButton.styleFrom(
                                  backgroundColor: const Color(0xFFE5E5E5),
                                  primary: const Color(0xFF333333),
                                  minimumSize: const Size(204, 40),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 2.0, vertical: 14),
                                  shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30.0)),
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const all_shops_services
                                                .All_Shops_Services(
                                              title: "Edit Profile",
                                              aboutUs: "Sujit Soren",
                                            )),
                                  );
                                },
                                icon: const Icon(Icons.edit),
                                label: const Text(
                                  "EDIT PROFILE",
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.normal,
                                      color: Color(0xFF333333),
                                      letterSpacing: -0.5),
                                ),
                              ),
                            ),
                            const Spacer(),
                            OutlinedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        const Color(0xFFEE4949)),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                  ),
                                ),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const all_shops_services
                                              .All_Shops_Services(
                                            title: "My Reviews",
                                            aboutUs: "Sujit Soren",
                                          )),
                                );
                              },
                              child: const Text(
                                "Logout",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            const Spacer(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                OutlinedButton(
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            const Color(0xFFFCE48F)),
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(18.0),
                                      ),
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => about.MyAboutUs(
                                              title: "About Us",
                                              aboutUs:
                                                  generateRandomString(2000))),
                                    );
                                  },
                                  child: const Text(
                                    "About Us",
                                    style: TextStyle(color: Color(0xFF333333)),
                                  ),
                                ),
                                OutlinedButton(
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            const Color(0xFFFCE48F)),
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(18.0),
                                      ),
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => about.MyAboutUs(
                                              title: "About Us",
                                              aboutUs:
                                                  generateRandomString(2000))),
                                    );
                                  },
                                  child: const Text(
                                    "Help",
                                    style: TextStyle(color: Color(0xFF333333)),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ))
                    ],
                  ),
                  const Positioned(
                      top: 62, left: 30, right: 30, child: design.LogoSimple())
                ],
              ),
            )));
  }

  void setState(Null Function() param0) {}
}
