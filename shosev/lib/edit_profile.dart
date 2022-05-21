import 'package:flutter/material.dart' show AlertDialog, Border, BorderRadius, BoxDecoration, BuildContext, Center, CircleAvatar, Color, Colors, Column, Container, CrossAxisAlignment, Divider, EdgeInsets, Expanded, Flexible, FloatingActionButton, FloatingActionButtonLocation, FontWeight, Form, FormState, GlobalKey, Icon, InkWell, InputDecoration, Key, MainAxisAlignment, Navigator, OutlineInputBorder, Padding, Row, Scaffold, SingleChildScrollView, SizedBox, Spacer, Stack, State, StatefulWidget, Switch, Text, TextButton, TextEditingController, TextFormField, TextInputAction, TextInputType, TextStyle, Theme, Widget, Wrap, showDialog;
import 'package:provider/provider.dart' show Provider;
import 'package:shosev/models/SS_User.dart' show SS_User;
import 'package:shosev/services/auth.dart' show AuthService;
import 'package:shosev/services/data_repository.dart' show DataRepository;



class EditProfile extends StatefulWidget {
  final String username;
  final String phoneNo;
  final String title;
  final bool isLeftFloattingButton;
  final bool isRightFloattingButton;
  final Icon leftIcon;
  final Icon rightIcon;

  final Function leftClick;
  final Function rightClick;

  final AuthService authService;
  final dynamic data;

