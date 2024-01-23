
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

class addrequestpro extends StatefulWidget {
  createState() => addrequestproState();
}


class addrequestproState extends State<addrequestpro> {


  final TextEditingController productname = TextEditingController();
  final TextEditingController foodtype = TextEditingController();
  final TextEditingController quantity = TextEditingController();
  final TextEditingController deliveryoption = TextEditingController();
  final TextEditingController location = TextEditingController();

  TextEditingController quantityController = TextEditingController();
  TextEditingController dropdownValueController = TextEditingController();

  final List<String> _options = ['fruits', 'vegetables ', 'Meats', 'canned goods', 'Others'];
  String? _selectedValue; // Track the selected value
  bool _isDropdownVisible = false;
  String? _selectedOption;


  String selectedNumber = "";
  List<String> dropdownItems = ['Pounds', 'Ounce', 'Units'];
  String selectedDropdownValue = "";

  bool loader = false;


  @override
  Widget build(BuildContext context) {

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
                PageHeader(title: "Request for foods  "),
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
                  textInputAction: TextInputAction.next,
                  controller: quantityController, // Use quantityController here
                  style: FormInputDecoration.customTextStyle(),
                  keyboardType: TextInputType.number,
                  textCapitalization: TextCapitalization.none,
                  decoration: FormInputDecoration.formInputDesign(name: "Food Quantity"),
                  onChanged: (value) {
                    setState(() {
                      selectedNumber = value;
                    });
                  },
                ),

                if (selectedNumber.isNotEmpty)
                  DropdownButtonFormField<String>(
                    value: null,
                    items: dropdownItems.map((item) {
                      return DropdownMenuItem<String>(
                        value: item,
                        child: Text(item),
                      );
                    }).toList(),
                    onChanged: (value) {
                      // Handle dropdown selection
                      setState(() {
                        dropdownValueController.text = value!; // Set the selected value to the controller
                      });
                    },
                  ),


                SizedBox(
                  height: 20.0,
                ),
                CustomButton(
                  text: "Add Food Request",
                  color: Colors.green,
                  onPressed: () async{
                    String productname1,foodtype1,quantity1,deliveryoption1,location1,unit1,user;
                    productname1 = productname.text ;
                    foodtype1 = foodtype.text ;
                    quantity1 = quantityController.text;
                    unit1 = dropdownValueController.text;
                    deliveryoption1 = deliveryoption.text;
                    location1 = location.text;
                    print("---------------");
                    print(productname1);
                    print(foodtype1);
                    print(location1);
                    print(deliveryoption1);
                    print(quantity1);
                    print(unit1);
                    if(productname1 == '' || foodtype1 == '' || location1 == '' || unit1 == '' || quantity1 == ''|| deliveryoption1 == '')
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

                      //url to send the post request to
                      final url = serverurl+"Addfoodrequest";
                      productname1 = productname.text ;
                      foodtype1 = foodtype.text ;
                      quantity1 = quantityController.text;
                      unit1 = dropdownValueController.text;
                      deliveryoption1 = deliveryoption.text;
                      location1 = location.text;
                      user = globalString[0];

                      //sending a post request to the url
                      final response = await http.post(Uri.parse(url), body: json.encode({'productname1' : productname1,'foodtype1' : foodtype1, 'deliveryoption1' : deliveryoption1,'location1' : location1,'quantity1' : quantity1,'unit1' : unit1,'user' : user}));

                      String responseBody = response.body;

                      if(responseBody == "success"){
                        showDialog(
                          context: context,
                          builder: (context) {
                            Widget okButton = TextButton(
                              child: Text("OK"),
                              onPressed: (){
                                Navigator.pushReplacementNamed(context, "/home2");
                              },
                            );
                            return AlertDialog(
                              title: Text("Result"),
                              content: Text("sucessfully add product  Request ! "),
                              actions: [
                                okButton,
                              ],
                            );
                          },
                        ).then((value) {
                          Navigator.pushReplacementNamed(context, "/home2");
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





                  }
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
  void updateCombinedValue() {
    String combinedValue = "$selectedNumber $selectedDropdownValue";
    quantity.text = combinedValue;
  }

}
