import 'package:cloud_firestore/cloud_firestore.dart' show FieldPath, QuerySnapshot;
import 'package:flutter/material.dart' show AsyncSnapshot, BoxFit, BuildContext, Center, CircleAvatar, CircularProgressIndicator, Color, Colors, Column, Container, CrossAxisAlignment, Divider, EdgeInsets, Expanded, Flexible, FloatingActionButton, FloatingActionButtonLocation, Icon, Icons, Image, Key, ListView, MainAxisAlignment, MaterialPageRoute, Navigator, Padding, Row, Scaffold, Spacer, Stack, State, StatefulWidget, StreamBuilder, Text, Theme, Widget;
import 'package:shosev/assets/design.dart' show CardDesign1;
import 'package:shosev/list_page.dart' show monthsToString;
import 'package:shosev/services/data_repository.dart' show DataRepository;
import 'package:shosev/shop_profile.dart' show ShopProfilePage;

class FavouriteListPage extends StatefulWidget {
  final String title;
  final String username;
  final String phoneNo;
  final String userId;
  final List<dynamic> favouriteShops;
  final List<dynamic> favouriteServices;


  const FavouriteListPage({Key? key,
  required this.title,
  required this.userId, 
  required this.username, 
  required this.phoneNo, 
  required this.favouriteShops, 
  required this.favouriteServices,
  }) : super(key: key);

  @override
  State<FavouriteListPage> createState() => _FavouriteListPageState();
}

class _FavouriteListPageState extends State<FavouriteListPage> {

  final DataRepository repository = DataRepository();

  @override
  Widget build(BuildContext context) {
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
                              widget.username,
                              style: Theme.of(context).textTheme.headline2
                            ),
                            Text(
                              widget.phoneNo,
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("My Favourite Shops", style: Theme.of(context).textTheme.headline4),
                ),
                (widget.favouriteShops.isNotEmpty )?
                Flexible(
                  child: 
                  StreamBuilder(
                    stream: repository.ss_shops_collection.where(FieldPath.documentId, whereIn: widget.favouriteShops).snapshots(),
                    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if(snapshot.data!.size < 1) {
                        return const Center(child: Text("No Shop Reviews yet"),);
                      }
                      return ListView(
                        children: snapshot.data!.docs.map((shopDocument) {
                          return CardDesign1(
                            isHeading: true,
                            isPhoto: true,
                            isText1: true,
                            isText2: true,
                            img: Image.asset(
                                'lib/assets/img/shop.png',
                                width: 60,
                                height: 60,
                                fit: BoxFit.fitWidth,
                              ),
                            deleteShow: false,
                            updateShow: false,
                            heading: shopDocument["name"],
                            text1: shopDocument["phoneNo"],
                            text2: shopDocument["address"],
                            onClick: () => {
                              Navigator.push(context,
                              MaterialPageRoute(builder: (context) => ShopProfilePage(
                                username: widget.username,
                                phoneno: widget.phoneNo,
                                shopName: shopDocument["name"], 
                                rating: shopDocument["rating"], 
                                joined: monthsToString[shopDocument["joined"].toDate().month]! + " " + shopDocument["joined"].toDate().year.toString().substring(2,4), 
                                reviews: shopDocument["reviews"], 
                                contacted: shopDocument["contacted"], 
                                aboutUs: shopDocument["description"],
                                products: shopDocument["products"],
                                reviewsCount: shopDocument["reviewsCount"],
                                data: shopDocument,)
                                )
                              ) 
                            },
                            deleteOnClick: (){},
                            updateOnClick: (){},
                          );
                        }).toList(),
                      );
                    },
                  ),
                ):const Expanded(child: Center(child: Text("No Shop Reviews yet"))),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("My Favourites Services", style: Theme.of(context).textTheme.headline4),
                ),
                (widget.favouriteServices.isNotEmpty )?
                Flexible(
                  child: 
                  StreamBuilder(
                    stream: repository.ss_services_collection.where(FieldPath.documentId, whereIn: widget.favouriteServices).snapshots(),
                    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if(snapshot.data!.size < 1) {
                        return const Center(child: Text("No Service Reviews yet"),);
                      }
                      return ListView(
                        children: snapshot.data!.docs.map((shopDocument) {
                          return CardDesign1(
                            isHeading: true,
                            isPhoto: true,
                            isText1: true,
                            isText2: true,
                            img: Image.asset(
                                'lib/assets/img/service.jpg',
                                width: 60,
                                height: 60,
                                fit: BoxFit.fitWidth,
                              ),
                            deleteShow: false,
                            updateShow: false,
                            heading: shopDocument["name"],
                            text1: shopDocument["phoneNo"],
                            text2: shopDocument["address"],
                            onClick: () => {
                              Navigator.push(context,
                              MaterialPageRoute(builder: (context) => ShopProfilePage(
                                username: widget.username,
                                phoneno: widget.phoneNo,
                                shopName: shopDocument["name"], 
                                rating: shopDocument["rating"], 
                                joined: monthsToString[shopDocument["joined"].toDate().month]! + " " + shopDocument["joined"].toDate().year.toString().substring(2,4), 
                                reviews: shopDocument["reviews"], 
                                contacted: shopDocument["contacted"], 
                                aboutUs: shopDocument["description"],
                                products: shopDocument["services"],
                                reviewsCount: shopDocument["reviewsCount"],
                                data: shopDocument,)
                                )
                              ) 
                            },
                            deleteOnClick: (){},
                            updateOnClick: (){},
                          );
                        }).toList(),
                      );
                    },
                  ),
                ):const Expanded(child: Center(child: Text("No Shop Reviews yet"))),
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
            FloatingActionButton(
              heroTag: "my review left",
              mini: true,
              onPressed: () => {
                Navigator.pop(context)
              },
              child: const Icon(Icons.chevron_left_rounded, size: 35),
            ),
          ]
        ),
      )
    );
    
  }
}