  EditProfile(
    {
      Key? key, 
      required this.username, 
      required this.phoneNo, 
      required this.title, 
      required this.isLeftFloattingButton, 
      required this.isRightFloattingButton, 
      required this.leftClick, 
      required this.rightClick, 
      required this.leftIcon, 
      required this.rightIcon, 
      required this.authService, 
      required this.data
    }
  ): super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {

  void _left() {
    // appbar.fadeSystemUI();

    widget.leftClick();
  }

  void _right() {
    // appbar.fadeSystemUI();
    
    widget.rightClick();
  }

  final TextEditingController _username_t = TextEditingController();
  final TextEditingController _busername_t = TextEditingController();
  final TextEditingController _email_t = TextEditingController();
  bool _isSwitched = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.data != null) {
      _username_t.text = widget.data['username'];
      if(widget.data['businessUser']) {
        _isSwitched = true;
      }
      if(widget.data['businessName'] != null) {
        _busername_t.text = widget.data['businessName'];
      }
      if(widget.data['email'] != null) {
        _email_t.text = widget.data['email'];
      }
    }
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
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.only(bottom: 47, right: 15),
                    child: Form(
                      key: _formKey,
                      child: Column(
                      children: [
                        Text("User Name", style: Theme.of(context).textTheme.headline4),
                          Padding(
                            padding: const EdgeInsets.only(top:8.0, bottom: 16),
                            child: TextFormField(
                              controller: _username_t,
                              style: const TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.normal,
                                color: Color(0xFF333333),
                                letterSpacing: -0.5
                              ),
                              cursorColor: const Color(0xFF333333),
                              keyboardType: TextInputType.name,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0)
                                ),
                                contentPadding: const EdgeInsets.fromLTRB(20, 0, 5, 5),
                                hintText: "Someone",
                                hintStyle: const TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.normal,
                                  color: Color(0xFFD1D1D1),
                                  letterSpacing: -0.5
                                ),
                              ),
                              validator: (val){
                                if (val!.isEmpty) {
                                  return "Enter User Name";
                                }
                                if (val.length > 80) {
                                  return "Enter less than 80 characters";
                                }
                                return null;
                              },
                            ),
                          ),
                          Text("Email", style: Theme.of(context).textTheme.headline4),
                          Padding(
                            padding: const EdgeInsets.only(top:8.0, bottom: 16),
                            child: TextFormField(
                              controller: _email_t,
                              style: const TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.normal,
                                color: Color(0xFF333333),
                                letterSpacing: -0.5
                              ),
                              cursorColor: const Color(0xFF333333),
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0)
                                ),
                                contentPadding: const EdgeInsets.fromLTRB(20, 0, 5, 5),
                                hintText: "someone@example.com",
                                hintStyle: const TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.normal,
                                  color: Color(0xFFD1D1D1),
                                  letterSpacing: -0.5
                                ),
                              ),
                              validator: (val){
                                if (val!.isEmpty) {
                                  return "Enter email";
                                }
                                if (val.length > 50) {
                                  return "Enter less than 50 characters";
                                }
                                return null;
                              },
                            ),
                          ),
                          const Divider(),
                          Text("Business User Settings", style: Theme.of(context).textTheme.headline4),
                          Wrap(children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 8, 0, 11),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  border: Border.all(color: const Color(0xFFD1D1D1))
                                ),
                                child: Row(
                                  children: [
                                    Switch(
                                      value: _isSwitched,
                                      onChanged: (value) {
                                        setState(() {
                                          _isSwitched = value;
                                        });
                                        print(_isSwitched);
                                      },
                                      activeTrackColor: const Color(0xFFFCE48F),
                                      activeColor: const Color(0xFFFFC804),
                                    ),
                                    const Flexible(
                                      child: Text(
                                        "Become a Seller or Service provider",
                                      )
                                    ),
                                  ],
                                ),
                              )
                            ),
                          ]),
                          Text("Business User Name", style: Theme.of(context).textTheme.headline4),
                          Padding(
                            padding: const EdgeInsets.only(top:8.0, bottom: 16),
                            child: TextFormField(
                              controller: _busername_t,
                              style: const TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.normal,
                                color: Color(0xFF333333),
                                letterSpacing: -0.5
                              ),
                              cursorColor: const Color(0xFF333333),
                              keyboardType: TextInputType.multiline,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0)
                                ),
                                contentPadding: const EdgeInsets.fromLTRB(20, 0, 5, 5),
                                hintText: "Company Name",
                                hintStyle: const TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.normal,
                                  color: Color(0xFFD1D1D1),
                                  letterSpacing: -0.5
                                ),
                              ),
                              validator: (val){
                                if(_isSwitched == false) {
                                  return null;
                                }
                                if (val!.isEmpty) {
                                  return "Enter Name";
                                }
                                if (val.length > 150) {
                                  return "Enter less than 150 characters";
                                }
                                return null;
                              },
                            ),
                          ),
                          const Divider(),
                          Padding(
                            padding: const EdgeInsets.only(top:28.0, bottom: 15.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  child: Container(
                                    width: 250,
                                    height: 40.0,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: const Color(0xFF333333)
                                    ),
                                    child: const Center(
                                      child: Text(
                                        "UPDATE USER",
                                        style: TextStyle(fontSize: 20, color: Color(0xFFFFFFFF), fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  onTap: () async {
                                    if (_formKey.currentState!.validate() && _myUser != null) {
                                        String userId = _myUser.uid;
                                        DataRepository repository = DataRepository();
                                        // widget.authService.auth.currentUser?.updateDisplayName(_username_t.text);
                                        // widget.authService.auth.currentUser?.updateEmail(_email_t.text);

                                        repository.ss_users_collection.doc(userId).update(
                                          {
                                            "userName": _username_t.text,
                                            "email": _email_t.text,
                                            "businessUser": _isSwitched,
                                            "businessName": (_isSwitched)?_busername_t.text:"",
                                          }
                                        ).then((value){ 
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext builderContext) {
                                              return AlertDialog(
                                                title: Text("Sucessfully updated User : "+_username_t.text),
                                                content: Text(userId),
                                                actions: [
                                                  TextButton(
                                                    child: const Text("Ok"),
                                                    onPressed: () async {
                                                      Navigator.of(builderContext).pop();
                                                      Navigator.of(builderContext).pop();
                                                    },
                                                  )
                                                ],
                                              );
                                            }).then((val) {
                                            Navigator.of(context).pop();
                                          });
                                          
                                          
                                        });

                                      } else {
                                        print(_myUser);
                                      }
                                    }
                                )
                              ],
                            ),
                          ),
                          const Divider(),
                          Padding(
                            padding: const EdgeInsets.only(top:28.0, bottom: 15.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  child: Container(
                                    width: 250,
                                    height: 40.0,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.red.shade800
                                    ),
                                    child: const Center(
                                      child: Text(
                                        "DELETE USER",
                                        style: TextStyle(fontSize: 20, color: Color(0xFFFFFFFF), fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  onTap: () async {
                                    // FirebaseService service = new FirebaseService();
                                    if (_myUser != null) {
                                        String userId = _myUser.uid;
                                        DataRepository repository = DataRepository();
                                        
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext builderContext) {
                                              return AlertDialog(
                                                title: Text("Are ypu sure you want to delete User : "+_username_t.text),
                                                content: Text(userId),
                                                actions: [
                                                  TextButton(
                                                    child: const Text("Yes"),
                                                    onPressed: () async {
                                                      Navigator.of(builderContext).pop();
                                                      widget.authService.auth.currentUser?.delete();
                                                      await widget.authService.auth.signOut();
                                                      repository.ss_users_collection.doc(userId).delete().then((value){ 
                                                        
                                                        showDialog(
                                                          context: context,
                                                          builder: (BuildContext builderContext) {
                                                            return AlertDialog(
                                                              title: Text("Deleted User : "+_username_t.text),
                                                              content: Text(userId),
                                                              actions: [
                                                                TextButton(
                                                                  child: const Text("Ok"),
                                                                  onPressed: () async {
                                                                    Navigator.of(builderContext).pop();
                                                                  },
                                                                )
                                                              ],
                                                            );
                                                          }).then((val) {
                                                          Navigator.of(context).pop();
                                                        });
                                                        
                                                      });
                                                      
                                                    },
                                                  ),
                                                  TextButton(
                                                    child: const Text("No"),
                                                    onPressed: () async {
                                                      Navigator.of(builderContext).pop();
                                                    },
                                                  )
                                                ],
                                              );
                                            }).then((val) {
                                            Navigator.of(context).pop();
                                          });
                                      } else {
                                        print(_myUser);
                                      }
                                    }
                                )
                              ],
                            ),
                          ),
                        ]
                      )
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
      //Floating Buttons
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            if(widget.isLeftFloattingButton)
              FloatingActionButton(
                heroTag: "edit profile left",
                mini: true,
                onPressed: _left,
                child: widget.leftIcon,
              ),
            if(widget.isRightFloattingButton)
              FloatingActionButton(
                heroTag: "edit profile right",
                mini: true,
                onPressed: _right,
                child: widget.rightIcon,
              ),
          ]
        ),
      )
    );
  }
}
// class Edit_Profile extends StatelessWidget {

