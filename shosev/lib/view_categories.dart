// import 'package:cloud_firestore/cloud_firestore.dart' show QuerySnapshot;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart' show AlertDialog, AsyncSnapshot, BorderRadius, BuildContext, Card, Center, CircleAvatar, CircularProgressIndicator, Color, Colors, Column, Container, CrossAxisAlignment, EdgeInsets, Expanded, FloatingActionButton, FloatingActionButtonLocation, FlutterLogo, GestureDetector, GridView, Icon, Icons, InkWell, Key, ListView, MainAxisAlignment, MainAxisSize, MaterialPageRoute, Navigator, Padding, RoundedRectangleBorder, Row, Scaffold, SizedBox, Spacer, Stack, State, StatefulWidget, StreamBuilder, Text, TextButton, Theme, Widget, showDialog;
import 'package:provider/provider.dart' show Provider;
import 'package:font_awesome_flutter/font_awesome_flutter.dart' show FaIcon, FontAwesomeIcons;
import 'package:shosev/list_page.dart' show ListPage, listPageType;

// import 'package:shosev/assets/design.dart' as design;
import 'package:shosev/models/SS_User.dart' show SS_User;
// import 'package:shosev/service_profile.dart' show ServiceProfilePage;
// import 'package:shosev/shop_profile.dart' show ShopProfilePage;

import 'package:shosev/services/data_repository.dart' show DataRepository;

class Categories extends StatefulWidget {
  final String title;
  final bool isLeftFloattingButton;
  final Icon leftIcon;
  final Icon rightIcon;
  final String heroLeft;
  final String heroRight;

  final Function leftClick;

