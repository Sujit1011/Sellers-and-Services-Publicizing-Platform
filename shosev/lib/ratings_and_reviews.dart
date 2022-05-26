import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart' show BorderRadius,BoxDecoration,BuildContext,Center,CircleAvatar,Color,Colors,Column,Container,CrossAxisAlignment,EdgeInsets,Expanded,FloatingActionButton,FloatingActionButtonLocation,FontWeight,Form,FormState,GlobalKey,Icon,Icons,InkWell,InputDecoration,Key,MainAxisAlignment,Navigator,OutlineInputBorder,Padding,Row,Scaffold,SingleChildScrollView,SizedBox,Spacer,Stack,State,StatefulWidget,Text,TextEditingController,TextFormField,TextInputAction,TextInputType,TextStyle,Theme,Widget;
import 'package:provider/provider.dart' show Provider;
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shosev/models/SS_User.dart' show SS_User;
import 'package:shosev/services/data_repository.dart' show DataRepository;

class RatingandReview extends StatefulWidget {
  // final String Id;
  final String username;
  final String phoneNo;
  final String type;
  final bool isLeftFloattingButton;
  final bool isRightFloattingButton;
  final Icon leftIcon;
  final Icon rightIcon;
  final dynamic data1;

  const RatingandReview({
    Key? key,
    // required this.Id,
    required this.username,
    required this.phoneNo,
    required this.type,
    required this.isLeftFloattingButton,
    required this.isRightFloattingButton,
    required this.leftIcon,
    required this.rightIcon,
    required this.data1,
  }) : super(key: key);

  @override
  State<RatingandReview> createState() => _RatingandReviewState();
}

class _RatingandReviewState extends State<RatingandReview> {
  late double _rating = 0.0;
  final TextEditingController _review = TextEditingController();

  void _left() {
    // () => {
    //   Navigator.pop(context)};
    setState(() {
      Navigator.pop(context);
    });
  }

  void _right() {
    () => {};
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final _myUser = Provider.of<SS_User?>(context);
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
                              Text(widget.username,
                                  style: Theme.of(context).textTheme.headline2),
                              Text(widget.phoneNo,
                                  style: Theme.of(context).textTheme.headline5)
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
              padding: const EdgeInsets.fromLTRB(35, 120, 35, 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12, top: 38),
                    child: Center(
                      child: Text(
                        "Rating and Reviewing",
                        style: Theme.of(context).textTheme.headline2,
                      ),
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.only(bottom: 47, right: 0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Rating",
                                style: Theme.of(context).textTheme.headline4),
                            Padding(
                                padding:
                                    const EdgeInsets.only(top: 8.0, bottom: 16),
                                child: RatingBar.builder(
                                    itemSize: 30,
                                    itemBuilder: (context, index) => const Icon(
                                          Icons.star,
                                          color: Color(0xFFFFC804),
                                        ),
                                    onRatingUpdate: (rating) {
                                      _rating = rating;
                                    })),
                            Text("Review",
                                style: Theme.of(context).textTheme.headline4),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 8.0, bottom: 16),
                              child: TextFormField(
                                controller: _review,
                                style: const TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.normal,
                                    color: Color(0xFF333333),
                                    letterSpacing: -0.5),
                                cursorColor: const Color(0xFF333333),
                                keyboardType: TextInputType.multiline,
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(10.0)),
                                  contentPadding:
                                      const EdgeInsets.fromLTRB(20, 0, 5, 5),
                                  hintText: "Yours Review",
                                  hintStyle: const TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.normal,
                                      color: Color(0xFFD1D1D1),
                                      letterSpacing: -0.5),
                                ),
                              ),
                            ),
                            Padding(
                                padding: const EdgeInsets.only(
                                    top: 28.0, bottom: 15.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      child: Container(
                                        width: 250,
                                        height: 40.0,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: const Color(0xFF333333)),
                                        child: const Center(
                                          child: Text(
                                            "ADD RATING REVIEW",
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Color(0xFFFFFFFF),
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                      onTap: () async {
                                        DataRepository repository = DataRepository();
                                        List list = widget.data1['rating'];
                                        // print(list);
                                        list[_rating.toInt()] += 1;
                                        // print(widget.data1.id);
                                        if(widget.type == "shop"){
                                          repository.ss_shops_collection.doc(widget.data1.id).update(
                                          {
                                            "rating":list,
                                            "reviews": FieldValue.arrayUnion([{
                                                "review": _review.text,
                                                "UserId": _myUser?.uid
                                            }]),
                                          }
                                          ).then((value){
                                            repository.ss_users_collection.doc(_myUser?.uid).update({
                                              "shopReviews" : FieldValue.arrayUnion([{
                                                "shopId": widget.data1.id,
                                                "review": _review.text
                                              }])
                                            });
                                            Navigator.of(context).pop();                                          
                                          });
                                        }
                                        if(widget.type == "service"){
                                          repository.ss_services_collection.doc(widget.data1.id).update(
                                          {
                                            "rating":list,
                                            "reviews": FieldValue.arrayUnion([{
                                                "review": _review.text,
                                                "UserId": _myUser?.uid
                                            }]),
                                          }
                                          ).then((value){
                                            repository.ss_users_collection.doc(_myUser?.uid).update({
                                              "serviceReviews" : FieldValue.arrayUnion([{
                                                "serviceId": widget.data1.id,
                                                "review": _review.text
                                              }])
                                            });
                                            Navigator.of(context).pop();                                          
                                          });
                                        }
                                      },
                                    )
                                  ],
                                )),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 47,
                  )
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
                if (widget.isLeftFloattingButton)
                  FloatingActionButton(
                    heroTag: "add review left",
                    mini: true,
                    onPressed: _left,
                    child: widget.leftIcon,
                  ),
                if (widget.isRightFloattingButton)
                  FloatingActionButton(
                    heroTag: "add review right",
                    mini: true,
                    onPressed: _right,
                    child: widget.rightIcon,
                  ),
              ]),
        ));
  }
}
