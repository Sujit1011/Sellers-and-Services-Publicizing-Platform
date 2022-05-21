import 'package:cloud_firestore/cloud_firestore.dart' show Timestamp;
import 'package:flutter/material.dart' show AlertDialog, BorderRadius, BoxDecoration, BuildContext, Center, CircleAvatar, Color, Colors, Column, Container, CrossAxisAlignment, Divider, DropdownButtonFormField, DropdownMenuItem, EdgeInsets, Expanded, FloatingActionButton, FloatingActionButtonLocation, FontWeight, Form, FormState, GlobalKey, Icon, Icons, InkWell, InputDecoration, Key, MainAxisAlignment, Navigator, OutlineInputBorder, Padding, Row, Scaffold, SingleChildScrollView, SizedBox, Spacer, Stack, State, StatefulWidget, Text, TextButton, TextEditingController, TextFormField, TextInputAction, TextInputType, TextStyle, Theme, TimeOfDay, Widget, WidgetsBinding, showDialog, showTimePicker;
import 'package:intl/intl.dart' show DateFormat;
import 'package:provider/provider.dart' show Provider;
import 'package:shosev/models/SS_User.dart' show SS_User;
import 'package:shosev/services/data_repository.dart' show DataRepository;


class AddService extends StatefulWidget {

  final String username;
  final String phoneNo;
  final String title;
  final bool isLeftFloattingButton;
  final bool isRightFloattingButton;
  final Icon leftIcon;
  final Icon rightIcon;

  final Function leftClick;
  final Function rightClick;

