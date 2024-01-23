
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:foodapp/server.dart';

import 'Login.dart';
import 'Widgets/CustomButton.dart';
import 'Widgets/FormInputDecoration.dart';
import 'Widgets/Loader.dart';
import 'Widgets/PageHeader.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import 'my-globals.dart';

class addfoods extends StatefulWidget {
  createState() => addfoodsState();
}


class addfoodsState extends State<addfoods> {


  final TextEditingController productname = TextEditingController();
  final TextEditingController foodtype = TextEditingController();
  final TextEditingController quantity = TextEditingController();
  final TextEditingController deliveryoption = TextEditingController();
  final TextEditingController donationdatatime = TextEditingController();
  final TextEditingController location = TextEditingController();
  final TextEditingController comments = TextEditingController();
  final TextEditingController amount = TextEditingController();

  final List<String> _options = ['fruits', 'vegetables ', 'Meats', 'canned goods', 'Others'];
  String? _selectedValue; // Track the selected value
  bool _isDropdownVisible = false;
  String? _selectedOption;

  final List<String> _options1 = ['Pounds', 'Ounce', 'Units'];
  String? _selectedValue1; // Track the selected value
  bool _isDropdownVisible1 = false;

  PickedFile? _pickedImage;

  Future<void> _pickImage(ImageSource source) async {
    final pickedImage = await ImagePicker().pickImage(source: source);


    if (pickedImage != null) {
      setState(() {
        _pickedImage = File(pickedImage.path) as PickedFile?;
      });
    }
  }




  bool _autoValid = false;
  bool loader = false;


