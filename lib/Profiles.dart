
import 'dart:convert';
import 'dart:io';
import 'package:foodapp/my-globals.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:foodapp/profile.dart';
import 'package:foodapp/server.dart';

import 'Login.dart';
import 'Signup.dart';

import 'Widgets/CustomButton.dart';
import 'Widgets/FormInputDecoration.dart';
import 'Widgets/Loader.dart';
import 'Widgets/PageHeader.dart';
import 'package:provider/provider.dart';

import 'package:image_picker/image_picker.dart';


class Profiles extends StatefulWidget {
  final String username;
  final String email;
  final String password;
  final String contact;

  Profiles({super.key,
    required this.username,
    required this.email,
    required this.password,
    required this.contact,
  });



  createState() => ProfilesState();
}


class ProfilesState extends State<Profiles> {





  bool _isDropdownVisible = false;
  String? _selectedValue; // Track the selected value
  final List<String> _options = ['Donor', 'Receiver '];

  bool _isDropdownVisible1 = false;
  String? _selectedValue1; // Track the selected value
  final List<String> _options1 = ['Mumbai', 'Pune', 'Kolkata'];



  PickedFile? _pickedImage;

  Future<void> _pickImage(ImageSource source) async {
    final pickedImage = await ImagePicker().pickImage(source: source);


    if (pickedImage != null) {
      setState(() {
        _pickedImage = File(pickedImage.path) as PickedFile?;
      });
    }
  }


