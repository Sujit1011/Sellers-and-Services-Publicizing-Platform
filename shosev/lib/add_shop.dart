import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shosev/models/SS_User.dart';
import 'package:shosev/services/data_repository.dart';

import 'appbar.dart' as appbar;

class AddShop extends StatefulWidget {

  final String username;
  final String phoneNo;
  final String title;
  final bool isLeftFloattingButton;
  final bool isRightFloattingButton;
  final Icon leftIcon;
  final Icon rightIcon;

  final Function leftClick;
  final Function rightClick;

  const AddShop(
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
    appbar.fadeSystemUI();
    // setState(() {
    //   // (_controller.index == 0) ? null : --_controller.index;
    // });
    leftClick();
  }

  void _right() {
    appbar.fadeSystemUI();
    // setState(() {});
    rightClick();
  }
  

  @override
  State<AddShop> createState() => _AddShopState();
}

class _AddShopState extends State<AddShop> {
  final TextEditingController _shop_name_t = TextEditingController();
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
    // print(_myUser);
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
                          Text("Shop Name", style: Theme.of(context).textTheme.headline4),
                          Padding(
                            padding: const EdgeInsets.only(top:8.0, bottom: 16),
                            child: TextFormField(
                              controller: _shop_name_t,
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
                                hintText: "ABC Shop",
                                hintStyle: const TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.normal,
                                  color: Color(0xFFD1D1D1),
                                  letterSpacing: -0.5
                                ),
                              ),
                              validator: (val){
                                if (val!.isEmpty) {
                                  return "Enter Shop Name";
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
                                DropdownMenuItem(child: Text("Jewellery Shop", ), value: "Jewellery Shop"),
                                DropdownMenuItem(child: Text("Flower Shop"), value: "Flower Shop"),
                                DropdownMenuItem(child: Text("Shopping Center"), value: "Shopping Center"),
                                DropdownMenuItem(child: Text("Barber Shop"), value: "Barber Shop"),
                                DropdownMenuItem(child: Text("DIY Store"), value: "DIY Store"),
                                DropdownMenuItem(child: Text("Eyewear Shop"), value: "Eyewear Shop"),
                                DropdownMenuItem(child: Text("Stationary Shop"), value: "Stationary Shop"),
                                DropdownMenuItem(child: Text("Pharmacy"), value: "Pharmacy"),
                                DropdownMenuItem(child: Text("Fish Market"), value: "Fish Market"),
                                DropdownMenuItem(child: Text("Green Grocery"), value: "Green Grocery"),
                                DropdownMenuItem(child: Text("Bakery Shop"), value: "Bakery Shop"),
                                DropdownMenuItem(child: Text("Toy Shop"), value: "Toy Shop"),
                                DropdownMenuItem(child: Text("Music Shop"), value: "Music Shop"),
                                DropdownMenuItem(child: Text("Shoe Shop"), value: "Shoe Shop"),
                                DropdownMenuItem(child: Text("Cloth Shop"), value: "Cloth Shop"),
                                DropdownMenuItem(child: Text("Hardware Shop"), value: "Hardware Shop"),
                                DropdownMenuItem(child: Text("Book Shop"), value: "Book Shop"),
                                DropdownMenuItem(child: Text("Pet Shop"), value: "Pet Shop"),
                                DropdownMenuItem(child: Text("Tea Shop"), value: "Tea Shop"),
                                DropdownMenuItem(child: Text("Fuel Station"), value: "Fuel Station"),
                                DropdownMenuItem(child: Text("Grocery Shop"), value: "Grocery Shop"),
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
                                hintText: "Department Store, Sweet Shop, Cloth Shop, etc",
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
                                hintText: "Shop Info",
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
                                        "ADD SHOP",
                                        style: TextStyle(fontSize: 20, color: Color(0xFFFFFFFF), fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  onTap: () async {
                                    // FirebaseService service = new FirebaseService();
                                    if (_formKey.currentState!.validate() && _category != "" && _myUser != null) {
                                        String userId = _myUser.uid;
                                        DataRepository repository = DataRepository();
                                        repository.ss_shops_collection.add(
                                          {
                                            "businessId": userId,
                                            "name": _shop_name_t.text,
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
                                            "longtitide": 23.0
                                          }
                                        ).then((value){ 
                                          print(value);
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext builderContext) {
                                              return AlertDialog(
                                                title: const Text("Sucessfully added your Shop"),
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
                heroTag: "add shop left",
                mini: true,
                onPressed: widget._left,
                child: widget.leftIcon,
              ),
            if(widget.isRightFloattingButton)
              FloatingActionButton(
                heroTag: "add shop right",
                mini: true,
                onPressed: widget._right,
                child: widget.rightIcon,
              ),
          ]
        ),
      )
    );
  }
}