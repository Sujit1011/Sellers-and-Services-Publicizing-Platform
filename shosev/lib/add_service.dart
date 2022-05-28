import 'package:cloud_firestore/cloud_firestore.dart' show Timestamp;
import 'package:flutter/foundation.dart' show Factory, Key;
import 'package:flutter/gestures.dart' show PanGestureRecognizer;
import 'package:flutter/material.dart' show AlertDialog, AnnotatedRegion, BorderRadius, BoxDecoration, BuildContext, Center, CircleAvatar, Color, Colors, Column, Container, CrossAxisAlignment, Divider, DropdownButtonFormField, DropdownMenuItem, EdgeInsets, Expanded, FloatingActionButton, FloatingActionButtonLocation, FontWeight, Form, FormState, GlobalKey, Icon, Icons, InkWell, InputDecoration, Key, MainAxisAlignment, MediaQuery, Navigator, OutlineInputBorder, Padding, Positioned, Row, Scaffold, SingleChildScrollView, SizedBox, Spacer, Stack, State, StatefulWidget, Text, TextButton, TextEditingController, TextFormField, TextInputAction, TextInputType, TextStyle, Theme, TimeOfDay, Widget, WidgetsBinding, showDialog, showTimePicker;
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' show CameraPosition, GoogleMap, GoogleMapController, LatLng, MapType, ScreenCoordinate;
import 'package:intl/intl.dart' show DateFormat;
import 'package:provider/provider.dart' show Provider;
import 'package:shosev/assets/design.dart';
import 'package:shosev/models/SS_User.dart' show SS_User;
import 'package:shosev/services/data_repository.dart' show DataRepository;

const List<String> serviceCategories = [
  "Business Services",
  "Communication Services",
  "Construction & Engineering",
  "Distribution Services",
  "Education",
  "Environment Services",
  "Finance service",
  "Tourism Services",
  "Health Services",
  "Recreation Services",
  "Transportation Services",
];

class AddService extends StatefulWidget {
  final String username;
  final String phoneNo;
  final String title;
  final bool isLeftFloattingButton;
  final bool isRightFloattingButton;
  final Icon leftIcon;
  final Icon rightIcon;
  final bool update;
  final dynamic updateData;

  final Function leftClick;
  final Function rightClick;

  double latitude = 23.176890894138687;
  double longitude = 80.0233220952035;

  AddService(
      {Key? key,
      required this.username,
      required this.phoneNo,
      required this.title,
      required this.isLeftFloattingButton,
      required this.isRightFloattingButton,
      required this.leftClick,
      required this.rightClick,
      required this.leftIcon,
      required this.rightIcon,
      required this.update,
      required this.updateData})
      : super(key: key);

  void _left() {
    // appbar.fadeSystemUI();
    // setState(() {
    //   // (_controller.index == 0) ? null : --_controller.index;
    // });
    leftClick();
  }

  void _right() {
    // appbar.fadeSystemUI();
    // setState(() {});
    rightClick();
  }

  @override
  State<AddService> createState() => _AddServiceState();
}

class _AddServiceState extends State<AddService> {
  static List<String?> serviceNameList = [null];
  static List<String?> serviceCostList = [null];
  final TextEditingController _service_name_t = TextEditingController();
  final TextEditingController _address_t = TextEditingController();
  final TextEditingController _description_t = TextEditingController();
  final TextEditingController _phoneNo_t = TextEditingController();
  final TextEditingController _email_t = TextEditingController();
  final TextEditingController _timeinput_sun1 = TextEditingController();
  final TextEditingController _timeinput_sun2 = TextEditingController();
  final TextEditingController _timeinput_mon1 = TextEditingController();
  final TextEditingController _timeinput_mon2 = TextEditingController();
  final TextEditingController _timeinput_tue1 = TextEditingController();
  final TextEditingController _timeinput_tue2 = TextEditingController();
  final TextEditingController _timeinput_wed1 = TextEditingController();
  final TextEditingController _timeinput_wed2 = TextEditingController();
  final TextEditingController _timeinput_thu1 = TextEditingController();
  final TextEditingController _timeinput_thu2 = TextEditingController();
  final TextEditingController _timeinput_fri1 = TextEditingController();
  final TextEditingController _timeinput_fri2 = TextEditingController();
  final TextEditingController _timeinput_sat1 = TextEditingController();
  final TextEditingController _timeinput_sat2 = TextEditingController();
  String _category = "";
  List servicesList = [];
  List searchKeywords = [];
  List reviews = [];
  late GoogleMapController googleMapController;