  // final usernameController = TextEditingController();
  // final emailController = TextEditingController();
  // final passwordController = TextEditingController();
  // final contactController = TextEditingController();
  // final addressController = TextEditingController();

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController _cityEditingController = TextEditingController();
  final TextEditingController _UsertypeEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    usernameController.text = widget.username; // Use widget.username
    emailController.text = widget.email; // Use widget.email
    passwordController.text = widget.password; // Use widget.password
    contactController.text = widget.contact; // Use widget.contact
  }
  var imageFile=null;

  Future<void>_showChoiceDialog(BuildContext context)
  {
    return showDialog(context: context,builder: (BuildContext context){
      return AlertDialog(
        title: Text("Choose option",style: TextStyle( color: Colors.green),),
        content: SingleChildScrollView(
          child: ListBody(
            children: [
              Divider(height: 1, color: Colors.green),
              ListTile(
                onTap: () async {
                  // ignore: deprecated_member_use
                  final pickedFile = await ImagePicker().getImage(
                    source: ImageSource.gallery ,
                  );
                  setState(() {
                    imageFile = pickedFile;
                  });

                  Navigator.pop(context);
                },
                title:
                Text(
                  "Gallery",
                  style: TextStyle(
                    color: Colors.green,
                  ),
                ),
                leading: Icon(Icons.broken_image_outlined, color: Colors.green,),
              ),

              Divider(height: 1, color: Colors.green,),
              ListTile(
                onTap: () async {
                  // ignore: deprecated_member_use
                  final pickedFile = await ImagePicker().getImage(
                    source: ImageSource.camera ,
                  );
                  setState(() {
                    imageFile = pickedFile;
                  });
                  Navigator.pop(context);
                },
                title:
                Text(
                  "Camera",
                  style: TextStyle(
                    color: Colors.green,
                  ),
                ),
                leading: Icon(Icons.camera, color: Colors.green,),
              ),
            ],
          ),
        ),);
    });
  }



  @override
  Widget build(BuildContext  context) {


    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(child: Builder(builder: (context) {
          return Stack(
            children: <Widget>[
              SignupForm(context),

            ],
          );
        })));
  }

  Widget SignupForm(BuildContext context) {



    return SingleChildScrollView(
        child: Form(

          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 20.0,
                ),
                PageHeader(title: "Create Profile Here"),
                SizedBox(
                  height: 30.0,
                ),
                GestureDetector(
                  onTap: () {
                    _showChoiceDialog(context);
                  },
                  child: CircleAvatar(
                    radius: 48.0,
                    backgroundColor: Colors.green,
                    child: imageFile != null
                        ? ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: ClipOval(
                        child: Image.file(
                          File(imageFile.path),
                          width: 36,
                          height: 36,
                          fit: BoxFit.fill,
                        ),
                      ),
                    )
                        : Icon(
                      Icons.camera_alt,
                      color: Colors.grey[800],
                    ),
                  ),
                ),


                SizedBox(
                  height: 30.0,
                ),
                TextFormField(
                  onTap: _toggleDropdown,
                  readOnly: true,
                  controller: TextEditingController(text: _selectedValue),
                  decoration: const InputDecoration(
                    labelText: 'Register As ',
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.arrow_drop_down),
                  ),

                ),
                if (_isDropdownVisible)
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: Colors.grey),
                    ),


                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: _options.length,
                      itemBuilder: (context, index) => ListTile(
                        title: Text(_options[index]),
                        onTap: () {
                          setState(() {
                            _selectedValue = _options[index];
                            _isDropdownVisible = false;
                            if (_selectedValue != null) {
                              _UsertypeEditingController.text = _selectedValue!;
                            }
                          });
                        },
                      ),
                    ),
                  ),


                SizedBox(
                  height: 20.0,
                ),

                TextFormField(
                  onTap: _toggleDropdown1,
                  readOnly: true,
                  controller: TextEditingController(text: _selectedValue1),
                  decoration: const InputDecoration(
                    labelText: 'Select City',
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.arrow_drop_down),
                  ),
                ),
                if (_isDropdownVisible1)
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: _options1.length,
                      itemBuilder: (context, index) => ListTile(
                        title: Text(_options1[index]),
                        onTap: () {
                          setState(() {
                            _selectedValue1 = _options1[index];
                            _isDropdownVisible1 = false;
                            // Update the controller's text value here
                            if (_selectedValue1 != null) {
                              _cityEditingController.text = _selectedValue1!;
                            }
                          });
                        },
                      ),
                    ),
                  ),




                SizedBox(
                  height: 20.0,
                ),


                TextFormField(
                  controller: usernameController,
                  textInputAction: TextInputAction.next,

                  style: FormInputDecoration.customTextStyle(),
                  textAlign: TextAlign.center,

                  textCapitalization: TextCapitalization.none,
                  decoration: FormInputDecoration.formInputDesign(name: "Username"),


                ),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,

                  textInputAction: TextInputAction.next,
                  style: FormInputDecoration.customTextStyle(),
                  textAlign: TextAlign.center,
                  textCapitalization: TextCapitalization.none,
                  decoration: FormInputDecoration.formInputDesign(name: "Email Address"),


                ),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  controller: passwordController,
                  textInputAction: TextInputAction.next,

                  style: FormInputDecoration.customTextStyle(),
                  textAlign: TextAlign.center,
                  textCapitalization: TextCapitalization.none,
                  decoration: FormInputDecoration.formInputDesign(name: "Password"),


                ),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(

                  textInputAction: TextInputAction.done,
                  controller: contactController,

                  style: FormInputDecoration.customTextStyle(),
                  textAlign: TextAlign.center,
                  textCapitalization: TextCapitalization.none,
                  decoration:
                  FormInputDecoration.formInputDesign(name: "Contact Number"),


                ),
                SizedBox(
                  height: 20.0,
                ),

                TextFormField(

                  textInputAction: TextInputAction.done,
                  controller: addressController,

                  style: FormInputDecoration.customTextStyle(),
                  textAlign: TextAlign.center,
                  textCapitalization: TextCapitalization.none,
                  decoration:
                  FormInputDecoration.formInputDesign(name: "Addresss"),


                ),
                SizedBox(
                  height: 20.0,
                ),
                CustomButton(
                  text: "Sign up",
                  color: Colors.green,
                  onPressed: () async {
                    String text1,text2,text3,text4,text5,text6,text7;

                    text1 = usernameController.text ;
                    text2 = emailController.text ;
                    text3 = passwordController.text;
                    text4 = contactController.text;
                    text5 = addressController.text;
                    text6 = _cityEditingController.text;
                    text7 = _UsertypeEditingController.text;

                    print(text1);
                    print(text2);
                    print(text3);
                    print(text4);
                    print(text5);
                    print(text6);
                    print(text7);



                    if(text1 == '' || text5 == '' || text7 == '' || text6 == '' || imageFile == '')
                    {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text("Result"),
                            content: Text("Please enter details"),
                            actions: [
                            ],
                          );
                        },
                      );
                    }
                    else{
                      final request = http.MultipartRequest("POST",Uri.parse(serverurl+"Uploadprofile"));

                      final header = {"Content-type": "multipart/form-data"};

                      request.files.add(
                          http.MultipartFile('image',File(imageFile.path).readAsBytes().asStream(),
                              File(imageFile.path).lengthSync(),filename: File(imageFile.path).path.split("/").last));

                      request.headers.addAll(header);
                      final reponse = await request.send();

                      int responseBody1 = reponse.statusCode;

                      //url to send the post request to
                      final url = serverurl+"register";
                      text1 = usernameController.text ;
                      text2 = emailController.text ;
                      text3 = passwordController.text;
                      text4 = contactController.text;
                      text5 = addressController.text;
                      text6 = _cityEditingController.text;
                      text7 = _UsertypeEditingController.text;
                      //sending a post request to the url
                      final response = await http.post(Uri.parse(url), body: json.encode({'username' : text1,'imagename' : imageFile.path, 'email' : text2,'password' : text3,'contact' : text4,'address' : text5,'city' : text6,'Usertype' : text7}));

                      String responseBody = response.body;

                      if(responseBody == "success" || responseBody1 == 200){
                        showDialog(
                          context: context,
                          builder: (context) {
                            Widget okButton = TextButton(
                              child: Text("OK"),
                              onPressed: (){
                                Navigator.pushReplacementNamed(context, "/register");
                              },
                            );
                            return AlertDialog(
                              title: Text("Result"),
                              content: Text("sucessfully register user ! "),
                              actions: [
                                okButton,
                              ],
                            );
                          },
                        ).then((value) {
                          Navigator.pushReplacementNamed(context, "/login");
                        });
                      }
                      else if(responseBody == "notvalid"){
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              content: Text("Pleaase enter valid details !"),
                            );
                          },
                        );
                      }
                      else{
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              content: Text("Something is wrong !"),
                            );
                          },
                        );
                      }
                    }


                    // Navigator.push(context,
                    //     MaterialPageRoute(builder: (context) => Login()));
                  },
                ),
                SizedBox(
                  height: 20.0,
                ),
                SizedBox(
                  height: 20.0,
                ),


              ],
            ),
          ),
        ));
  }
  void _toggleDropdown() {
    setState(() {
      _isDropdownVisible = !_isDropdownVisible;
    });
  }

  void _toggleDropdown1() {
    setState(() {
      _isDropdownVisible1 = !_isDropdownVisible1;
    });
  }


}

