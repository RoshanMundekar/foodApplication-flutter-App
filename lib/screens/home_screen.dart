import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:foodapp/my-globals.dart';
import 'package:page_transition/page_transition.dart';
import '../Home/home.dart';
import '../Login.dart';
import '../Widgets/FormInputDecoration.dart';
import '../server.dart';
import 'detail_screen.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatelessWidget {

  final List plantFeatures;  // Replace PlantFeatureType with the actual type

  HomeScreen({required this.plantFeatures});

  final TextEditingController username = TextEditingController();

  final  TextEditingController Bank_Holder_Name = TextEditingController();
  final TextEditingController  Bank_Name = TextEditingController();
  final  TextEditingController CVV = TextEditingController();
  final TextEditingController Card_Number = TextEditingController();
  final  TextEditingController amount = TextEditingController();
  final  TextEditingController product = TextEditingController();

  @override
  Widget build(BuildContext context) {
    username.text = globalString.toString();
    amount.text = plantFeatures[9].toString();
    product.text = plantFeatures[1].toString();
    return Scaffold(
      body: SingleChildScrollView( // Wrap in a SingleChildScrollView for vertical scrolling
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                ClipPath(
                  clipper: OrangeClipper(),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 200.0, // Adjusted height
                    decoration: BoxDecoration(
                      color: Colors.orange,
                    ),
                  ),
                ),
                ClipPath(
                  clipper: BlackClipper(),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 200.0, // Adjusted height
                    decoration: BoxDecoration(
                      color: Colors.black,
                    ),
                  ),
                ),
                Positioned(
                  top: 80.0,
                  left: 25.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'My Bills',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 24.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    controller: Bank_Holder_Name,
                    decoration: InputDecoration(
                      labelText: 'Bank Holder Name',
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    controller: Bank_Name,
                    decoration: InputDecoration(
                      labelText: 'Bank Name',
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    controller: CVV,
                    decoration: InputDecoration(
                      labelText: 'CVV',
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    controller: Card_Number,
                    decoration: InputDecoration(
                      labelText: 'Card Number',
                    ),
                  ),
                  TextFormField(

                    initialValue: plantFeatures[9].toString(),
                    decoration: InputDecoration(
                      labelText: 'Amount',
                    ),
                  ),
                  // Add more input fields as needed
                ],
              ),
            ),
            Center(
              child: ElevatedButton(
                onPressed: () async {

                  // String username1,product1,Bank_Holdername1,Bank_Name1,CVV1,Card_Number1,amount1;
                  String username1 = username.text;
                  String product1 = product.text;
                  String Bank_Holdername1 = Bank_Holder_Name.text;
                  String Bank_Name1 = Bank_Name.text;
                  String CVV1 = CVV.text;
                  String Card_Number1 = Card_Number.text;
                  String amount1 = amount.text;

                  if(username1 == '' || Bank_Holdername1 == ''|| Bank_Name1 == ''|| CVV1 == '' || Card_Number1 == ''|| amount1 == '' )
                  {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text("Result"),
                          content: Text('Text Field is empty, Please Fill All Data'),
                          actions: [
                          ],
                        );
                      },
                    );
                  }else{

                    //url to send the post request to
                    final url = serverurl+"Payment";

                    //sending a post request to the url
                    final response = await http.post(Uri.parse(url), body: json.encode({'username1' : username1,'Bank_Holdername1' : Bank_Holdername1,'Bank_Name1' : Bank_Name1,'CVV1' : CVV1,'Card_Number1' : Card_Number1,'amount1' : amount1,'product1' : product1}));

                    String responseBody = response.body;

                    if(responseBody != "fail"){
                      String CVV1 = CVV.text;
                      String Card_Number1 = Card_Number.text;
                      String amount1 = amount.text;

                      Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=>DetailScreen(
                        amount: amount1,
                        CVV: CVV1,
                        cardNumber: Card_Number1,
                      )));

                    }else{
                      showDialog(
                        context: context,
                        builder: (context) {
                          Widget okButton = TextButton(
                            child: Text("OK"),
                            onPressed: (){
                              Navigator.pushReplacement(
                                  context,
                                  PageTransition(
                                      child: MyHomePage(),
                                      type: PageTransitionType.bottomToTop));
                            },
                          );
                          return AlertDialog(
                            title: Text("Result"),
                            content: Text("Invalid data in database please enter proper details."),
                            actions: [
                              okButton,
                            ],
                          );
                        },
                      );
                    }
                  }


                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => DetailScreen(),
                  //   ),
                  // );
                },
                child: Text('PAY'),
              ),
            ),
          ],
        ),
      ),
    );

  }

  Widget cardWidget(BuildContext context, String image, String title,
      String subtitle, String desc, String amount, String days, Color color) {
    return Material(
      elevation: 2.0,
      borderRadius: BorderRadius.circular(18.0),
      child: Container(
        width: MediaQuery.of(context).size.width - 30.0,
        height: 130.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18.0),
          color: Colors.white,
        ),

      ),
    );
  }

}

class OrangeClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0.0, size.height);
    path.lineTo(size.width / 2 + 85.0, size.height);

    var firstControlPoint = Offset(size.width / 2 + 140.0, size.height - 105.0);
    var firstEndPoint = Offset(size.width - 1.0, size.height);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    path.lineTo(size.width, 0.0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class BlackClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0.0, size.height);
    path.lineTo(size.width / 2 - 30.0, size.height);

    var firstControlPoint =
        Offset(size.width / 2 + 175.0, size.height / 2 - 30.0);
    var firstEndPoint = Offset(size.width / 2, 0.0);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    path.lineTo(size.width / 2 + 75.0, size.height / 2 - 30.0);

    path.lineTo(size.width / 2, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