  const AddService(
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
      required this.rightIcon
    }
  ): super(key: key);

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
                          Text("Service Name", style: Theme.of(context).textTheme.headline4),
                          Padding(
                            padding: const EdgeInsets.only(top:8.0, bottom: 16),
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
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0)
                                ),
                                contentPadding: const EdgeInsets.fromLTRB(20, 0, 5, 5),
                                hintText: "ABC Service",
                                hintStyle: const TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.normal,
                                  color: Color(0xFFD1D1D1),
                                  letterSpacing: -0.5
                                ),
                              ),
                              validator: (val){
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
                          Text("Address", style: Theme.of(context).textTheme.headline4),
                          Padding(
                            padding: const EdgeInsets.only(top:8.0, bottom: 16),
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
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0)
                                ),
                                contentPadding: const EdgeInsets.fromLTRB(20, 0, 5, 5),
                                hintText: "XYZ Place, XYZ Street, near XYZ, State pincode",
                                hintStyle: const TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.normal,
                                  color: Color(0xFFD1D1D1),
                                  letterSpacing: -0.5
                                ),
                              ),
                              validator: (val){
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
                          Text("Category", style: Theme.of(context).textTheme.headline4),
                          Padding(
                            padding: const EdgeInsets.only(top:8.0, bottom: 16),
                            child: DropdownButtonFormField(
                              items: const [
                                DropdownMenuItem(child: Text("Business Services", ), value: "Business Services"),
                                DropdownMenuItem(child: Text("Communication Services"), value: "Communication Services"),
                                DropdownMenuItem(child: Text("Construction & Engineering",), value: "Construction & Engineering"),
                                DropdownMenuItem(child: Text("Distribution Services"), value: "Distribution Services"),
                                DropdownMenuItem(child: Text("Education"), value: "Education"),
                                DropdownMenuItem(child: Text("Environment Services"), value: "Environment Services"),
                                DropdownMenuItem(child: Text("Finance service"), value: "Finance service"),
                                DropdownMenuItem(child: Text("Tourism Services"), value: "Tourism Services"),
                                DropdownMenuItem(child: Text("Health Services"), value: "Health Services"),
                                DropdownMenuItem(child: Text("Recreation Services"), value: "Recreation Services"),
                                DropdownMenuItem(child: Text("Transportation Services"), value: "Transportation Services"),
                              ],
                    
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
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0)
                                ),
                                contentPadding: const EdgeInsets.fromLTRB(20, 0, 5, 5),
                                hintText: "Business Services, Communication Services, Health Services, etc",
                                hintStyle: const TextStyle(
                                  fontSize: 20.0,
                                  // fontWeight: FontWeight.normal,
                                  color: Color(0xFFD1D1D1),
                                  letterSpacing: -0.5
                                ),
                              ),
                              onChanged: (value) => {
                                _category = value.toString()
                              },
                            ),
                          ),
                          Text("Description", style: Theme.of(context).textTheme.headline4),
                          Padding(
                            padding: const EdgeInsets.only(top:8.0, bottom: 16),
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
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0)
                                ),
                                contentPadding: const EdgeInsets.fromLTRB(20, 0, 5, 5),
                                hintText: "Service Info",
                                hintStyle: const TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.normal,
                                  color: Color(0xFFD1D1D1),
                                  letterSpacing: -0.5
                                ),
                              ),
                              validator: (val){
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
                          Text("Phone Number", style: Theme.of(context).textTheme.headline4),
                          Padding(
                            padding: const EdgeInsets.only(top:8.0, bottom: 16),
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
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0)
                                ),
                                contentPadding: const EdgeInsets.fromLTRB(20, 0, 5, 5),
                                hintText: "Phone Number",
                                hintStyle: const TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.normal,
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
                          Text("Working Hours", style: Theme.of(context).textTheme.headline4),
                          Padding(
                            padding: const EdgeInsets.only(top:8.0),
                            child: Row(
                              children: [
                                Text(" Sunday : ", style: Theme.of(context).textTheme.headline4,),
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
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10.0)
                                      ),
                                      contentPadding: const EdgeInsets.fromLTRB(20, 0, 5, 5),
                                    ),
                                    onTap: () async {
                                      TimeOfDay? pickedTime =  await showTimePicker(
                                        initialTime: TimeOfDay.now(),
                                        context: context,
                                      );
                                      if(pickedTime != null ){
                                        DateTime parsedTime = DateFormat.jm().parse(pickedTime.format(context).toString());
                                        String formattedTime = DateFormat('HH:mm:ss').format(parsedTime);
                    
                                        setState(() {
                                          _timeinput_sun1.text = formattedTime; //set the value of text field. 
                                        });
                                      }
                                    },
                                  ),
                                ),
                                Text(" , to ", style: Theme.of(context).textTheme.headline4,),
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
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10.0)
                                      ),
                                      contentPadding: const EdgeInsets.fromLTRB(20, 0, 5, 5),
                                    ),
                                    onTap: () async {
                                      TimeOfDay? pickedTime =  await showTimePicker(
                                        initialTime: TimeOfDay.now(),
                                        context: context,
                                      );
                                      if(pickedTime != null ){
                                        DateTime parsedTime = DateFormat.jm().parse(pickedTime.format(context).toString());
                                        String formattedTime = DateFormat('HH:mm:ss').format(parsedTime);
                    
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
                            padding: const EdgeInsets.only(top:8.0),
                            child: Row(
                              children: [
                                Text(" Monday : ", style: Theme.of(context).textTheme.headline4,),
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
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10.0)
                                      ),
                                      contentPadding: const EdgeInsets.fromLTRB(20, 0, 5, 5),
                                    ),
                                    onTap: () async {
                                      TimeOfDay? pickedTime =  await showTimePicker(
                                        initialTime: TimeOfDay.now(),
                                        context: context,
                                      );
                                      if(pickedTime != null ){
                                        DateTime parsedTime = DateFormat.jm().parse(pickedTime.format(context).toString());
                                        String formattedTime = DateFormat('HH:mm:ss').format(parsedTime);
                    
                                        setState(() {
                                          _timeinput_mon1.text = formattedTime; //set the value of text field. 
                                        });
                                      }
                                    },
                                  ),
                                ),
                                Text(" , to ", style: Theme.of(context).textTheme.headline4,),
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
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10.0)
                                      ),
                                      contentPadding: const EdgeInsets.fromLTRB(20, 0, 5, 5),
                                    ),
                                    onTap: () async {
                                      TimeOfDay? pickedTime =  await showTimePicker(
                                        initialTime: TimeOfDay.now(),
                                        context: context,
                                      );
                                      if(pickedTime != null ){
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
                            padding: const EdgeInsets.only(top:8.0),
                            child: Row(
                              children: [
                                Text(" Tuesday : ", style: Theme.of(context).textTheme.headline4,),
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
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10.0)
                                      ),
                                      contentPadding: const EdgeInsets.fromLTRB(20, 0, 5, 5),
                                    ),
                                    onTap: () async {
                                      TimeOfDay? pickedTime =  await showTimePicker(
                                        initialTime: TimeOfDay.now(),
                                        context: context,
                                      );
                                      if(pickedTime != null ){
                                        DateTime parsedTime = DateFormat.jm().parse(pickedTime.format(context).toString());
                                        String formattedTime = DateFormat('HH:mm:ss').format(parsedTime);
                    
                                        setState(() {
                                          _timeinput_tue1.text = formattedTime; //set the value of text field. 
                                        });
                                      }
                                    },
                                  ),
                                ),
                                Text(" , to ", style: Theme.of(context).textTheme.headline4,),
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
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10.0)
                                      ),
                                      contentPadding: const EdgeInsets.fromLTRB(20, 0, 5, 5),
                                    ),
                                    onTap: () async {
                                      TimeOfDay? pickedTime =  await showTimePicker(
                                        initialTime: TimeOfDay.now(),
                                        context: context,
                                      );
                                      if(pickedTime != null ){
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
                            padding: const EdgeInsets.only(top:8.0),
                            child: Row(
                              children: [
                                Text(" Wednesday : ", style: Theme.of(context).textTheme.headline4,),
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
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10.0)
                                      ),
                                      contentPadding: const EdgeInsets.fromLTRB(20, 0, 5, 5),
                                    ),
                                    onTap: () async {
                                      TimeOfDay? pickedTime =  await showTimePicker(
                                        initialTime: TimeOfDay.now(),
                                        context: context,
                                      );
                                      if(pickedTime != null ){
                                        DateTime parsedTime = DateFormat.jm().parse(pickedTime.format(context).toString());
                                        String formattedTime = DateFormat('HH:mm:ss').format(parsedTime);
                    
                                        setState(() {
                                          _timeinput_wed1.text = formattedTime; //set the value of text field. 
                                        });
                                      }
                                    },
                                  ),
                                ),
                                Text(" , to ", style: Theme.of(context).textTheme.headline4,),
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
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10.0)
                                      ),
                                      contentPadding: const EdgeInsets.fromLTRB(20, 0, 5, 5),
                                    ),
                                    onTap: () async {
                                      TimeOfDay? pickedTime =  await showTimePicker(
                                        initialTime: TimeOfDay.now(),
                                        context: context,
                                      );
                                      if(pickedTime != null ){
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
                            padding: const EdgeInsets.only(top:8.0),
                            child: Row(
                              children: [
                                Text(" Thursday : ", style: Theme.of(context).textTheme.headline4,),
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
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10.0)
                                      ),
                                      contentPadding: const EdgeInsets.fromLTRB(20, 0, 5, 5),
                                    ),
                                    onTap: () async {
                                      TimeOfDay? pickedTime =  await showTimePicker(
                                        initialTime: TimeOfDay.now(),
                                        context: context,
                                      );
                                      if(pickedTime != null ){
                                        DateTime parsedTime = DateFormat.jm().parse(pickedTime.format(context).toString());
                                        String formattedTime = DateFormat('HH:mm:ss').format(parsedTime);
                    
                                        setState(() {
                                          _timeinput_thu1.text = formattedTime; //set the value of text field. 
                                        });
                                      }
                                    },
                                  ),
                                ),
                                Text(" , to ", style: Theme.of(context).textTheme.headline4,),
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
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10.0)
                                      ),
                                      contentPadding: const EdgeInsets.fromLTRB(20, 0, 5, 5),
                                    ),
                                    onTap: () async {
                                      TimeOfDay? pickedTime =  await showTimePicker(
                                        initialTime: TimeOfDay.now(),
                                        context: context,
                                      );
                                      if(pickedTime != null ){
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
                            padding: const EdgeInsets.only(top:8.0),
                            child: Row(
                              children: [
                                Text(" Friday : ", style: Theme.of(context).textTheme.headline4,),
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
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10.0)
                                      ),
                                      contentPadding: const EdgeInsets.fromLTRB(20, 0, 5, 5),
                                    ),
                                    onTap: () async {
                                      TimeOfDay? pickedTime =  await showTimePicker(
                                        initialTime: TimeOfDay.now(),
                                        context: context,
                                      );
                                      if(pickedTime != null ){
                                        DateTime parsedTime = DateFormat.jm().parse(pickedTime.format(context).toString());
                                        String formattedTime = DateFormat('HH:mm:ss').format(parsedTime);
                    
                                        setState(() {
                                          _timeinput_fri1.text = formattedTime; //set the value of text field. 
                                        });
                                      }
                                    },
                                  ),
                                ),
                                Text(" , to ", style: Theme.of(context).textTheme.headline4,),
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
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10.0)
                                      ),
                                      contentPadding: const EdgeInsets.fromLTRB(20, 0, 5, 5),
                                    ),
                                    onTap: () async {
                                      TimeOfDay? pickedTime =  await showTimePicker(
                                        initialTime: TimeOfDay.now(),
                                        context: context,
                                      );
                                      if(pickedTime != null ){
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
                            padding: const EdgeInsets.only(top:8.0),
                            child: Row(
                              children: [
                                Text(" Saturday : ", style: Theme.of(context).textTheme.headline4,),
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
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10.0)
                                      ),
                                      contentPadding: const EdgeInsets.fromLTRB(20, 0, 5, 5),
                                    ),
                                    onTap: () async {
                                      TimeOfDay? pickedTime =  await showTimePicker(
                                        initialTime: TimeOfDay.now(),
                                        context: context,
                                      );
                                      if(pickedTime != null ){
                                        DateTime parsedTime = DateFormat.jm().parse(pickedTime.format(context).toString());
                                        String formattedTime = DateFormat('HH:mm:ss').format(parsedTime);
                    
                                        setState(() {
                                          _timeinput_sat1.text = formattedTime; //set the value of text field. 
                                        });
                                      }
                                    },
                                  ),
                                ),
                                Text(" , to ", style: Theme.of(context).textTheme.headline4,),
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
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10.0)
                                      ),
                                      contentPadding: const EdgeInsets.fromLTRB(20, 0, 5, 5),
                                    ),
                                    onTap: () async {
                                      TimeOfDay? pickedTime =  await showTimePicker(
                                        initialTime: TimeOfDay.now(),
                                        context: context,
                                      );
                                      if(pickedTime != null ){
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
                          Text("Services", style: Theme.of(context).textTheme.headline4),
                          ..._getServices(),
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
                                        "ADD service",
                                        style: TextStyle(fontSize: 20, color: Color(0xFFFFFFFF), fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  onTap: () async {
                                    // FirebaseService service = new FirebaseService();
                                    if (_formKey.currentState!.validate() && _category != "" && _myUser != null) {
                                        String userId = _myUser.uid;
                                        DataRepository repository = DataRepository();
                                        List servicesList = [];
                                        for (int i = 0; i < serviceNameList.length; i++) {
                                          servicesList.add({
                                            "productName": serviceNameList.toList()[i],
                                            "cost": serviceCostList.toList()[i],
                                          });
                                        }
                                        List searchKeywords = [];
                                        String temp = "";
                                        for (int i = 0; i < _service_name_t.text.length; i++) {
                                          temp = temp + _service_name_t.text[i];
                                          searchKeywords.add(temp);
                                        }
                                        repository.ss_services_collection.add(
                                          {
                                            "businessId": userId,
                                            "name": _service_name_t.text,
                                            "address": _address_t.text,
                                            "category": _category,
                                            "workingHours": [ _timeinput_sun1.text, 
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
                                                              _timeinput_sat2.text],
                                            "description": _description_t.text,
                                            "phoneNo": _phoneNo_t.text,
                                            "email": _email_t.text,
                                            "latitute": 23.0,
                                            "longtitide": 23.0,
                                            "rating": 1.0,
                                            "contacted": 0,
                                            "joined": Timestamp.now(),
                                            "reviews": 0,
                                            "services" : servicesList,
                                            "searchKeywords" : searchKeywords,
                                          }
                                        ).then((value){ 
                                          print(value);
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext builderContext) {
                                              return AlertDialog(
                                                title: const Text("Sucessfully added your Service"),
                                                content: Text(value.id),
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

                                      } else {
                                        print(_myUser);
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
                heroTag: "add service left",
                mini: true,
                onPressed: widget._left,
                child: widget.leftIcon,
              ),
            if(widget.isRightFloattingButton)
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
    for(int i=0; i<serviceCostList.length; i++) {
      productTextFields.add(
        Padding(
          padding: const EdgeInsets.only(top:8.0),
          child: Row(
            children: [
              Text(" Name ", style: Theme.of(context).textTheme.headline4,),
              Expanded(
                flex: 3,
                child: ProductNameTextField(i),
              ),
              Text(" cost ", style: Theme.of(context).textTheme.headline4,),
              Expanded(
                flex: 2,
                child: ProductCostTextField(i),
              ),
              SizedBox(width: 5,),
              _addRemoveButton(i == serviceCostList.length-1, i)
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
        child: Icon((add) ? Icons.add : Icons.remove, color: Colors.white,),
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

    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
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
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0)
        ),
        contentPadding: const EdgeInsets.fromLTRB(20, 0, 5, 5),
      ),
      // onTap: () async {
        
      // },
      validator: (v){
        if(v!.trim().isEmpty) return 'Please enter something';
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

    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
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
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0)
        ),
        contentPadding: const EdgeInsets.fromLTRB(20, 0, 5, 5),
      ),
      // onTap: () async {
        
      // },
      validator: (v){
        if(v!.trim().isEmpty) return 'Please enter something';
        return null;
      },
    );
  }
}