  @override
  Widget build(BuildContext context) {
    amount.text = globalString.toString();
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(child: Builder(builder: (context) {
          return Stack(
            children: <Widget>[
              SignupForm(context),
              loader ? LoaderWidget() : Container()
            ],
          );
        })));
  }

  // late DateTime _selectedDate;
  //
  // Future<void> _selectDate(BuildContext context) async {
  //   final DateTime? picked = await showDatePicker(
  //     context: context,
  //     initialDate: DateTime.now() ?? _selectedDate,
  //     firstDate: DateTime(2000),
  //     lastDate: DateTime(2101),
  //   );
  //   if (picked != null) {
  //     setState(() {
  //       _selectedDate = picked;
  //       dataofupload.text = picked.toLocal().toString().split(' ')[0];
  //     });
  //   }
  // }




  Future<void> _selectDateAndTime(BuildContext context) async {
    DateTime currentDate = DateTime.now();
    TimeOfDay currentTime = TimeOfDay.now();

    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: currentDate,
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: currentTime,
      );

      if (pickedTime != null) {
        DateTime selectedDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );

        setState(() {
          donationdatatime.text = selectedDateTime.toString();
        });
      }
    }
  }


  @override
  void dispose() {
    donationdatatime.dispose();
    super.dispose();
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
                PageHeader(title: "Create Donation Listing "),
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
                      borderRadius: BorderRadius.circular(25),
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

                  textInputAction: TextInputAction.done,
                  controller: productname,

                  style: FormInputDecoration.customTextStyle(),
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.none,
                  decoration:
                  FormInputDecoration.formInputDesign(name: "Product Name"),


                ),
                SizedBox(
                  height: 30.0,
                ),
                TextFormField(
                  onTap: _toggleDropdown,
                  readOnly: true,
                  controller: TextEditingController(text: _selectedValue),
                  decoration: const InputDecoration(
                    labelText: 'Food type selection ',
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
                              foodtype.text = _selectedValue!;
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
                    labelText: 'Quantity field ',
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
                              quantity.text = _selectedValue1!;
                            }
                          });
                        },
                      ),
                    ),
                  ),



                SizedBox(
                  height: 20.0,
                ),


                Text('Choose Pickup/Delivery Option:'),

                RadioListTile<String>(
                  title: Text('Pickup'),
                  value: 'Pickup',
                  groupValue: deliveryoption.text,
                  onChanged: (value) {
                    setState(() {
                      deliveryoption.text = value!;
                    });
                  },
                ),
                RadioListTile<String>(
                  title: Text('Delivery'),
                  value: 'Delivery',
                  groupValue: deliveryoption.text,
                  onChanged: (value) {
                    setState(() {
                      deliveryoption.text = value!;
                    });
                  },
                ),
                RadioListTile<String>(
                  title: Text('Both'),
                  value: 'both',
                  groupValue: deliveryoption.text,
                  onChanged: (value) {
                    setState(() {
                      deliveryoption.text = value!;
                    });
                  },
                ),

                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  controller: donationdatatime,
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: 'Select Donation Date and Time',
                    suffixIcon: Icon(Icons.calendar_today),
                  ),
                  onTap: () {
                    _selectDateAndTime(context);
                  },
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(

                  textInputAction: TextInputAction.done,
                  controller: location,

                  style: FormInputDecoration.customTextStyle(),

                  textCapitalization: TextCapitalization.none,
                  decoration:
                  FormInputDecoration.formInputDesign(name: "Pickup location"),


                ),
                SizedBox(
                  height: 20.0,
                ),

                TextFormField(

                  textInputAction: TextInputAction.done,
                  controller: comments,

                  style: FormInputDecoration.customTextStyle(),

                  textCapitalization: TextCapitalization.none,
                  decoration:
                  FormInputDecoration.formInputDesign(name: "Comments Field for Donor"),


                ),

                SizedBox(
                  height: 20.0,
                ),
                CustomButton(
                  text: "Add Product",
                  color: Colors.green,
                  onPressed: () async{
                    String productname1,foodtype1,quantity1,user,deliveryoption1,donationdatatime1,location1,comments1,amount1;

                    productname1 = productname.text ;
                    foodtype1 = foodtype.text ;
                    quantity1 = quantity.text;
                    deliveryoption1 = deliveryoption.text;
                    donationdatatime1 = donationdatatime.text;
                    location1 = location.text;
                    comments1 = comments.text;
                    amount1 = amount.text;
                    user = globalString[0];
                    if(productname1 == '' || foodtype1 == '' || location1 == '' || amount1 == '' || imageFile == ''|| deliveryoption1 == '')
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
                      final request = http.MultipartRequest("POST",Uri.parse(serverurl+"Uploadproduct"));

                      final header = {"Content-type": "multipart/form-data"};

                      request.files.add(
                          http.MultipartFile('image',File(imageFile.path).readAsBytes().asStream(),
                              File(imageFile.path).lengthSync(),filename: File(imageFile.path).path.split("/").last));

                      request.headers.addAll(header);
                      final reponse = await request.send();

                      int responseBody1 = reponse.statusCode;

                      //url to send the post request to
                      final url = serverurl+"Addfood";
                      productname1 = productname.text ;
                      foodtype1 = foodtype.text ;
                      quantity1 = quantity.text;
                      deliveryoption1 = deliveryoption.text;
                      donationdatatime1 = donationdatatime.text;
                      location1 = location.text;
                      comments1 = comments.text;
                      amount1 = amount.text;
                      user = globalString[0];


                      //sending a post request to the url
                      final response = await http.post(Uri.parse(url), body: json.encode({'productname1' : productname1,'imagename' : imageFile.path, 'foodtype1' : foodtype1,'quantity1' : quantity1,'deliveryoption1' : deliveryoption1,'donationdatatime1' : donationdatatime1,'location1' : location1,'comments1' : comments1,'amount1' : amount1,'user' : user}));

                      String responseBody = response.body;

                      if(responseBody == "success" || responseBody1 == 200){
                        showDialog(
                          context: context,
                          builder: (context) {
                            Widget okButton = TextButton(
                              child: Text("OK"),
                              onPressed: (){
                                Navigator.pushReplacementNamed(context, "/home");
                              },
                            );
                            return AlertDialog(
                              title: Text("Result"),
                              content: Text("sucessfully add product ! "),
                              actions: [
                                okButton,
                              ],
                            );
                          },
                        ).then((value) {
                          Navigator.pushReplacementNamed(context, "/home");
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
