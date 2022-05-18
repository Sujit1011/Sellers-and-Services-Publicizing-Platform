import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shosev/about.dart' as about;
import 'package:shosev/add_service.dart';
import 'package:shosev/add_shop.dart';
import 'package:shosev/appbar.dart' as appbar;
import 'package:shosev/assets/design.dart' as design;
import 'package:shosev/edit_profile.dart';
import 'package:shosev/list_page.dart';
import 'package:shosev/models/SS_User.dart';
import 'package:shosev/services/auth.dart';
import 'package:shosev/services/data_repository.dart';

enum AuthState {
  phoneNo,
  otp,
}

class RegisterDrawer extends StatefulWidget {
  
  final AuthService authService;
  RegisterDrawer({Key? key, required this.authService}) : super(key: key);

  AuthState state = AuthState.phoneNo;

  @override
  State<RegisterDrawer> createState() => _SignInRegisteDrawerrState();
}

class _SignInRegisteDrawerrState extends State<RegisterDrawer> {
  // final FirebaseAuth _auth = FirebaseAuth.instance;
  final _formKey1 = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  // final _formKey3 = GlobalKey<FormState>();
  final TextEditingController _phoneNoController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  bool _helpSelected = false;
  bool _aboutUsSelected = false;
  bool _isLoading = false;

