import 'package:flutter/material.dart' show AlertDialog, AsyncSnapshot, Axis, BorderRadius, BuildContext, Card, Center, CircleAvatar, CircularProgressIndicator, Color, Colors, Column, Container, CrossAxisAlignment, EdgeInsets, Expanded, FittedBox, FloatingActionButton, FloatingActionButtonLocation, FlutterLogo, GestureDetector, GridView, Icon, Icons, InkWell, Key, ListView, MainAxisAlignment, MainAxisSize, MaterialPageRoute, Navigator, Padding, RoundedRectangleBorder, Row, Scaffold, SizedBox, Spacer, Stack, State, StatefulWidget, StreamBuilder, Text, TextAlign, TextButton, Theme, Widget, Wrap, showDialog;
import 'package:font_awesome_flutter/font_awesome_flutter.dart' show FaIcon, FontAwesomeIcons;
import 'package:provider/provider.dart' show Provider;

import 'package:shosev/add_service.dart' show serviceCategories;
import 'package:shosev/add_shop.dart' show shopCategories;
import 'package:shosev/list_page.dart' show ListPage, listPageType;
import 'package:shosev/models/SS_User.dart' show SS_User;
import 'package:shosev/services/data_repository.dart' show DataRepository;


List shopCategoriesWithIcons = [
  ["Jewellery Shop", FontAwesomeIcons.gem],
  ["Flower Shop", FontAwesomeIcons.sun],
  ["Shopping Center", FontAwesomeIcons.cartShopping],
  ["Barber Shop", FontAwesomeIcons.scissors],
  ["DIY Store", FontAwesomeIcons.paintbrush],
  ["Eyewear Shop", FontAwesomeIcons.glasses],
  ["Stationary Shop", FontAwesomeIcons.filePen],
  ["Pharmacy", FontAwesomeIcons.capsules],
  ["Fish Market", FontAwesomeIcons.fish],
  ["Green Grocery", FontAwesomeIcons.leaf],
  ["Bakery Shop", 	FontAwesomeIcons.cakeCandles],
  ["Toy Shop", FontAwesomeIcons.carSide],
  ["Music Shop", FontAwesomeIcons.music],
  ["Shoe Shop", FontAwesomeIcons.shoePrints],
  ["Book Shop", FontAwesomeIcons.book],
  ["Pet Shop", FontAwesomeIcons.dog],
  ["Tea Shop", FontAwesomeIcons.mugHot],
  ["Fuel Station", FontAwesomeIcons.gasPump],
  ["Grocery Shop", FontAwesomeIcons.carrot],
  ["Cloth Shop", FontAwesomeIcons.shirt],
  ["Hardware Shop", FontAwesomeIcons.toolbox],
];

List serviceCategoriesWithIcons = [
  ["Business Services", FontAwesomeIcons.businessTime],
  ["Communication Services", FontAwesomeIcons.comment],
  ["Construction & Engineering", FontAwesomeIcons.personDigging],
  ["Distribution Services", FontAwesomeIcons.truck],
  ["Education", FontAwesomeIcons.bookOpen],
  ["Environment Services", FontAwesomeIcons.treeCity],
  ["Finance service", FontAwesomeIcons.moneyBill],
  ["Tourism Services", FontAwesomeIcons.toriiGate],
  ["Health Services", FontAwesomeIcons.heartCircleCheck],
  ["Recreation Services", FontAwesomeIcons.umbrellaBeach],
  ["Transportation Services", FontAwesomeIcons.bus]
];
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



  void list_shop(String str, data){
    setState(() {
      {
        Navigator.push(context, MaterialPageRoute(builder: (context) =>
          ListPage(
            title: str,
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
            documentFieldStream: repository.ss_shops_collection.where("category", isEqualTo: str).snapshots(),
            onClickWidget: true,
            type: listPageType.shop,
            deleteItemFn: (id) {},
            updateItemFn: (id, document) {},
          )
        
        ));
      }
    });
  }

  void list_service(String str, data){
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
            documentFieldStream: repository.ss_services_collection.where("category", isEqualTo: str).snapshots(),
            onClickWidget: true,
            type: listPageType.service,
            deleteItemFn: (id) {},
            updateItemFn: (id, document){},
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
            padding: const EdgeInsets.fromLTRB(5, 120, 5, 10),
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Shop Categories", style: Theme.of(context).textTheme.headline4),
                ),
                Expanded(
                  child: GridView.count(
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 12,
                    crossAxisCount: 2,
                    childAspectRatio: .90,
                    scrollDirection: Axis.horizontal,
                    children: shopCategoriesWithIcons.map((list) {
                      return GestureDetector(
                        onTap: () {
                          list_shop(list[0], data);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Card(
                              elevation: 7,
                              color: const Color(0xFFFFC804),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    FittedBox(child: FaIcon(list[1],size: 40)),
                                    FittedBox(
                                      child: Text(
                                        list[0], 
                                        style: Theme.of(context).textTheme.headline4,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Service Categories", style: Theme.of(context).textTheme.headline4),
                ),
                Expanded(
                  child: GridView.count(
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 12,
                    crossAxisCount: 2,
                    childAspectRatio: .90,
                    scrollDirection: Axis.horizontal,
                    children: serviceCategoriesWithIcons.map((list) {
                      return GestureDetector(
                        onTap: () {
                          list_service(list[0], data);
                        },
                        child: Card(
                            elevation: 7,
                            color: const Color(0xFFFFC804),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  FaIcon(list[1],size: 40),
                                  Text(
                                    list[0], 
                                    style: Theme.of(context).textTheme.headline4,
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            )
                        ),
                      );
                    }).toList(),
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