  @override
  void initState() {
    super.initState();
    if (widget.update && widget.updateData != null) {
      _service_name_t.text = widget.updateData['name'];
      _address_t.text = widget.updateData['address'];
      _category = widget.updateData['category'];
      _timeinput_sun1.text = widget.updateData['workingHours'][0];
      _timeinput_sun2.text = widget.updateData['workingHours'][1];
      _timeinput_mon1.text = widget.updateData['workingHours'][2];
      _timeinput_mon2.text = widget.updateData['workingHours'][3];
      _timeinput_tue1.text = widget.updateData['workingHours'][4];
      _timeinput_tue2.text = widget.updateData['workingHours'][5];
      _timeinput_wed1.text = widget.updateData['workingHours'][6];
      _timeinput_wed2.text = widget.updateData['workingHours'][7];
      _timeinput_thu1.text = widget.updateData['workingHours'][8];
      _timeinput_thu2.text = widget.updateData['workingHours'][9];
      _timeinput_fri1.text = widget.updateData['workingHours'][10];
      _timeinput_fri2.text = widget.updateData['workingHours'][11];
      _timeinput_sat1.text = widget.updateData['workingHours'][12];
      _timeinput_sat2.text = widget.updateData['workingHours'][13];
      _description_t.text = widget.updateData['description'];
      _phoneNo_t.text = widget.updateData['phoneNo'];
      _email_t.text = widget.updateData['email'];
      servicesList = widget.updateData['services'];
      serviceNameList = [];
      serviceCostList = [];
      for (int i = 0; i < servicesList.length; i++) {
        serviceNameList.add(servicesList[i]['productName']);
        serviceCostList.add(servicesList[i]['cost']);
      }
      searchKeywords = widget.updateData['searchKeywords'];
      widget.latitude = widget.updateData['latitute'];
      widget.longitude = widget.updateData['longitude'];
    }
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final _myUser = Provider.of<SS_User?>(context);
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
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.only(bottom: 47, right: 0),
                      child: MediaQuery(
                        data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Service Name",
                                  style: Theme.of(context).textTheme.titleLarge
                                ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0, bottom: 16),
                                child: TextFormField(
                                  controller: _service_name_t,
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
                                    border: OutlineInputBorder( borderRadius: BorderRadius.circular(10.0)),
                                    contentPadding: const EdgeInsets.fromLTRB(20, 0, 5, 5),
                                    hintText: "ABC Service",
                                    hintStyle: const TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.normal,
                                      color: Color(0xFFD1D1D1),
                                      letterSpacing: -0.5
                                    ),
                                  ),
                                  validator: (val) {
                                    if (val!.isEmpty) {
                                      return "Enter Service Name";
                                    }
                                    if (val.length > 80) {
                                      return "Enter less than 80 characters";
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              Text("Address", style: Theme.of(context).textTheme.titleLarge),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0, bottom: 16),
                                child: TextFormField(
                                  controller: _address_t,
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
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                                    contentPadding: const EdgeInsets.fromLTRB(20, 0, 5, 5),
                                    hintText: "XYZ Place, XYZ Street, near XYZ, State pincode",
                                    hintStyle: const TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.normal,
                                      color: Color(0xFFD1D1D1),
                                      letterSpacing: -0.5
                                    ),
                                  ),
                                  validator: (val) {
                                    if (val!.isEmpty) {
                                      return "Enter Address";
                                    }
                                    if (val.length > 150) {
                                      return "Enter less than 150 characters";
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              Text("Category", style: Theme.of(context).textTheme.titleLarge),
                              Padding(padding: const EdgeInsets.only(top: 8.0, bottom: 16),
                                child: DropdownButtonFormField(
                                  items: serviceCategories.map((str) {
                                    return DropdownMenuItem(
                                      child: Text(str),
                                      value: str
                                    );
                                  }).toList(),
                            
                                  style: const TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.normal,
                                    color: Color(0xFF333333),
                                    letterSpacing: -0.5
                                  ),
                                  // cursorColor: const Color(0xFF333333),
                                  // keyboardType: TextInputType.phone,
                                  // textInputAction: TextInputAction.next,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                                    contentPadding: const EdgeInsets.fromLTRB(20, 0, 5, 5),
                                    hintText: "Business Services, Communication Services, Health Services, etc",
                                    hintStyle: const TextStyle(
                                      fontSize: 20.0,
                                      // fontWeight: FontWeight.normal,
                                      color: Color(0xFFD1D1D1),
                                      letterSpacing: -0.5
                                    ),
                                  ),
                                  onChanged: (value) => {_category = value.toString()},
                                ),
                              ),
                              Text("Description",style: Theme.of(context).textTheme.titleLarge),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0, bottom: 16),
                                child: TextFormField(
                                  controller: _description_t,
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
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                                    contentPadding: const EdgeInsets.fromLTRB(20, 0, 5, 5),
                                    hintText: "Service Info",
                                    hintStyle: const TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.normal,
                                      color: Color(0xFFD1D1D1),
                                      letterSpacing: -0.5
                                    ),
                                  ),
                                  validator: (val) {
                                    if (val!.isEmpty) {
                                      return "Enter Description";
                                    }
                                    if (val.length > 450) {
                                      return "Enter less than 450 characters";
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              Text("Phone Number", style: Theme.of(context).textTheme.titleLarge),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0, bottom: 16),
                                child: TextFormField(
                                  controller: _phoneNo_t,
                                  style: const TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.normal,
                                    color: Color(0xFF333333),
                                    letterSpacing: -0.5
                                  ),
                                  cursorColor: const Color(0xFF333333),
                                  keyboardType: TextInputType.phone,
                                  textInputAction: TextInputAction.next,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                                    contentPadding: const EdgeInsets.fromLTRB(20, 0, 5, 5),
                                    hintText: "Phone Number",
                                    hintStyle: const TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.normal,
                                      color: Color(0xFFD1D1D1),
                                      letterSpacing: -0.5
                                    ),
                                  ),
                                  validator: (val) {
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
                              Text(
                                "Email",
                                style: Theme.of(context).textTheme.titleLarge
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0, bottom: 16),
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
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                                    contentPadding: const EdgeInsets.fromLTRB(20, 0, 5, 5),
                                    hintText: "someone@example.com",
                                    hintStyle: const TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.normal,
                                      color: Color(0xFFD1D1D1),
                                      letterSpacing: -0.5
                                    ),
                                  ),
                                  validator: (val) {
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
                              Text("Working Hours", style: Theme.of(context).textTheme.titleLarge),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Row(
                                  children: [
                                    Text(
                                      " Sunday : ",
                                      style: Theme.of(context).textTheme.titleMedium,
                                    ),
                                    Expanded(
                                      child: TextFormField(
                                        controller: _timeinput_sun1,
                                        style: const TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.normal,
                                          color: Color(0xFF333333),
                                          letterSpacing: -0.5
                                        ),
                                        cursorColor: const Color(0xFF333333),
                                        keyboardType: TextInputType.datetime,
                                        readOnly: true,
                                        textInputAction: TextInputAction.next,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                                          contentPadding: const EdgeInsets.fromLTRB(20, 0, 5, 5),
                                        ),
                                        onTap: () async {
                                          TimeOfDay? pickedTime = await showTimePicker(
                                            initialTime: TimeOfDay.now(),
                                            context: context,
                                          );
                                          if (pickedTime != null) {
                                            DateTime parsedTime = DateFormat.jm().parse(pickedTime.format(context).toString());
                                            String formattedTime = DateFormat('HH:mm:ss').format(parsedTime);
                            
                                            setState(() {
                                              _timeinput_sun1.text = formattedTime; //set the value of text field.
                                            });
                                          }
                                        },
                                      ),
                                    ),
                                    Text(
                                      " , to ",
                                      style: Theme.of(context).textTheme.titleMedium,
                                    ),
                                    Expanded(
                                      child: TextFormField(
                                        controller: _timeinput_sun2,
                                        style: const TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.normal,
                                          color: Color(0xFF333333),
                                          letterSpacing: -0.5
                                        ),
                                        cursorColor: const Color(0xFF333333),
                                        keyboardType: TextInputType.datetime,
                                        readOnly: true,
                                        textInputAction: TextInputAction.next,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                                          contentPadding:const EdgeInsets.fromLTRB(20, 0, 5, 5),
                                        ),
                                        onTap: () async {
                                          TimeOfDay? pickedTime = await showTimePicker(
                                            initialTime: TimeOfDay.now(),
                                            context: context,
                                          );
                                          if (pickedTime != null) {
                                            DateTime parsedTime = DateFormat.jm().parse(pickedTime.format(context).toString());
                                            String formattedTime =DateFormat('HH:mm:ss').format(parsedTime);
                            
                                            setState(() {
                                              _timeinput_sun2.text = formattedTime; //set the value of text field.
                                            });
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Row(
                                  children: [
                                    Text(
                                      " Monday : ",
                                      style: Theme.of(context).textTheme.titleMedium,
                                    ),
                                    Expanded(
                                      child: TextFormField(
                                        controller: _timeinput_mon1,
                                        style: const TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.normal,
                                          color: Color(0xFF333333),
                                          letterSpacing: -0.5
                                        ),
                                        cursorColor: const Color(0xFF333333),
                                        keyboardType: TextInputType.datetime,
                                        readOnly: true,
                                        textInputAction: TextInputAction.next,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(borderRadius:BorderRadius.circular(10.0)),
                                          contentPadding:const EdgeInsets.fromLTRB(20, 0, 5, 5),
                                        ),
                                        onTap: () async {
                                          TimeOfDay? pickedTime = await showTimePicker(
                                            initialTime: TimeOfDay.now(),
                                            context: context,
                                          );
                                          if (pickedTime != null) {
                                            DateTime parsedTime = DateFormat.jm().parse(pickedTime.format(context).toString());
                                            String formattedTime = DateFormat('HH:mm:ss').format(parsedTime);
                            
                                            setState(() {
                                              _timeinput_mon1.text = formattedTime; //set the value of text field.
                                            });
                                          }
                                        },
                                      ),
                                    ),
                                    Text(
                                      " , to ",
                                      style: Theme.of(context).textTheme.titleMedium,
                                    ),
                                    Expanded(
                                      child: TextFormField(
                                        controller: _timeinput_mon2,
                                        style: const TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.normal,
                                          color: Color(0xFF333333),
                                          letterSpacing: -0.5
                                        ),
                                        cursorColor: const Color(0xFF333333),
                                        keyboardType: TextInputType.datetime,
                                        readOnly: true,
                                        textInputAction: TextInputAction.next,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                                          contentPadding:const EdgeInsets.fromLTRB(20, 0, 5, 5),
                                        ),
                                        onTap: () async {
                                          TimeOfDay? pickedTime = await showTimePicker(
                                            initialTime: TimeOfDay.now(),
                                            context: context,
                                          );
                                          if (pickedTime != null) {
                                            DateTime parsedTime = DateFormat.jm().parse(pickedTime.format(context).toString());
                                            String formattedTime = DateFormat('HH:mm:ss').format(parsedTime);
                            
                                            setState(() {
                                              _timeinput_mon2.text = formattedTime; //set the value of text field.
                                            });
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Row(
                                  children: [
                                    Text(
                                      " Tuesday : ",
                                      style: Theme.of(context).textTheme.titleMedium,
                                    ),
                                    Expanded(
                                      child: TextFormField(
                                        controller: _timeinput_tue1,
                                        style: const TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.normal,
                                          color: Color(0xFF333333),
                                          letterSpacing: -0.5
                                        ),
                                        cursorColor: const Color(0xFF333333),
                                        keyboardType: TextInputType.datetime,
                                        readOnly: true,
                                        textInputAction: TextInputAction.next,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                                          contentPadding: const EdgeInsets.fromLTRB(20, 0, 5, 5),
                                        ),
                                        onTap: () async {
                                          TimeOfDay? pickedTime = await showTimePicker(
                                            initialTime: TimeOfDay.now(),
                                            context: context,
                                          );
                                          if (pickedTime != null) {
                                            DateTime parsedTime = DateFormat.jm().parse(pickedTime.format(context).toString());
                                            String formattedTime = DateFormat('HH:mm:ss').format(parsedTime);
                            
                                            setState(() {
                                              _timeinput_tue1.text = formattedTime; //set the value of text field.
                                            });
                                          }
                                        },
                                      ),
                                    ),
                                    Text(
                                      " , to ",
                                      style: Theme.of(context).textTheme.titleMedium,
                                    ),
                                    Expanded(
                                      child: TextFormField(
                                        controller: _timeinput_tue2,
                                        style: const TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.normal,
                                          color: Color(0xFF333333),
                                          letterSpacing: -0.5
                                        ),
                                        cursorColor: const Color(0xFF333333),
                                        keyboardType: TextInputType.datetime,
                                        readOnly: true,
                                        textInputAction: TextInputAction.next,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                                          contentPadding: const EdgeInsets.fromLTRB(20, 0, 5, 5),
                                        ),
                                        onTap: () async {
                                          TimeOfDay? pickedTime = await showTimePicker(
                                            initialTime: TimeOfDay.now(),
                                            context: context,
                                          );
                                          if (pickedTime != null) {
                                            DateTime parsedTime = DateFormat.jm().parse(pickedTime.format(context).toString());
                                            String formattedTime = DateFormat('HH:mm:ss').format(parsedTime);
                            
                                            setState(() {
                                              _timeinput_tue2.text = formattedTime; //set the value of text field.
                                            });
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Row(
                                  children: [
                                    Text(
                                      " Wednesday : ",
                                      style: Theme.of(context).textTheme.titleMedium,
                                    ),
                                    Expanded(
                                      child: TextFormField(
                                        controller: _timeinput_wed1,
                                        style: const TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.normal,
                                          color: Color(0xFF333333),
                                          letterSpacing: -0.5
                                        ),
                                        cursorColor: const Color(0xFF333333),
                                        keyboardType: TextInputType.datetime,
                                        readOnly: true,
                                        textInputAction: TextInputAction.next,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(borderRadius:BorderRadius.circular(10.0)),
                                          contentPadding:const EdgeInsets.fromLTRB(20, 0, 5, 5),
                                        ),
                                        onTap: () async {
                                          TimeOfDay? pickedTime = await showTimePicker(
                                            initialTime: TimeOfDay.now(),
                                            context: context,
                                          );
                                          if (pickedTime != null) {
                                            DateTime parsedTime = DateFormat.jm().parse(pickedTime.format(context).toString());
                                            String formattedTime = DateFormat('HH:mm:ss').format(parsedTime);
                            
                                            setState(() {
                                              _timeinput_wed1.text = formattedTime; //set the value of text field.
                                            });
                                          }
                                        },
                                      ),
                                    ),
                                    Text(
                                      " , to ",
                                      style:
                                          Theme.of(context).textTheme.titleMedium,
                                    ),
                                    Expanded(
                                      child: TextFormField(
                                        controller: _timeinput_wed2,
                                        style: const TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.normal,
                                          color: Color(0xFF333333),
                                          letterSpacing: -0.5
                                        ),
                                        cursorColor: const Color(0xFF333333),
                                        keyboardType: TextInputType.datetime,
                                        readOnly: true,
                                        textInputAction: TextInputAction.next,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                                          contentPadding:const EdgeInsets.fromLTRB(20, 0, 5, 5),
                                        ),
                                        onTap: () async {
                                          TimeOfDay? pickedTime = await showTimePicker(
                                            initialTime: TimeOfDay.now(),
                                            context: context,
                                          );
                                          if (pickedTime != null) {
                                            DateTime parsedTime = DateFormat.jm().parse(pickedTime.format(context).toString());
                                            String formattedTime = DateFormat('HH:mm:ss').format(parsedTime);
                            
                                            setState(() {
                                              _timeinput_wed2.text = formattedTime; //set the value of text field.
                                            });
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Row(
                                  children: [
                                    Text(
                                      " Thursday : ",
                                      style: Theme.of(context).textTheme.titleMedium,
                                    ),
                                    Expanded(
                                      child: TextFormField(
                                        controller: _timeinput_thu1,
                                        style: const TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.normal,
                                          color: Color(0xFF333333),
                                          letterSpacing: -0.5
                                        ),
                                        cursorColor: const Color(0xFF333333),
                                        keyboardType: TextInputType.datetime,
                                        readOnly: true,
                                        textInputAction: TextInputAction.next,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                                          contentPadding: const EdgeInsets.fromLTRB(20, 0, 5, 5),
                                        ),
                                        onTap: () async {
                                          TimeOfDay? pickedTime = await showTimePicker(
                                            initialTime: TimeOfDay.now(),
                                            context: context,
                                          );
                                          if (pickedTime != null) {
                                            DateTime parsedTime = DateFormat.jm().parse(pickedTime.format(context).toString());
                                            String formattedTime = DateFormat('HH:mm:ss').format(parsedTime);
                            
                                            setState(() {
                                              _timeinput_thu1.text = formattedTime; //set the value of text field.
                                            });
                                          }
                                        },
                                      ),
                                    ),
                                    Text(
                                      " , to ",
                                      style: Theme.of(context).textTheme.titleMedium,
                                    ),
                                    Expanded(
                                      child: TextFormField(
                                        controller: _timeinput_thu2,
                                        style: const TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.normal,
                                          color: Color(0xFF333333),
                                          letterSpacing: -0.5
                                        ),
                                        cursorColor: const Color(0xFF333333),
                                        keyboardType: TextInputType.datetime,
                                        readOnly: true,
                                        textInputAction: TextInputAction.next,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                                          contentPadding: const EdgeInsets.fromLTRB(20, 0, 5, 5),
                                        ),
                                        onTap: () async {
                                          TimeOfDay? pickedTime = await showTimePicker(
                                            initialTime: TimeOfDay.now(),
                                            context: context,
                                          );
                                          if (pickedTime != null) {
                                            DateTime parsedTime = DateFormat.jm().parse(pickedTime.format(context).toString());
                                            String formattedTime = DateFormat('HH:mm:ss').format(parsedTime);
                            
                                            setState(() {
                                              _timeinput_thu2.text = formattedTime; //set the value of text field.
                                            });
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Row(
                                  children: [
                                    Text(
                                      " Friday : ",
                                      style: Theme.of(context).textTheme.titleMedium,
                                    ),
                                    Expanded(
                                      child: TextFormField(
                                        controller: _timeinput_fri1,
                                        style: const TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.normal,
                                          color: Color(0xFF333333),
                                          letterSpacing: -0.5
                                        ),
                                        cursorColor: const Color(0xFF333333),
                                        keyboardType: TextInputType.datetime,
                                        readOnly: true,
                                        textInputAction: TextInputAction.next,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                                          contentPadding: const EdgeInsets.fromLTRB(20, 0, 5, 5),
                                        ),
                                        onTap: () async {
                                          TimeOfDay? pickedTime = await showTimePicker(
                                            initialTime: TimeOfDay.now(),
                                            context: context,
                                          );
                                          if (pickedTime != null) {
                                            DateTime parsedTime = DateFormat.jm().parse(pickedTime.format(context).toString());
                                            String formattedTime = DateFormat('HH:mm:ss').format(parsedTime);
                            
                                            setState(() {
                                              _timeinput_fri1.text = formattedTime; //set the value of text field.
                                            });
                                          }
                                        },
                                      ),
                                    ),
                                    Text(
                                      " , to ",
                                      style: Theme.of(context).textTheme.titleMedium,
                                    ),
                                    Expanded(
                                      child: TextFormField(
                                        controller: _timeinput_fri2,
                                        style: const TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.normal,
                                          color: Color(0xFF333333),
                                          letterSpacing: -0.5
                                        ),
                                        cursorColor: const Color(0xFF333333),
                                        keyboardType: TextInputType.datetime,
                                        readOnly: true,
                                        textInputAction: TextInputAction.next,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                                          contentPadding: const EdgeInsets.fromLTRB(20, 0, 5, 5),
                                        ),
                                        onTap: () async {
                                          TimeOfDay? pickedTime = await showTimePicker(
                                            initialTime: TimeOfDay.now(),
                                            context: context,
                                          );
                                          if (pickedTime != null) {
                                            DateTime parsedTime = DateFormat.jm().parse(pickedTime.format(context).toString());
                                            String formattedTime = DateFormat('HH:mm:ss').format(parsedTime);
                            
                                            setState(() {
                                              _timeinput_fri2.text = formattedTime; //set the value of text field.
                                            });
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Row(
                                  children: [
                                    Text(
                                      " Saturday : ",
                                      style: Theme.of(context).textTheme.titleMedium,
                                    ),
                                    Expanded(
                                      child: TextFormField(
                                        controller: _timeinput_sat1,
                                        style: const TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.normal,
                                          color: Color(0xFF333333),
                                          letterSpacing: -0.5
                                        ),
                                        cursorColor: const Color(0xFF333333),
                                        keyboardType: TextInputType.datetime,
                                        readOnly: true,
                                        textInputAction: TextInputAction.next,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                                          contentPadding: const EdgeInsets.fromLTRB(20, 0, 5, 5),
                                        ),
                                        onTap: () async {
                                          TimeOfDay? pickedTime = await showTimePicker(
                                            initialTime: TimeOfDay.now(),
                                            context: context,
                                          );
                                          if (pickedTime != null) {
                                            DateTime parsedTime = DateFormat.jm().parse(pickedTime.format(context).toString());
                                            String formattedTime = DateFormat('HH:mm:ss').format(parsedTime);
                            
                                            setState(() {
                                              _timeinput_sat1.text = formattedTime; //set the value of text field.
                                            });
                                          }
                                        },
                                      ),
                                    ),
                                    Text(
                                      " , to ",
                                      style: Theme.of(context).textTheme.titleMedium,
                                    ),
                                    Expanded(
                                      child: TextFormField(
                                        controller: _timeinput_sat2,
                                        style: const TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.normal,
                                          color: Color(0xFF333333),
                                          letterSpacing: -0.5
                                        ),
                                        cursorColor: const Color(0xFF333333),
                                        keyboardType: TextInputType.datetime,
                                        readOnly: true,
                                        textInputAction: TextInputAction.next,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                                          contentPadding: const EdgeInsets.fromLTRB(20, 0, 5, 5),
                                        ),
                                        onTap: () async {
                                          TimeOfDay? pickedTime = await showTimePicker(
                                            initialTime: TimeOfDay.now(),
                                            context: context,
                                          );
                                          if (pickedTime != null) {
                                            DateTime parsedTime = DateFormat.jm().parse(pickedTime.format(context).toString());
                                            String formattedTime = DateFormat('HH:mm:ss').format(parsedTime);
                            
                                            setState(() {
                                              _timeinput_sat2.text = formattedTime; //set the value of text field.
                                            });
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Divider(),
                              Text("Services",
                                  style: Theme.of(context).textTheme.titleLarge),
                              ..._getServices(),
                              const Divider(),
                              Text("Add Location", style: Theme.of(context).textTheme.titleLarge),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Stack(
                                  children: [
                                    SizedBox(
                                      height: 300,
                                      width: double.infinity,
                                      child: GoogleMap(
                                        mapType: MapType.normal,
                                        initialCameraPosition: CameraPosition(
                                          target: LatLng(widget.latitude, widget.longitude),
                                          zoom: 14,
                                        ),
                                        onMapCreated: (GoogleMapController controller) {
                                          googleMapController = controller;
                                        },
                                        myLocationButtonEnabled: true,
                                        compassEnabled: true,
                                        zoomControlsEnabled: true,
                                        scrollGesturesEnabled: true,
                                        zoomGesturesEnabled: true,
                                        gestureRecognizers: Set()..add(Factory<PanGestureRecognizer>(() => PanGestureRecognizer())),
                                      ),
                                    ),
                                    const Positioned(
                                      top: 142,
                                      left: 150,
                                      child: Icon(
                                        Icons.circle_sharp,
                                        color: Colors.blue,
                                      )
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 28.0, bottom: 15.0),
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
                                          child: Center(
                                            child: Text((widget.update)? "UPDATE SERVICE": "ADD SERVICE",
                                              style: const TextStyle(
                                                fontSize: 20,
                                                color: Color(0xFFFFFFFF),
                                                fontWeight: FontWeight.bold
                                              ),
                                            ),
                                          ),
                                        ),
                                        onTap: () async {
                                          // FirebaseService service = new FirebaseService();
                                          if (_formKey.currentState!.validate() && _category != "" && _myUser != null) {
                                            double screenWidth = MediaQuery.of(context).size.width * MediaQuery.of(context).devicePixelRatio;
                            
                                            double middleX = (screenWidth / 2);
                                            double middleY = 150;
                            
                                            ScreenCoordinate screenCoordinate = ScreenCoordinate(x: middleX.round(), y: middleY.round());
                            
                                            LatLng middlePoint = await googleMapController.getLatLng(screenCoordinate);
                            
                                            String userId = _myUser.uid;
                                            DataRepository repository = DataRepository();
                                            List rating = [0, 0, 0, 0, 0, 0];
                                            servicesList = [];
                                            for (int i = 0;i < serviceNameList.length; i++) {
                                              servicesList.add({
                                                "productName": serviceNameList.toList()[i],
                                                "cost": serviceCostList.toList()[i],
                                              });
                                            }
                                            searchKeywords = [];
                                            String temp = "";
                                            for (int i = 0; i < _service_name_t.text.length; i++) {
                                              temp = temp + _service_name_t.text[i];
                                              temp = temp.toLowerCase();
                                              searchKeywords.add(temp);
                                            }
                                            if (widget.update) {
                                              repository.ss_services_collection.doc(widget.updateData.id).update({
                                                "name": _service_name_t.text,
                                                "address": _address_t.text,
                                                "category": _category,
                                                "workingHours": [
                                                  _timeinput_sun1.text,
                                                  _timeinput_sun2.text,
                                                  _timeinput_mon1.text,
                                                  _timeinput_mon2.text,
                                                  _timeinput_tue1.text,
                                                  _timeinput_tue2.text,
                                                  _timeinput_wed1.text,
                                                  _timeinput_wed2.text,
                                                  _timeinput_thu1.text,
                                                  _timeinput_thu2.text,
                                                  _timeinput_fri1.text,
                                                  _timeinput_fri2.text,
                                                  _timeinput_sat1.text,
                                                  _timeinput_sat2.text
                                                ],
                                                "description": _description_t.text,
                                                "phoneNo": _phoneNo_t.text,
                                                "email": _email_t.text,
                                                "latitute": middlePoint.latitude,
                                                "longitude": middlePoint.longitude,
                                                "services": servicesList,
                                                "searchKeywords": searchKeywords,
                                              }).then((value) {
                                                // print(value);
                                                showDialog(
                                                  context: context,
                                                  builder: (BuildContext builderContext) {
                                                    return AlertDialog(
                                                      title: const Text("Sucessfully updated your Service"),
                                                      content: Text(widget.updateData.id),
                                                      actions: [
                                                        TextButton(
                                                          child:const Text("Ok"),
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
                                            } else {
                                              repository.ss_services_collection.add({
                                                "businessId": userId,
                                                "name": _service_name_t.text,
                                                "address": _address_t.text,
                                                "category": _category,
                                                "workingHours": [
                                                  _timeinput_sun1.text,
                                                  _timeinput_sun2.text,
                                                  _timeinput_mon1.text,
                                                  _timeinput_mon2.text,
                                                  _timeinput_tue1.text,
                                                  _timeinput_tue2.text,
                                                  _timeinput_wed1.text,
                                                  _timeinput_wed2.text,
                                                  _timeinput_thu1.text,
                                                  _timeinput_thu2.text,
                                                  _timeinput_fri1.text,
                                                  _timeinput_fri2.text,
                                                  _timeinput_sat1.text,
                                                  _timeinput_sat2.text
                                                ],
                                                "description": _description_t.text,
                                                "phoneNo": _phoneNo_t.text,
                                                "email": _email_t.text,
                                                "latitute": middlePoint.latitude,
                                                "longitude": middlePoint.longitude,
                                                "rating": rating,
                                                "contacted": 0,
                                                "joined": Timestamp.now(),
                                                "reviews": reviews,
                                                "reviewsCount": 0,
                                                "services": servicesList,
                                                "searchKeywords": searchKeywords,
                                              }).then((value) {
                                                // print(value);
                                                showDialog(
                                                  context: context,
                                                  builder: (BuildContext builderContext) {
                                                    return AlertDialog(
                                                      title: const Text("Sucessfully added your Service"),
                                                      content: Text(value.id),
                                                      actions: [
                                                        TextButton(
                                                          child:const Text("Ok"),
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
                                            }
                                          } else {
                                            // print(_myUser);
                                          }
                                        }
                                      )
                                  ],
                                ),
                              ),
                            ],
                          ),
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
      ),
      //Floating Buttons
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            if (widget.isLeftFloattingButton)
              FloatingActionButton(
                heroTag: "add service left",
                mini: true,
                onPressed: widget._left,
                child: widget.leftIcon,
              ),
            if (widget.isRightFloattingButton)
              FloatingActionButton(
                heroTag: "add service right",
                mini: true,
                onPressed: widget._right,
                child: widget.rightIcon,
              ),
          ]
        ),
      )
    );
  }

  List<Widget> _getServices() {
    List<Widget> productTextFields = [];
    for (int i = 0; i < serviceCostList.length; i++) {
      productTextFields.add(
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Row(
            children: [
              Text(
                " Name ",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Expanded(
                flex: 3,
                child: ProductNameTextField(i),
              ),
              Text(
                " cost ",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Expanded(
                flex: 2,
                child: ProductCostTextField(i),
              ),
              const SizedBox(
                width: 5,
              ),
              _addRemoveButton(i == serviceCostList.length - 1, i)
            ],
          ),
        ),
      );
    }
    return productTextFields;
  }

  Widget _addRemoveButton(bool add, int index) {
    return InkWell(
      onTap: () {
        if (add) {
          serviceNameList.insert(0, null);
          serviceCostList.insert(0, null);
        } else {
          serviceNameList.removeAt(index);
          serviceCostList.removeAt(index);
        }
        setState(() {});
      },
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: (add) ? Colors.green : Colors.red,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Icon(
          (add) ? Icons.add : Icons.remove,
          color: Colors.white,
        ),
      ),
    );
  }
}

class ProductNameTextField extends StatefulWidget {
  final int index;
  const ProductNameTextField(this.index, {Key? key}) : super(key: key);

  @override
  State<ProductNameTextField> createState() => _ProductNameTextFieldState();
}

class _ProductNameTextFieldState extends State<ProductNameTextField> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _controller.text = _AddServiceState.serviceNameList[widget.index] ?? '';
    });

    return TextFormField(
      controller: _controller,
      onChanged: (v) => _AddServiceState.serviceNameList[widget.index] = v,
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
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
        contentPadding: const EdgeInsets.fromLTRB(20, 0, 5, 5),
      ),
      // onTap: () async {

      // },
      validator: (v) {
        if (v!.trim().isEmpty) return 'Please enter something';
        return null;
      },
    );
  }
}

class ProductCostTextField extends StatefulWidget {
  final int index;
  const ProductCostTextField(this.index, {Key? key}) : super(key: key);

  @override
  State<ProductCostTextField> createState() => _ProductCostTextFieldState();
}

class _ProductCostTextFieldState extends State<ProductCostTextField> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _controller.text = _AddServiceState.serviceCostList[widget.index] ?? '';
    });

    return TextFormField(
      controller: _controller,
      onChanged: (v) => _AddServiceState.serviceCostList[widget.index] = v,
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
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
        contentPadding: const EdgeInsets.fromLTRB(20, 0, 5, 5),
      ),
      // onTap: () async {

      // },
      validator: (v) {
        if (v!.trim().isEmpty) return 'Please enter something';
        return null;
      },
    );
  }
}