  String? verificationId;
  @override
  Widget build(BuildContext context) {
    // final user = Provider.of<SS_User?>(context);
    // if (user != null) {
    //   widget.state = AuthState.loggedIn;
    // }
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
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(flex: 8,),
              const design.LogoOnColored(),
              const Spacer(flex: 4,),
              if (widget.state == AuthState.phoneNo)
                Form(
                  key: _formKey1,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(34, 0, 34, 11),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.white,
                          ),
                          child: TextFormField(
                            controller: _phoneNoController,
                            style: const TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF333333),
                              letterSpacing: -0.5
                            ),
                            cursorColor: const Color(0xFF333333),
                            keyboardType: TextInputType.phone,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0)
                              ),
                              contentPadding: const EdgeInsets.fromLTRB(20, 0, 5, 5),
                              hintText: "Phone Number",
                              hintStyle: const TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFD1D1D1),
                                letterSpacing: -0.5
                              ),
                            ),
                            validator: (val){
                              if (val!.isEmpty) {
                                return "Enter Phone Number";
                              }
                              if (val.length > 15) {
                                return "Enter less than 15 characters";
                              }
                              return null;
                            },
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
                          child: TextFormField(
                            controller: _usernameController,
                            style: const TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF333333),
                              letterSpacing: -0.5
                            ),
                            cursorColor: const Color(0xFF333333),
                            keyboardType: TextInputType.name,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0)
                              ),
                              contentPadding: const EdgeInsets.fromLTRB(20, 0, 5, 5),
                              hintText: "User Name",
                              hintStyle: const TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFD1D1D1),
                                letterSpacing: -0.5
                              ),
                            ),
                            validator: (val){
                              if (val!.isEmpty) {
                                return "Enter User Name";
                              }
                              if (val.length > 20) {
                                return "Enter less than 20 characters";
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(34, 0, 34, 11),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            !_isLoading?InkWell(
                              child: Container(
                                width: 195,
                                height: 30.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: const Color(0xFF333333)
                                ),
                                child: const Center(
                                  child: Text(
                                    "SIGN-IN/UP",
                                    style: TextStyle(color: Color(0xFFFFFFFF), fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              onTap: () async {
                                // FirebaseService service = new FirebaseService();
                                if (_formKey1.currentState!.validate()) {
                                  setState(() {
                                    _isLoading = true;
                                  });
                                  await widget.authService.phoneSignIn(
                                    phoneNumber: _phoneNoController.text,
                                    onVerificationCompleted: _onVerificationCompleted,
                                    onVerificationFailed: _onVerificationFailed,
                                    onCodeSent: _onCodeSent,
                                    onCodeTimeout: _onCodeTimeout
                                  );
                                  // await phoneSignIn(phoneNumber: _phoneNoController.text);
                                  }
                                }
                            ):const CircularProgressIndicator(
                              color: Color(0xFF333333),
                              strokeWidth: 3,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              if (widget.state == AuthState.otp)
                Form(
                  key: _formKey2,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(34, 0, 34, 11),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.white,
                          ),
                          child: TextFormField(
                            controller: _otpController,
                            obscureText: true,
                            style: const TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF333333),
                              // letterSpacing: -0.5
                              letterSpacing: 8.0,
                            ),
                            cursorColor: const Color(0xFF333333),
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.done,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)),
                              contentPadding: const EdgeInsets.fromLTRB(20, 0, 5, 5),
                              hintText: "OTP",
                              hintStyle: const TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFD1D1D1),
                                letterSpacing: -0.5
                              ),
                            ),
                            validator: (val) => val!.length < 6 ? 'Enter valid OTP > 5' : null,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(34, 0, 34, 11),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              child: DottedBorder(
                                borderType: BorderType.RRect,
                                radius: const Radius.circular(30),
                                dashPattern: const [8, 4],
                                strokeWidth: 2,
                                padding: EdgeInsets.zero,
                                strokeCap: StrokeCap.round,
                                child: Container(
                                  width: 195,
                                  height: 30.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      "BACK",
                                      style: TextStyle(color: Color(0xFF333333), fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                              onTap: () async {
                                setState(() {
                                  widget.state = AuthState.phoneNo;
                                });
                              }
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(34, 0, 34, 11),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            !_isLoading?InkWell(
                              child: Container(
                                width: 195,
                                height: 30.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: const Color(0xFF333333)
                                ),
                                child: const Center(
                                  child: Text(
                                    "VALIDATE",
                                    style: TextStyle(color: Color(0xFFFFFFFF), fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              onTap: () async {
                                // FirebaseService service = new FirebaseService();
                                if (_formKey2.currentState!.validate()) {
                                  setState(() {
                                    _isLoading = true;
                                  });
                                  await widget.authService.phoneSignIn(
                                    phoneNumber: _phoneNoController.text,
                                    onVerificationCompleted: _onVerificationCompleted,
                                    onVerificationFailed: _onVerificationFailed,
                                    onCodeSent: _onCodeSent,
                                    onCodeTimeout: _onCodeTimeout
                                  );
                                  }
                                }
                            ):const CircularProgressIndicator(
                              color: Color(0xFF333333),
                              strokeWidth: 3,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

              // Form(
              //   key: _formKey1,
              //   child: Column(
              //     children: [
              //       Padding(
              //         padding: const EdgeInsets.fromLTRB(34, 0, 34, 11),
              //         child: Container(
              //           decoration: BoxDecoration(
              //             borderRadius: BorderRadius.circular(30),
              //             color: Colors.white,
              //           ),
              //           child: TextFormField(
              //             controller: _phoneNoController,
              //             style: const TextStyle(
              //               fontSize: 20.0,
              //               fontWeight: FontWeight.bold,
              //               color: Color(0xFF333333),
              //               letterSpacing: -0.5
              //             ),
              //             cursorColor: const Color(0xFF333333),
              //             keyboardType: TextInputType.phone,
              //             textInputAction: TextInputAction.next,
              //             decoration: InputDecoration(
              //               border: OutlineInputBorder(
              //                 borderRadius: BorderRadius.circular(30.0)
              //               ),
              //               contentPadding: const EdgeInsets.fromLTRB(20, 0, 5, 5),
              //               hintText: "Phone Number",
              //               hintStyle: const TextStyle(
              //                 fontSize: 20.0,
              //                 fontWeight: FontWeight.bold,
              //                 color: Color(0xFFD1D1D1),
              //                 letterSpacing: -0.5
              //               ),
              //             ),
              //             validator: (val) => val!.isEmpty ? 'Enter Phone Number' : null,
              //           ),
              //         ),
              //       ),
              //       Padding(
              //         padding: const EdgeInsets.fromLTRB(34, 0, 34, 11),
              //         child: Container(
              //           decoration: BoxDecoration(
              //             borderRadius: BorderRadius.circular(30),
              //             color: Colors.white,
              //           ),
              //           child: TextFormField(
              //             controller: _otpController,
              //             obscureText: true,
              //             style: const TextStyle(
              //               fontSize: 20.0,
              //               fontWeight: FontWeight.bold,
              //               color: Color(0xFF333333),
              //               // letterSpacing: -0.5
              //               letterSpacing: 8.0,
              //             ),
              //             cursorColor: const Color(0xFF333333),
              //             keyboardType: TextInputType.number,
              //             textInputAction: TextInputAction.done,
              //             decoration: InputDecoration(
              //               border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)),
              //               contentPadding: const EdgeInsets.fromLTRB(20, 0, 5, 5),
              //               hintText: "OTP",
              //               hintStyle: const TextStyle(
              //                 fontSize: 20.0,
              //                 fontWeight: FontWeight.bold,
              //                 color: Color(0xFFD1D1D1),
              //                 letterSpacing: -0.5
              //               ),
              //             ),
              //             validator: (val) => val!.length < 6 ? 'Enter valid OTP > 5' : null,
              //           ),
              //         ),
              //       ),
              //       Padding(
              //         padding: const EdgeInsets.fromLTRB(34, 0, 34, 11),
              //         child: Row(
              //           mainAxisAlignment: MainAxisAlignment.center,
              //           children: [
              //             !_isLoading?InkWell(
              //               child: Container(
              //                 width: 195,
              //                 height: 30.0,
              //                 decoration: BoxDecoration(
              //                   borderRadius: BorderRadius.circular(30),
              //                   color: const Color(0xFF333333)
              //                 ),
              //                 child: const Center(
              //                   child: Text(
              //                     "SIGN-IN",
              //                     style: TextStyle(color: Color(0xFFFFFFFF)),
              //                   ),
              //                 ),
              //               ),
              //               onTap: () async {
              //                 // FirebaseService service = new FirebaseService();
              //                 if (_formKey1.currentState!.validate()) {
              //                   setState(() {
              //                     _isLoading = true;
              //                   });
              //                   await phoneSignIn(phoneNumber: _phoneNoController.text);
              //                   }
              //                 }
              //             ):const CircularProgressIndicator(
              //               color: Color(0xFF333333),
              //               strokeWidth: 3,
              //             ),
              //           ],
              //         ),
              //       ),
              //     ],
              //   )
              // ),
              const Spacer(flex: 16,),
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
                          child: Center(child: Text('ABOUT US'))
                        ),
                        labelStyle: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.normal,
                          color: _aboutUsSelected
                              ? const Color(0xFFFFFFFF)
                              : const Color(0xFF333333),
                          letterSpacing: -0.5
                        ),
                        visualDensity: VisualDensity.compact,
                        selected: _aboutUsSelected,
                        onSelected: (bool selected) {
                          setState(() {
                            // appbar.fadeSystemUI();
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
                        label: const SizedBox(
                          width: 70,
                          height: 23,
                          child: Center(child: Text('HELP'))
                        ),
                        labelStyle: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.normal,
                          color: _helpSelected
                              ? const Color(0xFFFFFFFF)
                              : const Color(0xFF333333),
                          letterSpacing: -0.5
                        ),
                        visualDensity: VisualDensity.compact,
                        selected: _helpSelected,
                        onSelected: (bool selected) {
                          setState(() {
                            // appbar.fadeSystemUI();
                          });
                        },
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Future<void> phoneSignIn({required String phoneNumber}) async {
  //   await _auth.verifyPhoneNumber(
  //     phoneNumber: phoneNumber,
  //     verificationCompleted: _onVerificationCompleted,
  //     verificationFailed: _onVerificationFailed,
  //     codeSent: _onCodeSent,
  //     codeAutoRetrievalTimeout: _onCodeTimeout,
  //     timeout: const Duration(seconds: 60)
  //   );
  // }
  // phoneSignIn()
  
  _onVerificationCompleted(PhoneAuthCredential authCredential) async {
    print("verification completed ${authCredential.smsCode}");
    User? user = FirebaseAuth.instance.currentUser;
    setState(() {
      _otpController.text = authCredential.smsCode!;
    });
    if (authCredential.smsCode != null) {
      try{
        await user!.linkWithCredential(authCredential);
      } on FirebaseAuthException catch(e){
        if(e.code == 'provider-already-linked'){
          UserCredential result = await widget.authService.auth.signInWithCredential(authCredential);
          result.user?.updateDisplayName(_usernameController.text);
          user = result.user;
          print(user);
        }
      }
      DataRepository repository = DataRepository();
      repository.ss_users_collection.doc(user?.uid).set({
        "phoneNo": _phoneNoController.text,
        "username": _usernameController.text
      });
      setState(() {
        _isLoading = false;
      });
      // Navigator.pushNamedAndRemoveUntil(
      //     context, Constants.homeNavigate, (route) => false);
    }
  }

  _onVerificationFailed(FirebaseAuthException exception) {
    _otpController.clear();
    _phoneNoController.clear();
    _usernameController.clear();
    widget.state = AuthState.phoneNo;
    setState(() {
      _isLoading = false;
    });
    // if (exception.code == 'invalid-phone-number') {
      showMessage(exception.code);
    // }
  }

  _onCodeSent(String verificationId, int? forceResendingToken) async {
    widget.state = AuthState.otp;
    setState(() {
      _isLoading = false;
    });
    this.verificationId = verificationId;
    print(forceResendingToken);
    print("code sent");

    PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: _otpController.text);
    UserCredential result = await widget.authService.auth.signInWithCredential(credential);
    result.user?.updateDisplayName(_usernameController.text);
    User? user = result.user;
    print(user);
    DataRepository repository = DataRepository();
    repository.ss_users_collection.doc(user?.uid).set({
      "phoneNo": _phoneNoController.text,
      "username": _usernameController.text
    });
    
  }

  _onCodeTimeout(String timeout) {
    widget.state = AuthState.otp;
    return null;
  }

  void showMessage(String errorMessage) {
    showDialog(
      context: context,
      builder: (BuildContext builderContext) {
        return AlertDialog(
          title: const Text("Error"),
          content: Text(errorMessage),
          actions: [
            TextButton(
              child: const Text("Ok"),
              onPressed: () async {
                Navigator.of(builderContext).pop();
              },
            )
          ],
        );
      }).then((value) {
      setState(() {
        _isLoading = false;
      });
    });
  }
}

class SignedInDrawer extends StatefulWidget {
  final AuthService authService;
  const SignedInDrawer({Key? key, required this.authService}) : super(key: key);

  String generateRandomString(int len) {
    var r = Random();
    const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    return List.generate(len, (index) => _chars[r.nextInt(_chars.length)]).join();
  }


  @override
  State<SignedInDrawer> createState() => _SignedInDrawerState();
}

class _SignedInDrawerState extends State<SignedInDrawer> {

  dynamic data;

  @override
  void initState() {
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    final user = Provider.of<SS_User?>(context);
    // print(user);
    String user_id = user?.uid as String;
    if (data == null) {
      DataRepository repository = DataRepository();
      repository.ss_users_collection.doc(user_id).get().then((DocumentSnapshot doc) {
        setState(() {
          data = doc.data();
        });
        print(data);
      });
    }
    

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
            bottom: BorderSide(color: Color(0xFFFFC804), width: 2.0)
          )
        ),
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
                    )
                  ),
                  (data == null)?
                  const LinearProgressIndicator(
                    color: Color(0xFFFFC804),
                    minHeight: 4,
                  )
                  :Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(35, 80, 30, 10),
                      // child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Padding(
                            //   padding: const EdgeInsets.only(top: 0, bottom: 20.0),
                            //   child: 
                            // ),
                            SizedBox(
                              height: 55,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    (data != null)?data['username']:"",
                                    style: Theme.of(context).textTheme.headline2,
                                    textAlign: TextAlign.center,
                                  ),
                                  Text((data != null)?data['phoneNo']:"",
                                    style: const TextStyle(
                                      color: Color(0xFFAAAAAA),
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold
                                    ),
                                    textAlign: TextAlign.center,
                                  )
                                ],
                              ),
                            ),
                            const Spacer(flex: 3),
                            if (data != null && data['businessUser'] == true)
                              TextButton.icon(
                                style: TextButton.styleFrom(
                                  alignment: Alignment.centerLeft,
                                  backgroundColor: const Color(0xFFFFC804),
                                  primary: const Color(0xFF333333),
                                  minimumSize: const Size(204, 40),
                                  padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 14),
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                        ListPage(
                                          title: "My Shops",
                                          username: (data != null)?data['username']:"",
                                          phoneNo: (data != null)?data['phoneNo']:"",
                                          isLeftFloattingButton: true,
                                          isRightFloattingButton: true,
                                          leftClick: () => {
                                            Navigator.pop(context)
                                          },
                                          rightClick: () => {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => AddShop(
                                                  username: (data != null)?data['username']:"", 
                                                  phoneNo: (data != null)?data['phoneNo']:"", 
                                                  title: "Add Shop", 
                                                  isLeftFloattingButton: true, 
                                                  isRightFloattingButton: false, 
                                                  leftClick: () => {
                                                    Navigator.pop(context)
                                                  },
                                                  rightClick: () => {}, 
                                                  leftIcon: const Icon(Icons.chevron_left_rounded),
                                                  rightIcon: const Icon(Icons.add_rounded),
                                                )
                                              )
                                            )
                                          },
                                          leftIcon: const Icon(Icons.chevron_left_rounded),
                                          rightIcon: const Icon(Icons.add_rounded),
                                          heroLeft: "shop_left",
                                          heroRight: "shop_right",
                                        )
                                    ),
                                  );
                                },
                                icon: const Icon(Icons.shopping_bag),
                                label: const Text(
                                  "MY SHOPS",
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.normal,
                                    color: Color(0xFF333333),
                                    letterSpacing: -0.5
                                  ),
                                ),
                              ),
                            const Spacer(flex: 1),
                            if (data != null && data['businessUser'] == true)
                              TextButton.icon(
                                style: TextButton.styleFrom(
                                  alignment: Alignment.centerLeft,
                                  backgroundColor: const Color(0xFFFFC804),
                                  primary: const Color(0xFF333333),
                                  minimumSize: const Size(204, 40),
                                  padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 14),
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                        ListPage(
                                          title: "My Services",
                                          username: (data != null)?data['username']:"",
                                          phoneNo: (data != null)?data['phoneNo']:"",
                                          isLeftFloattingButton: true,
                                          isRightFloattingButton: true,
                                          leftClick: () => {
                                            Navigator.pop(context)
                                          },
                                          rightClick: () => {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => AddService(
                                                  username: (data != null)?data['username']:"", 
                                                  phoneNo: (data != null)?data['phoneNo']:"", 
                                                  title: "Add Services", 
                                                  isLeftFloattingButton: true, 
                                                  isRightFloattingButton: false, 
                                                  leftClick: () => {
                                                    Navigator.pop(context)
                                                  },
                                                  rightClick: () => {}, 
                                                  leftIcon: const Icon(Icons.chevron_left_rounded),
                                                  rightIcon: const Icon(Icons.add_rounded),
                                                )
                                              )
                                            )
                                          },
                                          leftIcon: const Icon(Icons.chevron_left_rounded),
                                          rightIcon: const Icon(Icons.add_rounded),
                                          heroLeft: "shop_left",
                                          heroRight: "shop_right",
                                        )
                                    ),
                                  );
                                },
                                icon: const Icon(Icons.home_repair_service_rounded),
                                label: const Text(
                                  "MY SERVICES",
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.normal,
                                    color: Color(0xFF333333),
                                    letterSpacing: -0.5
                                  ),
                                ),
                              ),
                            const Spacer(flex: 1),
                            DottedBorder(
                              borderType: BorderType.RRect,
                              radius: const Radius.circular(30),
                              dashPattern: const [4, 4],
                              strokeWidth: 2,
                              padding: EdgeInsets.zero,
                              color: const Color(0xFFFFC804),
                              strokeCap: StrokeCap.round,
                              child: TextButton.icon(
                                style: TextButton.styleFrom(
                                  alignment: Alignment.centerLeft,
                                  backgroundColor: const Color(0xFFFFFFFF),
                                  primary: const Color(0xFF333333),
                                  minimumSize: const Size(204, 40),
                                  padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 14),
                                  shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(28.0)),
                                  ),
                                  // shape: RoundedRectangleBorder(
                                  //   side: const BorderSide(
                                  //     color: Color(0xFFFFC804),
                                  //     width: 1,
                                  //     style: BorderStyle.solid
                                  //   ),
                                  //   borderRadius: BorderRadius.circular(30)
                                  // ),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                        ListPage(
                                          title: "My History",
                                          username: (data != null)?data['username']:"",
                                          phoneNo: (data != null)?data['phoneNo']:"",
                                          isLeftFloattingButton: true,
                                          isRightFloattingButton: false,
                                          leftClick: () => {
                                            Navigator.pop(context)
                                          },
                                          rightClick: () => {},
                                          leftIcon: const Icon(Icons.chevron_left_rounded),
                                          rightIcon: const Icon(Icons.chevron_right_rounded),
                                          heroLeft: "history_left",
                                          heroRight: "history_right",
                                        )
                                    ),
                                  );
                                },
                                icon: const Icon(Icons.history),
                                label: const Text(
                                  "MY HISTORY",
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.normal,
                                    color: Color(0xFF333333),
                                    letterSpacing: -0.5
                                  ),
                                ),
                              )
                            ),
                            const Spacer(flex: 1),
                            DottedBorder(
                              borderType: BorderType.RRect,
                              radius: const Radius.circular(30),
                              dashPattern: const [4, 4],
                              strokeWidth: 2,
                              padding: EdgeInsets.zero,
                              color: const Color(0xFFFFC804),
                              strokeCap: StrokeCap.round,
                              child: TextButton.icon(
                                style: TextButton.styleFrom(
                                  alignment: Alignment.centerLeft,
                                  backgroundColor: const Color(0xFFFFFFFF),
                                  primary: const Color(0xFF333333),
                                  minimumSize: const Size(204, 40),
                                  padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 14),
                                  shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(28.0)),
                                  ),
                                  // shape: RoundedRectangleBorder(
                                  //   side: const BorderSide(
                                  //       color: Color(0xFFFFC804),
                                  //       width: 1,
                                  //       style: BorderStyle.solid),
                                  //   borderRadius: BorderRadius.circular(28)
                                  // ),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                        ListPage(
                                          title: "My Favourites",
                                          username: (data != null)?data['username']:"",
                                          phoneNo: (data != null)?data['phoneNo']:"",
                                          isLeftFloattingButton: true,
                                          isRightFloattingButton: false,
                                          leftClick: () => {
                                            Navigator.pop(context)
                                          },
                                          rightClick: () => {},
                                          leftIcon: const Icon(Icons.chevron_left_rounded),
                                          rightIcon: const Icon(Icons.chevron_right_rounded),
                                          heroLeft: "favourites_left",
                                          heroRight: "favourites_right",
                                        )
                                    ),
                                  );
                                },
                                icon: const Icon(Icons.favorite),
                                label: const Text(
                                  "MY FAVOURITES",
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.normal,
                                    color: Color(0xFF333333),
                                    letterSpacing: -0.5
                                  ),
                                ),
                              )
                            ),
                            const Spacer(flex: 1),
                            DottedBorder(
                              borderType: BorderType.RRect,
                              radius: const Radius.circular(30),
                              dashPattern: const [4, 4],
                              strokeWidth: 2,
                              padding: EdgeInsets.zero,
                              color: const Color(0xFFFFC804),
                              strokeCap: StrokeCap.round,
                              child: TextButton.icon(
                                style: TextButton.styleFrom(
                                  alignment: Alignment.centerLeft,
                                  backgroundColor: const Color(0xFFFFFFFF),
                                  primary: const Color(0xFF333333),
                                  minimumSize: const Size(204, 40),
                                  padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 14),
                                  shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(28.0)),
                                  ),
                                  // shape: RoundedRectangleBorder(
                                  //   side: const BorderSide(
                                  //       color: Color(0xFFFFC804),
                                  //       width: 1,
                                  //       style: BorderStyle.solid),
                                  //   borderRadius: BorderRadius.circular(30)
                                  // ),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                        ListPage(
                                          title: "My Reviews",
                                          username: (data != null)?data['username']:"",
                                          phoneNo: (data != null)?data['phoneNo']:"",
                                          isLeftFloattingButton: true,
                                          isRightFloattingButton: false,
                                          leftClick: () => {
                                            Navigator.pop(context)
                                          },
                                          rightClick: () => {},
                                          leftIcon: const Icon(Icons.chevron_left_rounded),
                                          rightIcon: const Icon(Icons.chevron_right_rounded),
                                          heroLeft: "reviews_left",
                                          heroRight: "reviews_right",
                                        )
                                    ),
                                  );
                                },
                                icon: const Icon(Icons.reviews),
                                label: const Text(
                                  "MY REVIEWS",
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.normal,
                                    color: Color(0xFF333333),
                                    letterSpacing: -0.5
                                  ),
                                ),
                              )
                            ),
                            const Spacer(flex: 1),
                            TextButton.icon(
                              style: TextButton.styleFrom(
                                alignment: Alignment.centerLeft,
                                backgroundColor: const Color(0xFFE5E5E5),
                                primary: const Color(0xFF333333),
                                minimumSize: const Size(204, 40),
                                padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 14),
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
                                      EditProfile(
                                        title: "EDIT PROFILE",
                                        username: (data != null)?data['username']:"",
                                        phoneNo: (data != null)?data['phoneNo']:"",
                                        isLeftFloattingButton: true,
                                        isRightFloattingButton: false,
                                        leftClick: () => {
                                          Navigator.pop(context)
                                        },
                                        rightClick: () => {},
                                        leftIcon: const Icon(Icons.chevron_left_rounded),
                                        rightIcon: const Icon(Icons.chevron_right_rounded),
                                      )
                                  ),
                                );
                              },
                              icon: const Icon(Icons.edit),
                              label: const Text(
                                "EDIT PROFILE",
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.normal,
                                  color: Color(0xFF333333),
                                  letterSpacing: -0.5
                                ),
                              ),
                            ),
                            const Spacer(flex: 5),
                            OutlinedButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFFEE4949)),
                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
                                ),
                              ),
                              onPressed: () async {
                                await widget.authService.auth.signOut();
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (context) =>
                                //       const all_shops_services
                                //           .All_Shops_Services(
                                //         title: "My Reviews",
                                //         aboutUs: "Sujit Soren",
                                //       )
                                //   ),
                                // );
                              },
                              child: const Text(
                                "Logout",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            const Spacer(flex: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                OutlinedButton(
                                  style: ButtonStyle(
                                    backgroundColor:MaterialStateProperty.all<Color>(const Color(0xFFFCE48F)),
                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius:BorderRadius.circular(18.0),
                                      ),
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => about.MyAboutUs(
                                          title: "About Us",
                                          aboutUs: widget.generateRandomString(2000)
                                        )
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    "About Us",
                                    style: TextStyle(color: Color(0xFF333333)),
                                  ),
                                ),
                                OutlinedButton(
                                  style: ButtonStyle(
                                    backgroundColor:MaterialStateProperty.all<Color>(const Color(0xFFFCE48F)),
                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(18.0),
                                      ),
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => about.MyAboutUs(
                                          title: "About Us",
                                          aboutUs: widget.generateRandomString(2000)
                                        )
                                      ),
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
                        )
                      ),
                    )
                  // )
                ],
              ),
              const Positioned(top: 62, left: 30, right: 30, child: design.LogoSimple())
            ],
          ),
        )
      )
    );
  }
}
// class signindrawer1 extends StatelessWidget {