//   final String username;
//   final String phoneNo;
//   final String title;
//   final bool isLeftFloattingButton;
//   final bool isRightFloattingButton;
//   final Icon leftIcon;
//   final Icon rightIcon;

//   final Function leftClick;
//   final Function rightClick;

//   final AuthService authService;

//   Edit_Profile(
//     {
//       Key? key, 
//       required this.username, 
//       required this.phoneNo, 
//       required this.title, 
//       required this.isLeftFloattingButton, 
//       required this.isRightFloattingButton, 
//       required this.leftClick, 
//       required this.rightClick, 
//       required this.leftIcon, 
//       required this.rightIcon, 
//       required this.authService
//     }
//   ): super(key: key);

//   void _left() {
//     // appbar.fadeSystemUI();

//     leftClick();
//   }

//   void _right() {
//     // appbar.fadeSystemUI();
    
//     rightClick();
//   }

//   final TextEditingController _username_t = TextEditingController();
//   final TextEditingController _busername_t = TextEditingController();
//   final TextEditingController _description_t = TextEditingController();
//   final TextEditingController _phoneNo_t = TextEditingController();
//   final TextEditingController _email_t = TextEditingController();
//   bool _isSwitched = false;

//   @override
//   Widget build(BuildContext context) {
    
//   }
// }