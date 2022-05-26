import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shosev/list_page.dart';
import 'package:shosev/services/data_repository.dart';
import 'package:shosev/assets/design.dart' as design;
import 'package:shosev/shop_profile.dart';

class FavouriteListPage extends StatefulWidget {
  final String title;
  final String username;
  final String phoneNo;
  final String userId;


  const FavouriteListPage({Key? key,
  required this.title,
  required this.userId, 
  required this.username, 
  required this.phoneNo,
  }) : super(key: key);

  @override
  State<FavouriteListPage> createState() => _FavouriteListPageState();
}

class _FavouriteListPageState extends State<FavouriteListPage> {

  final DataRepository repository = DataRepository();
  List _favouriteShops = [];
  List _favouriteServices = [];

  Widget getReviewDesign(String review) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(2),
          child: Row(
            children: [
              ClipOval(
                child: Image.asset(
                  'lib/assets/img/user.png',
                  height: 35,
                  width: 35,
                  fit: BoxFit.fitWidth,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: Text(
                  review,
                  style: const TextStyle(
                    fontSize: 12,
                    fontStyle: FontStyle.italic,
                  ),
                )
              )
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if(widget.userId != "") {
      repository.ss_users_collection.doc(widget.userId).get().then((data) {
        if(data.exists) {

          _favouriteShops = data["favouriteShops"];
          _favouriteServices = data["favouriteServices"];
        }
      });
    }
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
                if(_favouriteShops.isNotEmpty )
                Flexible(
                  child: StreamBuilder(
                    stream: repository.ss_shops_collection.where("id", whereIn: _favouriteShops).get().asStream(),
                    builder: (context, snapshot) {
                      print(snapshot.hasData);
                      if(snapshot.hasData)
                      print(snapshot.data);
                      // return design.CardDesign1(
                      //   isHeading: true,
                      //   isPhoto: true,
                      //   isText1: true,
                      //   isText2: true,
                      //   img: Image.asset(
                      //       'lib/assets/img/shop.png',
                      //       width: 60,
                      //       height: 60,
                      //       fit: BoxFit.fitWidth,
                      //     ),
                      //   deleteShow: false,
                      //   updateShow: false,
                      //   heading: shopDocument["name"],
                      //   text1: shopDocument["phoneNo"],
                      //   text2: shopDocument["address"],
                      //   onClick: () => {
                      //     Navigator.push(context,
                      //     MaterialPageRoute(builder: (context) => ShopProfilePage(
                      //       username: widget.username,
                      //       phoneno: widget.phoneNo,
                      //       shopName: shopDocument["name"], 
                      //       rating: shopDocument["rating"], 
                      //       joined: monthsToString[shopDocument["joined"].toDate().month]! + " " + shopDocument["joined"].toDate().year.toString().substring(2,4), 
                      //       reviews: shopDocument["reviews"], 
                      //       contacted: shopDocument["contacted"], 
                      //       aboutUs: shopDocument["description"],
                      //       products: shopDocument["products"],
                      //       reviewsCount: shopDocument["reviewsCount"],
                      //       data: shopDocument,)
                      //       )
                      //     ) 
                      //   },
                      //   deleteOnClick: (){},
                      //   updateOnClick: (){},
                      // );
                      return const SizedBox();
                    },
                  ),
                  // child: FutureBuilder<DocumentSnapshot<Object?>>(
                  //   future: repository.ss_users_collection.doc(widget.userId).get(),
                  //   builder: (context, document) {
                                           
                  //     if (!document.hasData) {
                  //       return const Center(child: CircularProgressIndicator());
                  //     }
                  //     print(document.data!['favouriteShops']);
                  //     if(document.data!['favouriteShops'].length > 0) {
                  //       return ListView.builder(
                  //         itemCount: document.data!['favouriteShops'].length,
                  //         itemBuilder: (context, index) {
                  //           if(document.hasData) {
                  //             String shopId = document.data!['favouriteShops'][index].toString();
                  //             Widget shop = const SizedBox();
                  //             dynamic shopDocument = [];
                  //             print(shopId);
                  //             repository.ss_shops_collection.doc(shopId).get().then((value) {
                  //               shopDocument = value.data();
                  //               print(shopDocument);
                  //             });
                  //             // return design.CardDesign1(
                  //             //   isHeading: true,
                  //             //   isPhoto: true,
                  //             //   isText1: true,
                  //             //   isText2: true,
                  //             //   img: Image.asset(
                  //             //       'lib/assets/img/shop.png',
                  //             //       width: 60,
                  //             //       height: 60,
                  //             //       fit: BoxFit.fitWidth,
                  //             //     ),
                  //             //   deleteShow: false,
                  //             //   updateShow: false,
                  //             //   heading: shopDocument["name"],
                  //             //   text1: shopDocument["phoneNo"],
                  //             //   text2: shopDocument["address"],
                  //             //   onClick: () => {
                  //             //     Navigator.push(context,
                  //             //     MaterialPageRoute(builder: (context) => ShopProfilePage(
                  //             //       username: widget.username,
                  //             //       phoneno: widget.phoneNo,
                  //             //       shopName: shopDocument["name"], 
                  //             //       rating: shopDocument["rating"], 
                  //             //       joined: monthsToString[shopDocument["joined"].toDate().month]! + " " + shopDocument["joined"].toDate().year.toString().substring(2,4), 
                  //             //       reviews: shopDocument["reviews"], 
                  //             //       contacted: shopDocument["contacted"], 
                  //             //       aboutUs: shopDocument["description"],
                  //             //       products: shopDocument["products"],
                  //             //       reviewsCount: shopDocument["reviewsCount"],
                  //             //       data: shopDocument,)
                  //             //       )
                  //             //     ) 
                  //             //   },
                  //             //   deleteOnClick: (){},
                  //             //   updateOnClick: (){},
                  //             // );
                  //             return const SizedBox();
                  //           } else {
                  //             return const SizedBox();
                  //           }
                  //         }
                  //       );
                  //     }
                  //     return const Expanded(child: Center(child: Text("No Shop Reviews yet")));
                  //   }
                  // )
                ),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("My Favourites Services", style: Theme.of(context).textTheme.headline4),
                ),
                if(_favouriteServices.isNotEmpty )
                Flexible(
                  child: StreamBuilder(
                    stream: repository.ss_services_collection.where("id", whereIn: _favouriteServices).get().asStream(),
                    builder: (context, snapshot) {
                      print(snapshot.hasData);
                      if(snapshot.hasData)
                      print(snapshot.data);
                      // return design.CardDesign1(
                      //   isHeading: true,
                      //   isPhoto: true,
                      //   isText1: true,
                      //   isText2: true,
                      //   img: Image.asset(
                      //       'lib/assets/img/shop.png',
                      //       width: 60,
                      //       height: 60,
                      //       fit: BoxFit.fitWidth,
                      //     ),
                      //   deleteShow: false,
                      //   updateShow: false,
                      //   heading: shopDocument["name"],
                      //   text1: shopDocument["phoneNo"],
                      //   text2: shopDocument["address"],
                      //   onClick: () => {
                      //     Navigator.push(context,
                      //     MaterialPageRoute(builder: (context) => ShopProfilePage(
                      //       username: widget.username,
                      //       phoneno: widget.phoneNo,
                      //       shopName: shopDocument["name"], 
                      //       rating: shopDocument["rating"], 
                      //       joined: monthsToString[shopDocument["joined"].toDate().month]! + " " + shopDocument["joined"].toDate().year.toString().substring(2,4), 
                      //       reviews: shopDocument["reviews"], 
                      //       contacted: shopDocument["contacted"], 
                      //       aboutUs: shopDocument["description"],
                      //       products: shopDocument["products"],
                      //       reviewsCount: shopDocument["reviewsCount"],
                      //       data: shopDocument,)
                      //       )
                      //     ) 
                      //   },
                      //   deleteOnClick: (){},
                      //   updateOnClick: (){},
                      // );
                      return const SizedBox();
                    },
                  ),
                  // child: FutureBuilder<DocumentSnapshot<Object?>>(
                  //   future: repository.ss_users_collection.doc(widget.userId).get(),
                  //   builder: (context, document) {
                                           
                  //     if (!document.hasData) {
                  //       return const Center(child: CircularProgressIndicator());
                  //     }
                  //     print(document.data!['favouriteShops']);
                  //     if(document.data!['favouriteShops'].length > 0) {
                  //       return ListView.builder(
                  //         itemCount: document.data!['favouriteShops'].length,
                  //         itemBuilder: (context, index) {
                  //           if(document.hasData) {
                  //             String shopId = document.data!['favouriteShops'][index].toString();
                  //             Widget shop = const SizedBox();
                  //             dynamic shopDocument = [];
                  //             print(shopId);
                  //             repository.ss_shops_collection.doc(shopId).get().then((value) {
                  //               shopDocument = value.data();
                  //               print(shopDocument);
                  //             });
                  //             // return design.CardDesign1(
                  //             //   isHeading: true,
                  //             //   isPhoto: true,
                  //             //   isText1: true,
                  //             //   isText2: true,
                  //             //   img: Image.asset(
                  //             //       'lib/assets/img/shop.png',
                  //             //       width: 60,
                  //             //       height: 60,
                  //             //       fit: BoxFit.fitWidth,
                  //             //     ),
                  //             //   deleteShow: false,
                  //             //   updateShow: false,
                  //             //   heading: shopDocument["name"],
                  //             //   text1: shopDocument["phoneNo"],
                  //             //   text2: shopDocument["address"],
                  //             //   onClick: () => {
                  //             //     Navigator.push(context,
                  //             //     MaterialPageRoute(builder: (context) => ShopProfilePage(
                  //             //       username: widget.username,
                  //             //       phoneno: widget.phoneNo,
                  //             //       shopName: shopDocument["name"], 
                  //             //       rating: shopDocument["rating"], 
                  //             //       joined: monthsToString[shopDocument["joined"].toDate().month]! + " " + shopDocument["joined"].toDate().year.toString().substring(2,4), 
                  //             //       reviews: shopDocument["reviews"], 
                  //             //       contacted: shopDocument["contacted"], 
                  //             //       aboutUs: shopDocument["description"],
                  //             //       products: shopDocument["products"],
                  //             //       reviewsCount: shopDocument["reviewsCount"],
                  //             //       data: shopDocument,)
                  //             //       )
                  //             //     ) 
                  //             //   },
                  //             //   deleteOnClick: (){},
                  //             //   updateOnClick: (){},
                  //             // );
                  //             return const SizedBox();
                  //           } else {
                  //             return const SizedBox();
                  //           }
                  //         }
                  //       );
                  //     }
                  //     return const Expanded(child: Center(child: Text("No Shop Reviews yet")));
                  //   }
                  // )
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