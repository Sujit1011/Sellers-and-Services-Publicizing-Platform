import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shosev/assets/design.dart';
import 'package:shosev/services/data_repository.dart';

class ReviewListPage extends StatefulWidget {
  final String title;
  final String username;
  final String phoneNo;
  final String userId;


  const ReviewListPage({Key? key,
  required this.title,
  required this.userId, 
  required this.username, 
  required this.phoneNo,
  }) : super(key: key);

  @override
  State<ReviewListPage> createState() => _ReviewListPageState();
}

class _ReviewListPageState extends State<ReviewListPage> {

  final DataRepository repository = DataRepository();

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
                  height: 40,
                  width: 40,
                  fit: BoxFit.fitWidth,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: Text(
                  review,
                  style: const TextStyle(
                    fontSize: 14,
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
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          systemNavigationBarColor: textColor, // navigation bar color
          statusBarColor: secondaryColor, // status bar color
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.dark // status bar color
        ),
        child: Stack(
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
                          backgroundColor: textColor,
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
                                style: Theme.of(context).textTheme.headlineMedium,
                                textScaleFactor: 1.0,
                              ),
                              Text(
                                widget.phoneNo,
                                style: Theme.of(context).textTheme.titleMedium,
                                textScaleFactor: 1.0,
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
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("My Shop Reviews", style: Theme.of(context).textTheme.titleMedium),
                  ),
                  Flexible(
                    child: FutureBuilder<DocumentSnapshot<Object?>>(
                      future: repository.ss_users_collection.doc(widget.userId).get(),
                      builder: (context, document) {
                                             
                        if (!document.hasData) {
                          return const Center(child: CircularProgressIndicator());
                        }
        
                        if(document.data!['shopReviews'].length > 0) {
                          return ListView.builder(
                            itemCount: document.data!['shopReviews'].length,
                            itemBuilder: (context, index) {
                              if(document.data!["shopReviews"] != null && document.data!['shopReviews'][index]['shopId'] != null) {
                                return getReviewDesign(document.data!['shopReviews'][index]['review'].toString());
                              } else {
                                return const SizedBox();
                              }
                            }
                          );
                        }
                        return const Expanded(child: Center(child: Text("No Shop Reviews yet")));
                      }
                    )
                  ),
                  const Divider(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("My Service Reviews", style: Theme.of(context).textTheme.titleMedium),
                  ),
                  Flexible(
                    child: FutureBuilder<DocumentSnapshot<Object?>>(
                      future: repository.ss_users_collection.doc(widget.userId).get(),
                      builder: (context, document) {
                                             
                        if (!document.hasData) {
                          return const Center(child: CircularProgressIndicator());
                        }
                        
                        if(document.data!['serviceReviews'].length > 0) {
                          return ListView.builder(
                            itemCount: document.data!['serviceReviews'].length,
                            itemBuilder: (context, index) {
                              if(document.data!["serviceReviews"] != null && document.data!['serviceReviews'][index]['serviceId'] != null) {
                                return getReviewDesign(document.data!['serviceReviews'][index]['review'].toString());
                              } else {
                                return const SizedBox();
                              }
                              // print(document.data!['serviceReviews'][index]);
                              // return const Expanded(child: Center(child: Text("No Service Reviews yet")));
                            }
                          );
                        }
                        return const Expanded(child: Center(child: Text("No Service Reviews yet")));
                      }
                    )
                  ),
                ],
              ),
            )
          ],
        ),
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