//   final AuthService authService;
//   final bool businessmember;
//   signindrawer1({
//     Key? key,
//     required this.authService,
//     required this.businessmember,
//   }) : super(key: key);

//   String username = '';
//   String phoneNo = '';
  
//   @override
//   void initState() {
//     super.initState();
    
    
   
//   }

//   void initialize() async{
//     DataRepository repository = DataRepository();
//     DocumentSnapshot snap = await repository.ss_users_collection.doc().get() as DocumentSnapshot<Object?>;
//     username = snap['userName'];
//     phoneNo = snap['phoneNo'];
//   }

//   String generateRandomString(int len) {
//     var r = Random();
//     const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
//     return List.generate(len, (index) => _chars[r.nextInt(_chars.length)]).join();
//   }

//   // DataRepository repository = DataRepository();
  
  

//   @override
//   Widget build(BuildContext context) {
//     // bool isSwitched = false;
//     // bool _shareValue = false;
//     // repository.ss_users_collection.doc(authService.auth.currentUser?.uid).snapshots();
//     return Padding(
//       padding: const EdgeInsets.all(11.0),
//       child: Container(
//         width: 272,
//         decoration: const BoxDecoration(
//           borderRadius: BorderRadius.all(Radius.circular(30)),
//           border: Border(
//             left: BorderSide(color: Color(0xFFFFC804), width: 2.0),
//             top: BorderSide(color: Color(0xFFFFC804), width: 2.0),
//             right: BorderSide(color: Color(0xFFFFC804), width: 2.0),
//             bottom: BorderSide(color: Color(0xFFFFC804), width: 2.0)
//           )
//         ),
//         child: Drawer(
//           shape: const RoundedRectangleBorder(
//             borderRadius: BorderRadius.all(Radius.circular(30)),
//           ),
//           child: Stack(
//             children: <Widget>[
//               Column(
//                 children: [
//                   Container(
//                     height: 146,
//                     // width: double.infinity,
//                     // color: Color(0xFFFFC804),
//                     decoration: const BoxDecoration(
//                       borderRadius: BorderRadius.only(
//                           topLeft: Radius.circular(28.0),
//                           topRight: Radius.circular(28.0)),
//                       color: Color(0xFFE5E5E5),
//                     )
//                   ),
//                   Expanded(
//                     child: Padding(
//                       padding: const EdgeInsets.fromLTRB(35, 80, 30, 10),
//                       // child: SingleChildScrollView(
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             // Padding(
//                             //   padding: const EdgeInsets.only(top: 0, bottom: 20.0),
//                             //   child: 
//                             // ),
//                             SizedBox(
//                               height: 55,
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     username,
//                                     style:
//                                         Theme.of(context).textTheme.headline2,
//                                   ),
//                                   Text(phoneNo,
//                                   style: const TextStyle(
//                                     color: Color(0xFFAAAAAA),
//                                     fontSize: 14,
//                                     fontWeight: FontWeight.bold)
//                                   )
//                                 ],
//                               ),
//                             ),
//                             const Spacer(flex: 3),
//                             if (businessmember == true)
//                               TextButton.icon(
//                                 style: TextButton.styleFrom(
//                                   alignment: Alignment.centerLeft,
//                                   backgroundColor: const Color(0xFFFFC804),
//                                   primary: const Color(0xFF333333),
//                                   minimumSize: const Size(204, 40),
//                                   padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 14),
//                                   shape: const RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.all(Radius.circular(30.0)),
//                                   ),
//                                 ),
//                                 onPressed: () {
//                                   Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                       builder: (context) =>
//                                         ListPage(
//                                           title: "My Chats",
//                                           username: (data != null)?data['username']:"",
//                                           phoneNo: (data != null)?data['phoneNo']:"",
//                                           isLeftFloattingButton: true,
//                                           isRightFloattingButton: false,
//                                           leftClick: () => {
//                                             Navigator.pop(context)
//                                           },
//                                           rightClick: () => {},
//                                           leftIcon: const Icon(Icons.chevron_left_rounded),
//                                           rightIcon: const Icon(Icons.chevron_right_rounded),
//                                         )
//                                     ),
//                                   );
//                                 },
//                                 icon: const Icon(Icons.shopping_bag),
//                                 label: const Text(
//                                   "MY SHOPS",
//                                   style: TextStyle(
//                                     fontSize: 18.0,
//                                     fontWeight: FontWeight.normal,
//                                     color: Color(0xFF333333),
//                                     letterSpacing: -0.5
//                                   ),
//                                 ),
//                               ),
//                             const Spacer(flex: 1),
//                             if (businessmember == true)
//                               TextButton.icon(
//                                 style: TextButton.styleFrom(
//                                   alignment: Alignment.centerLeft,
//                                   backgroundColor: const Color(0xFFFFC804),
//                                   primary: const Color(0xFF333333),
//                                   minimumSize: const Size(204, 40),
//                                   padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 14),
//                                   shape: const RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.all(Radius.circular(30.0)),
//                                   ),
//                                 ),
//                                 onPressed: () {
//                                   Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                       builder: (context) =>
//                                         ListPage(
//                                           title: "My Chats",
//                                           username: (data != null)?data['username']:"",
//                                           phoneNo: (data != null)?data['phoneNo']:"",
//                                           isLeftFloattingButton: true,
//                                           isRightFloattingButton: false,
//                                           leftClick: () => {
//                                             Navigator.pop(context)
//                                           },
//                                           rightClick: () => {},
//                                           leftIcon: const Icon(Icons.chevron_left_rounded),
//                                           rightIcon: const Icon(Icons.chevron_right_rounded),
//                                         )
//                                     ),
//                                   );
//                                 },
//                                 icon: const Icon(Icons.home_repair_service_rounded),
//                                 label: const Text(
//                                   "MY SERVICES",
//                                   style: TextStyle(
//                                     fontSize: 18.0,
//                                     fontWeight: FontWeight.normal,
//                                     color: Color(0xFF333333),
//                                     letterSpacing: -0.5
//                                   ),
//                                 ),
//                               ),
//                             const Spacer(flex: 1),
//                             TextButton.icon(
//                               style: TextButton.styleFrom(
//                                 alignment: Alignment.centerLeft,
//                                 backgroundColor: const Color(0xFFFFFFFF),
//                                 primary: const Color(0xFF333333),
//                                 minimumSize: const Size(204, 40),
//                                 padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 14),
//                                 // shape: const RoundedRectangleBorder(
//                                 //   borderRadius:
//                                 //       BorderRadius.all(Radius.circular(30.0)),
//                                 // ),
//                                 shape: RoundedRectangleBorder(
//                                   side: const BorderSide(
//                                     color: Color(0xFFFFC804),
//                                     width: 1,
//                                     style: BorderStyle.solid
//                                   ),
//                                   borderRadius: BorderRadius.circular(30)
//                                 ),
//                               ),
//                               onPressed: () {
//                                 Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                     builder: (context) =>
//                                       ListPage(
//                                         title: "My Chats",
//                                         username: (data != null)?data['username']:"",
//                                         phoneNo: (data != null)?data['phoneNo']:"",
//                                         isLeftFloattingButton: true,
//                                         isRightFloattingButton: false,
//                                         leftClick: () => {
//                                           Navigator.pop(context)
//                                         },
//                                         rightClick: () => {},
//                                         leftIcon: const Icon(Icons.chevron_left_rounded),
//                                         rightIcon: const Icon(Icons.chevron_right_rounded),
//                                       )
//                                   ),
//                                 );
//                               },
//                               icon: const Icon(Icons.history),
//                               label: const Text(
//                                 "MY HISTORY",
//                                 style: TextStyle(
//                                   fontSize: 18.0,
//                                   fontWeight: FontWeight.normal,
//                                   color: Color(0xFF333333),
//                                   letterSpacing: -0.5
//                                 ),
//                               ),
//                             ),
//                             const Spacer(flex: 1),
//                             TextButton.icon(
//                               style: TextButton.styleFrom(
//                                 alignment: Alignment.centerLeft,
//                                 backgroundColor: const Color(0xFFFFFFFF),
//                                 primary: const Color(0xFF333333),
//                                 minimumSize: const Size(204, 40),
//                                 padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 14),
//                                 // shape: const RoundedRectangleBorder(
//                                 //   borderRadius:
//                                 //       BorderRadius.all(Radius.circular(30.0)),
//                                 // ),
//                                 shape: RoundedRectangleBorder(
//                                   side: const BorderSide(
//                                       color: Color(0xFFFFC804),
//                                       width: 1,
//                                       style: BorderStyle.solid),
//                                   borderRadius: BorderRadius.circular(30)
//                                 ),
//                               ),
//                               onPressed: () {
//                                 Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                     builder: (context) =>
//                                       ListPage(
//                                         title: "My Chats",
//                                         username: (data != null)?data['username']:"",
//                                         phoneNo: (data != null)?data['phoneNo']:"",
//                                         isLeftFloattingButton: true,
//                                         isRightFloattingButton: false,
//                                         leftClick: () => {
//                                           Navigator.pop(context)
//                                         },
//                                         rightClick: () => {},
//                                         leftIcon: const Icon(Icons.chevron_left_rounded),
//                                         rightIcon: const Icon(Icons.chevron_right_rounded),
//                                       )
//                                   ),
//                                 );
//                               },
//                               icon: const Icon(Icons.favorite),
//                               label: const Text(
//                                 "MY FAVOURITES",
//                                 style: TextStyle(
//                                   fontSize: 18.0,
//                                   fontWeight: FontWeight.normal,
//                                   color: Color(0xFF333333),
//                                   letterSpacing: -0.5
//                                 ),
//                               ),
//                             ),
//                             const Spacer(flex: 1),
//                             TextButton.icon(
//                               style: TextButton.styleFrom(
//                                 alignment: Alignment.centerLeft,
//                                 backgroundColor: const Color(0xFFFFFFFF),
//                                 primary: const Color(0xFF333333),
//                                 minimumSize: const Size(204, 40),
//                                 padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 14),
//                                 // shape: const RoundedRectangleBorder(
//                                 //   borderRadius:
//                                 //       BorderRadius.all(Radius.circular(30.0)),
//                                 // ),
//                                 shape: RoundedRectangleBorder(
//                                   side: const BorderSide(
//                                       color: Color(0xFFFFC804),
//                                       width: 1,
//                                       style: BorderStyle.solid),
//                                   borderRadius: BorderRadius.circular(30)
//                                 ),
//                               ),
//                               onPressed: () {
//                                 Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                     builder: (context) =>
//                                       ListPage(
//                                         title: "My Chats",
//                                         username: (data != null)?data['username']:"",
//                                         phoneNo: (data != null)?data['phoneNo']:"",
//                                         isLeftFloattingButton: true,
//                                         isRightFloattingButton: false,
//                                         leftClick: () => {
//                                           Navigator.pop(context)
//                                         },
//                                         rightClick: () => {},
//                                         leftIcon: const Icon(Icons.chevron_left_rounded),
//                                         rightIcon: const Icon(Icons.chevron_right_rounded),
//                                       )
//                                   ),
//                                 );
//                               },
//                               icon: const Icon(Icons.reviews),
//                               label: const Text(
//                                 "MY REVIEWS",
//                                 style: TextStyle(
//                                   fontSize: 18.0,
//                                   fontWeight: FontWeight.normal,
//                                   color: Color(0xFF333333),
//                                   letterSpacing: -0.5
//                                 ),
//                               ),
//                             ),
//                             const Spacer(flex: 1),
//                             TextButton.icon(
//                               style: TextButton.styleFrom(
//                                 alignment: Alignment.centerLeft,
//                                 backgroundColor: const Color(0xFFE5E5E5),
//                                 primary: const Color(0xFF333333),
//                                 minimumSize: const Size(204, 40),
//                                 padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 14),
//                                 shape: const RoundedRectangleBorder(
//                                   borderRadius:
//                                       BorderRadius.all(Radius.circular(30.0)),
//                                 ),
//                               ),
//                               onPressed: () {
//                                 Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                     builder: (context) =>
//                                       ListPage(
//                                         title: "My Chats",
//                                         username: (data != null)?data['username']:"",
//                                         phoneNo: (data != null)?data['phoneNo']:"",
//                                         isLeftFloattingButton: true,
//                                         isRightFloattingButton: false,
//                                         leftClick: () => {
//                                           Navigator.pop(context)
//                                         },
//                                         rightClick: () => {},
//                                         leftIcon: const Icon(Icons.chevron_left_rounded),
//                                         rightIcon: const Icon(Icons.chevron_right_rounded),
//                                       )
//                                   ),
//                                 );
//                               },
//                               icon: const Icon(Icons.edit),
//                               label: const Text(
//                                 "EDIT PROFILE",
//                                 style: TextStyle(
//                                   fontSize: 18.0,
//                                   fontWeight: FontWeight.normal,
//                                   color: Color(0xFF333333),
//                                   letterSpacing: -0.5
//                                 ),
//                               ),
//                             ),
//                             const Spacer(flex: 5),
//                             OutlinedButton(
//                               style: ButtonStyle(
//                                 backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFFEE4949)),
//                                 shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                                   RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
//                                 ),
//                               ),
//                               onPressed: () async {
//                                 await authService.auth.signOut();
//                                 // Navigator.push(
//                                 //   context,
//                                 //   MaterialPageRoute(
//                                 //     builder: (context) =>
//                                 //       const all_shops_services
//                                 //           .All_Shops_Services(
//                                 //         title: "My Reviews",
//                                 //         aboutUs: "Sujit Soren",
//                                 //       )
//                                 //   ),
//                                 // );
//                               },
//                               child: const Text(
//                                 "Logout",
//                                 style: TextStyle(color: Colors.white),
//                               ),
//                             ),
//                             const Spacer(flex: 5),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               children: [
//                                 OutlinedButton(
//                                   style: ButtonStyle(
//                                     backgroundColor:MaterialStateProperty.all<Color>(const Color(0xFFFCE48F)),
//                                     shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                                       RoundedRectangleBorder(
//                                         borderRadius:BorderRadius.circular(18.0),
//                                       ),
//                                     ),
//                                   ),
//                                   onPressed: () {
//                                     Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                         builder: (context) => about.MyAboutUs(
//                                           title: "About Us",
//                                           aboutUs:generateRandomString(2000)
//                                         )
//                                       ),
//                                     );
//                                   },
//                                   child: const Text(
//                                     "About Us",
//                                     style: TextStyle(color: Color(0xFF333333)),
//                                   ),
//                                 ),
//                                 OutlinedButton(
//                                   style: ButtonStyle(
//                                     backgroundColor:MaterialStateProperty.all<Color>(const Color(0xFFFCE48F)),
//                                     shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                                       RoundedRectangleBorder(
//                                         borderRadius: BorderRadius.circular(18.0),
//                                       ),
//                                     ),
//                                   ),
//                                   onPressed: () {
//                                     Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                         builder: (context) => about.MyAboutUs(
//                                           title: "About Us",
//                                           aboutUs: generateRandomString(2000)
//                                         )
//                                       ),
//                                     );
//                                   },
//                                   child: const Text(
//                                     "Help",
//                                     style: TextStyle(color: Color(0xFF333333)),
//                                   ),
//                                 )
//                               ],
//                             ),
//                           ],
//                         )
//                       ),
//                     )
//                   // )
//                 ],
//               ),
//               const Positioned(top: 62, left: 30, right: 30, child: design.LogoSimple())
//             ],
//           ),
//         )
//       )
//     );
//   }

//   void setState(Null Function() param0) {}
// }