  const Categories({Key? key,
  required this.title,
  required this.isLeftFloattingButton,
  required this.leftClick,
  required this.leftIcon, 
  required this.rightIcon,
  required this.heroLeft,
  required this.heroRight, 
  }) : super(key: key);

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {

  dynamic data;
  final DataRepository repository = DataRepository();



  void list_shop(String location, data){
    print(location);
    setState(() {
      {
        Navigator.push(context, MaterialPageRoute(builder: (context) =>
          ListPage(
              title: "Shops",
              username: (data != null)?data.userName:"",
              phoneNo: (data != null)?data.phoneNo:"",
              isLeftFloattingButton: true,
              isEditFloattingButton: false,
              isRightFloattingButton: false,
              leftClick: () => {
                Navigator.pop(context)
              },
              rightClick: () => {},
              leftIcon: const Icon(Icons.chevron_left_rounded),
              rightIcon: const Icon(Icons.add_rounded),
              heroLeft: "shop_left",
              heroRight: "shop_right",
              documentFieldStream: repository.ss_services_collection.snapshots(),
              documentFieldStream1: repository.ss_services_collection.where("businessId", isEqualTo: "aaa").snapshots(),
              onClickWidget: true,
              type: listPageType.shop,
              deleteItemFn: (id) {},
              updateItemFn: (id){},
            )
          
          ));
      }
    });
  }

  void list_service(String location, data){
    print(location);
    print(repository.ss_services_collection.where("category", isEqualTo: location).snapshots());
    setState(() {
      {
        Navigator.push(context, MaterialPageRoute(builder: (context) =>
          ListPage(
              title: "Services",
              username: (data != null)?data.userName:"",
              phoneNo: (data != null)?data.phoneNo:"",
              isLeftFloattingButton: true,
              isEditFloattingButton: false,
              isRightFloattingButton: false,
              leftClick: () => {
                Navigator.pop(context)
              },
              rightClick: () => {},
              leftIcon: const Icon(Icons.chevron_left_rounded),
              rightIcon: const Icon(Icons.add_rounded),
              heroLeft: "shop_left",
              heroRight: "shop_right",
              documentFieldStream: repository.ss_services_collection.snapshots(),
              documentFieldStream1: repository.ss_services_collection.where("businessId", isEqualTo: "aaa").snapshots(),
              onClickWidget: true,
              type: listPageType.shop,
              deleteItemFn: (id) {},
              updateItemFn: (id){},
            )
          
          ));
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    final data = Provider.of<SS_User?>(context);
    print(data?.userName);
    String _myUser = data?.uid as String;
    // print(_myUser);
    DataRepository repository = DataRepository();
    print(repository.ss_services_collection.where("businessId", isEqualTo: "XHHcrmhIxpNX2jnjWlSZaWpX7DI3").snapshots());
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Column(
            children: [
              //Cover
              Container(
                height: 146,
                width: double.infinity,
                color: const Color(0xFFD1D1D1),
                child: Padding(
                  padding: const EdgeInsets.only(left: 26, right: 26),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        backgroundColor: Colors.black,
                        minRadius: 44.5,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              (data != null)?data.userName:"",
                              style: Theme.of(context).textTheme.headline2
                            ),
                            Text(
                              (data != null)?data.phoneNo:"",
                              style: Theme.of(context).textTheme.headline5
                            )
                          ],
                        ),
                      ),
                      const Spacer()
                    ],
                  ),
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(35, 120, 30, 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 12, top: 38),
                  child: Center(
                    child: Text(
                      widget.title,
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  ),
                ),
                Expanded(
                  child: GridView.count(
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    crossAxisCount: 2,
                    childAspectRatio: .90,
                    children: [
                      GestureDetector(
                          onTap: () {
                            list_shop("Bakery Shop", data);
                          },
                          child: Container(
                            child: Card(
                            elevation: 10,
                            color: const Color(0xFFFFC804),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            child: Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[const FaIcon(FontAwesomeIcons.cakeCandles,size: 80), Text('Bakery Shop',style: Theme.of(context).textTheme.headline4)],
                              ),
                            ),
                          )),
                        ),
                       GestureDetector(
                          onTap: () {
                            list_shop("Barber Shop", data);
                          },
                          child: Container(
                            child: Card(
                            elevation: 10,
                            color: const Color(0xFFFFC804),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            child: Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[const FaIcon(FontAwesomeIcons.cut,size: 80), Text('Barber Shop',style: Theme.of(context).textTheme.headline4)],
                              ),
                            ),
                          )),
                        ),
                       GestureDetector(
                          onTap: () {
                            list_shop("Book Shop", data);
                          },
                          child: Container(
                            child: Card(
                            elevation: 10,
                            color: const Color(0xFFFFC804),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            child: Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[const FaIcon(FontAwesomeIcons.book,size: 80), Text('Book Shop',style: Theme.of(context).textTheme.headline4)],
                              ),
                            ),
                          )),
                        ),
                       GestureDetector(
                          onTap: () {
                            list_service("Business Service", data);
                          },
                          child: Container(
                            child: Card(
                            elevation: 10,
                            color: const Color(0xFFFFC804),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            child: Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[const FaIcon(FontAwesomeIcons.businessTime,size: 80), Text('Business Service',style: Theme.of(context).textTheme.headline4)],
                              ),
                            ),
                          )),
                        ),
                       GestureDetector(
                          onTap: () {
                            list_shop("Cloth Shop", data);
                          },
                          child: Container(
                            child: Card(
                            elevation: 10,
                            color: const Color(0xFFFFC804),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            child: Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[const FaIcon(FontAwesomeIcons.shirt,size: 80), Text('Cloth Shop',style: Theme.of(context).textTheme.headline4)],
                              ),
                            ),
                          )),
                        ),
                       GestureDetector(
                          onTap: () {
                            list_service("Communication Service", data);
                          },
                          child: Container(
                            child: Card(
                            elevation: 10,
                            color: const Color(0xFFFFC804),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            child: Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[const FaIcon(FontAwesomeIcons.comment,size: 80), Text('Communication Service',style: Theme.of(context).textTheme.headline5)],
                              ),
                            ),
                          )),
                        ),
                       GestureDetector(
                          onTap: () {
                            list_service("Construction and Engineering Service", data);
                          },
                          child: Container(
                            child: Card(
                            elevation: 10,
                            color: const Color(0xFFFFC804),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            child: Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[const FaIcon(FontAwesomeIcons.personDigging,size: 80), Text('Construction and Engineering Service',style: Theme.of(context).textTheme.headline4)],
                              ),
                            ),
                          )),
                        ),
                       GestureDetector(
                          onTap: () {
                            list_service("Distribution Service", data);
                          },
                          child: Container(
                            child: Card(
                            elevation: 10,
                            color: const Color(0xFFFFC804),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            child: Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[const FaIcon(FontAwesomeIcons.truck,size: 80), Text('Distribution Service',style: Theme.of(context).textTheme.headline4)],
                              ),
                            ),
                          )),
                        ),
                       GestureDetector(
                          onTap: () {
                            list_shop("DIY Shop", data);
                          },
                          child: Container(
                            child: Card(
                            elevation: 10,
                            color: const Color(0xFFFFC804),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            child: Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[const FaIcon(FontAwesomeIcons.paintbrush,size: 80), Text('DIY Store',style: Theme.of(context).textTheme.headline4)],
                              ),
                            ),
                          )),
                        ),
                       GestureDetector(
                          onTap: () {
                            list_service("Education", data);
                          },
                          child: Container(
                            child: Card(
                            elevation: 10,
                            color: const Color(0xFFFFC804),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            child: Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[const FaIcon(FontAwesomeIcons.bookOpen,size: 80), Text('Education',style: Theme.of(context).textTheme.headline4)],
                              ),
                            ),
                          )),
                        ),
                       GestureDetector(
                          onTap: () {
                            list_service("Environmental Services", data);
                          },
                          child: Container(
                            child: Card(
                            elevation: 10,
                            color: const Color(0xFFFFC804),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            child: Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[const FaIcon(FontAwesomeIcons.treeCity,size: 80), Text('Environment Service',style: Theme.of(context).textTheme.headline4)],
                              ),
                            ),
                          )),
                        ),
                       GestureDetector(
                          onTap: () {
                            list_shop("Eyewear Shop", data);
                          },
                          child: Container(
                            child: Card(
                            elevation: 10,
                            color: const Color(0xFFFFC804),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            child: Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[const FaIcon(FontAwesomeIcons.glasses,size: 80), Text('Eyewear Shop',style: Theme.of(context).textTheme.headline4)],
                              ),
                            ),
                          )),
                        ),
                       GestureDetector(
                          onTap: () {
                            list_service("Finance Service", data);
                          },
                          child: Container(
                            child: Card(
                            elevation: 10,
                            color: const Color(0xFFFFC804),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            child: Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[const FaIcon(FontAwesomeIcons.moneyBill,size: 80), Text('Finance Service',style: Theme.of(context).textTheme.headline4)],
                              ),
                            ),
                          )),
                        ),
                       GestureDetector(
                          onTap: () {
                            list_shop("Fish Market", data);
                          },
                          child: Container(
                            child: Card(
                            elevation: 10,
                            color: const Color(0xFFFFC804),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            child: Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[const FaIcon(FontAwesomeIcons.fish,size: 80), Text('Fish Market',style: Theme.of(context).textTheme.headline4)],
                              ),
                            ),
                          )),
                        ),
                       GestureDetector(
                          onTap: () {
                            list_shop("Flower Shop", data);
                          },
                          child: Container(
                            child: Card(
                            elevation: 10,
                            color: const Color(0xFFFFC804),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            child: Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[const FaIcon(FontAwesomeIcons.sun,size: 80), Text('Flower Shop',style: Theme.of(context).textTheme.headline4)],
                              ),
                            ),
                          )),
                        ),
                       GestureDetector(
                          onTap: () {
                            list_service("Fuel Station", data);
                          },
                          child: Container(
                            child: Card(
                            elevation: 10,
                            color: const Color(0xFFFFC804),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            child: Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[const FaIcon(FontAwesomeIcons.gasPump,size: 80), Text('Fuel Station',style: Theme.of(context).textTheme.headline4)],
                              ),
                            ),
                          )),
                        ),
                       GestureDetector(
                          onTap: () {
                            list_shop("Groceries Shop", data);
                          },
                          child: Container(
                            child: Card(
                            elevation: 10,
                            color: const Color(0xFFFFC804),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            child: Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[const FaIcon(FontAwesomeIcons.carrot,size: 80), Text('Groceries Shop',style: Theme.of(context).textTheme.headline4)],
                              ),
                            ),
                          )),
                        ),
                       GestureDetector(
                          onTap: () {
                            list_shop("Hardware Shop", data);
                          },
                          child: Container(
                            child: Card(
                            elevation: 10,
                            color: const Color(0xFFFFC804),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            child: Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[const FaIcon(FontAwesomeIcons.chair,size: 80), Text('Hardware Shop',style: Theme.of(context).textTheme.headline4)],
                              ),
                            ),
                          )),
                        ),
                       GestureDetector(
                          onTap: () {
                            list_service("Health Service", data);
                          },
                          child: Container(
                            child: Card(
                            elevation: 10,
                            color: const Color(0xFFFFC804),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            child: Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[const FaIcon(FontAwesomeIcons.heartCircleCheck,size: 80), Text('Health Service',style: Theme.of(context).textTheme.headline4)],
                              ),
                            ),
                          )),
                        ),
                       GestureDetector(
                          onTap: () {
                            list_shop("Jewellery Shop", data);
                          },
                          child: Container(
                            child: Card(
                            elevation: 10,
                            color: const Color(0xFFFFC804),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            child: Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[const FaIcon(FontAwesomeIcons.gem,size: 80), Text('Jewellery Shop',style: Theme.of(context).textTheme.headline4)],
                              ),
                            ),
                          )),
                        ),
                       GestureDetector(
                          onTap: () {
                            list_shop("Music Shop", data);
                          },
                          child: Container(
                            child: Card(
                            elevation: 10,
                            color: const Color(0xFFFFC804),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            child: Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[const FaIcon(FontAwesomeIcons.music,size: 80), Text('Music Shop',style: Theme.of(context).textTheme.headline4)],
                              ),
                            ),
                          )),
                        ),
                       GestureDetector(
                          onTap: () {
                            list_shop("Pet Shop", data);
                          },
                          child: Container(
                            child: Card(
                            elevation: 10,
                            color: const Color(0xFFFFC804),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            child: Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[const FaIcon(FontAwesomeIcons.dog,size: 80), Text('Pet Shop',style: Theme.of(context).textTheme.headline4)],
                              ),
                            ),
                          )),
                        ),
                       GestureDetector(
                          onTap: () {
                            list_shop("Pharmacy", data);
                          },
                          child: Container(
                            child: Card(
                            elevation: 10,
                            color: const Color(0xFFFFC804),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            child: Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[const FaIcon(FontAwesomeIcons.capsules,size: 80), Text('Pharmacy',style: Theme.of(context).textTheme.headline4)],
                              ),
                            ),
                          )),
                        ),
                       GestureDetector(
                          onTap: () {
                            list_service("Recreation Service", data);
                          },
                          child: Container(
                            child: Card(
                            elevation: 10,
                            color: const Color(0xFFFFC804),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            child: Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[const FaIcon(FontAwesomeIcons.umbrellaBeach,size: 80), Text('Recreation Service',style: Theme.of(context).textTheme.headline4)],
                              ),
                            ),
                          )),
                        ),
                       GestureDetector(
                          onTap: () {
                            list_shop("Shoe Shop", data);
                          },
                          child: Container(
                            child: Card(
                            elevation: 10,
                            color: const Color(0xFFFFC804),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            child: Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[const FaIcon(FontAwesomeIcons.shoePrints,size: 80), Text('Shoe Shop',style: Theme.of(context).textTheme.headline4)],
                              ),
                            ),
                          )),
                        ),
                       GestureDetector(
                          onTap: () {
                            list_shop("Shopping Center", data);
                          },
                          child: Container(
                            child: Card(
                            elevation: 10,
                            color: const Color(0xFFFFC804),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            child: Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[const FaIcon(FontAwesomeIcons.shoppingCart,size: 80), Text('Shopping Center',style: Theme.of(context).textTheme.headline4)],
                              ),
                            ),
                          )),
                        ),
                       GestureDetector(
                          onTap: () {
                            list_shop("Stationary Shop", data);
                          },
                          child: Container(
                            child: Card(
                            elevation: 10,
                            color: const Color(0xFFFFC804),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            child: Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[const FaIcon(FontAwesomeIcons.filePen,size: 80), Text('Stationary Shop',style: Theme.of(context).textTheme.headline4)],
                              ),
                            ),
                          )),
                        ),
                       GestureDetector(
                          onTap: () {
                            list_shop("Tea Shop", data);
                          },
                          child: Container(
                            child: Card(
                            elevation: 10,
                            color: const Color(0xFFFFC804),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            child: Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[const FaIcon(FontAwesomeIcons.mugHot,size: 80), Text('Tea Shop',style: Theme.of(context).textTheme.headline4)],
                              ),
                            ),
                          )),
                        ),
                       GestureDetector(
                          onTap: () {
                            list_service("Tourism Service", data);
                          },
                          child: Container(
                            child: Card(
                            elevation: 10,
                            color: const Color(0xFFFFC804),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            child: Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[const FaIcon(FontAwesomeIcons.toriiGate,size: 80), Text('Tourism Services',style: Theme.of(context).textTheme.headline4)],
                              ),
                            ),
                          )),
                        ),
                       GestureDetector(
                          onTap: () {
                            list_shop("Toy Shop", data);
                          },
                          child: Container(
                            child: Card(
                            elevation: 10,
                            color: const Color(0xFFFFC804),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            child: Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[const FaIcon(FontAwesomeIcons.carSide,size: 80), Text('Toy Shop',style: Theme.of(context).textTheme.headline4)],
                              ),
                            ),
                          )),
                        ),
                       GestureDetector(
                          onTap: () {
                            list_service("Transportation Service", data);
                          },
                          child: Container(
                            child: Card(
                            elevation: 10,
                            color: const Color(0xFFFFC804),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            child: Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[const FaIcon(FontAwesomeIcons.bus,size: 80), Text('Transportation Service',style: Theme.of(context).textTheme.headline4)],
                              ),
                            ),
                          )),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            if(widget.isLeftFloattingButton)
              FloatingActionButton(
                heroTag: widget.heroLeft,
                mini: true,
                onPressed: () => {
                  Navigator.pop(context)
                },
                child: widget.leftIcon,
              ),
          ]
        ),
      )
    );
    
  }
}