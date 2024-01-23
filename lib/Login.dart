import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:foodapp/Home/home2.dart';
import 'package:foodapp/server.dart';
import 'package:page_transition/page_transition.dart';
import '../../Widgets/PageHeader.dart';
import '../../Widgets/CustomButton.dart';
import '../../Widgets/FormInputDecoration.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import '../../Widgets/Loader.dart';
import 'Home/home.dart';
import 'Signup.dart';
import 'my-globals.dart';


class Login extends StatefulWidget {
  createState() => LoginState();
}

class LoginState extends State<Login> {
  final  TextEditingController usernameController = TextEditingController();
  final  TextEditingController passwordController = TextEditingController();
  final TextEditingController UsertypeEditingController = TextEditingController();


  final  TextEditingController forgetuseremail = TextEditingController();
  final  TextEditingController forgetpassword = TextEditingController();
  bool loader = false;

  bool _isDropdownVisible = false;
  String? _selectedValue; // Track the selected value
  final List<String> _options = ['Donor', 'Receiver '];
  List characterList = [];
  List characterList1 = [];


  ShowDialogBox(context) {
    showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            titlePadding: EdgeInsets.all(10.5),
            contentPadding: EdgeInsets.all(20.0),
            title: Row(
              children: <Widget>[
                Expanded(
                  child: Text("Reset password"),
                ),
                Padding(
                  padding: EdgeInsets.all(5.0),
                  child: InkResponse(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Icon(Icons.close),
                  ),
                )
              ],
            ),
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      controller: forgetuseremail,
                      textInputAction: TextInputAction.done,
                      style: FormInputDecoration.customTextStyle(),

                      textCapitalization: TextCapitalization.none,
                      decoration:
                          FormInputDecoration.formInputDesign(name: "EmailAddress"),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    TextFormField(
                      controller: forgetpassword,
                      obscureText: true,
                      textInputAction: TextInputAction.done,
                      style: FormInputDecoration.customTextStyle(),
                      textCapitalization: TextCapitalization.none,
                      decoration:
                      FormInputDecoration.formInputDesign(name: "Password"),
                    ),

                    SizedBox(
                      height: 20.0,
                    ),
                    CustomButton(
                        text: "RESET",
                        color: Colors.green,
                        onPressed: ()async {
                          String text1,text2;
                          text1 = forgetuseremail.text ;
                          text2 = forgetpassword.text;


                          if(text1 == '' || text2 == '' )
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
                          }
                          else{

                            //url to send the post request to
                            final url = serverurl+"forgotpassword";

                            //sending a post request to the url
                            final response = await http.post(Uri.parse(url), body: json.encode({'email' : text1,'pass' : text2}));

                            String responseBody = response.body;
                            if(responseBody == "success"){
                              showDialog(
                                context: context,
                                builder: (context) {
                                  Widget okButton = TextButton(
                                    child: Text("OK"),
                                    onPressed: (){
                                      Navigator.pushReplacement(
                                          context,
                                          PageTransition(
                                              child: Login(),
                                              type: PageTransitionType.bottomToTop));
                                    },
                                  );
                                  return AlertDialog(
                                    title: Text("Result"),
                                    content: Text('Your Password upadate sucessfully please check MailId'),
                                    actions: [
                                      okButton,
                                    ],

                                  );
                                },
                              );
                            }


                          }

                        }


                    ),
                  ],


                ),
              )
            ],
          );
        },
        barrierDismissible: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Builder(
        builder: (context) {
          return Stack(
            children: <Widget>[
              LoginForm(context),
              loader ? LoaderWidget() : Container()
            ],
          );
        },
      )),
    );
  }

  Widget LoginForm(BuildContext context) {
    return SingleChildScrollView(
        child: Form(


      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 20.0,
            ),
            PageHeader(title: "Sing In"),
            SizedBox(
              height: 30.0,
            ),
            TextFormField(

              controller: usernameController,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              style: FormInputDecoration.customTextStyle(),

              textCapitalization: TextCapitalization.none,
              decoration: FormInputDecoration.formInputDesign(name: "Username"),


            ),
            SizedBox(
              height: 20.0,
            ),
            TextFormField(
              controller: passwordController,

              obscureText: true,
              textInputAction: TextInputAction.done,
              style: FormInputDecoration.customTextStyle(),

              textCapitalization: TextCapitalization.none,
              decoration: FormInputDecoration.formInputDesign(name: "Password"),

            ),
            SizedBox(
              height: 20.0,
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
                          UsertypeEditingController.text = _selectedValue!;
                        }
                      });
                    },
                  ),
                ),
              ),


            SizedBox(
              height: 20.0,
            ),
            CustomButton(
              text: "Login",
              color: Colors.green,
              onPressed: ()async {
                String text1,text2,text3;
                text1 = usernameController.text ;
                text2 = passwordController.text;
                text3 = UsertypeEditingController.text;

                if(text1 == '' || text2 == ''|| text3 == '' )
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
                }
                else{

                  //url to send the post request to
                  final url = serverurl+"login";

                  //sending a post request to the url
                  final response = await http.post(Uri.parse(url), body: json.encode({'username' : text1,'pass' : text2,'usertype' : text3}));

                  String responseBody = response.body;
                  print(responseBody);
                  print("responseBody");

                  if(responseBody == "fail"){
                    print("My text ${text1} and ${text2}");
                    showDialog(
                      context: context,
                      builder: (context) {
                        Widget okButton = TextButton(
                          child: Text("OK"),
                          onPressed: (){
                            Navigator.pushReplacement(
                                context,
                                PageTransition(
                                    child: Login(),
                                    type: PageTransitionType.bottomToTop));
                          },
                        );
                        return AlertDialog(
                          title: Text("Result"),
                          content: Text("Invalid username and password.\nYou need to login again."),
                          actions: [
                            okButton,
                          ],
                        );
                      },
                    );
                  }
                  else{

                    Iterable list1 = json.decode(response.body);
                    characterList1.clear();
                    characterList1.addAll(list1) ;


                    // globalString = characterList[1];
                    // globalHeaderEmail= characterList[3];
                    // globalHeaderMob= characterList[5];
                    // Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context)=>MyHomePage1()));

                    if(characterList1[8].toString()=="Donor"){

                      Iterable list = json.decode(response.body);
                      characterList.clear();
                      characterList.addAll(list) ;
                      print(list);

                      globalString = characterList[1];
                      globalHeaderEmail= characterList[3];
                      globalHeaderMob= characterList[5];
                      Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context)=>MyHomePage()));
                    }
                    else{

                      Iterable list = json.decode(response.body);
                      characterList.clear();
                      characterList.addAll(list) ;
                      print(list);

                      globalString = characterList[1];
                      globalHeaderEmail= characterList[3];
                      globalHeaderMob= characterList[5];
                      Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context)=>MyHomePage1()));

                    }

                  }
                }

              }


              ),

            SizedBox(
              height: 20.0,
            ),
            Container(
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(
                    "Forgot Password ?",
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  GestureDetector(
                    onTap: () => ShowDialogBox(context),
                    child: Text(
                      "Click here",
                      style: TextStyle(
                          fontWeight: FontWeight.w500, color: Colors.teal),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(
              alignment: Alignment.center,
              child: Text("OR", style: TextStyle(fontWeight: FontWeight.w500)),
            ),
            SizedBox(
              height: 20.0,
            ),
            CustomButton(
              text: "Connect with facebook",
              onPressed: () {},
              color: Colors.indigo,
            ),
            SizedBox(
              height: 5.0,
            ),
            CustomButton(
              text: "Connect with twitter",
              color: Colors.blue,
              onPressed: () {},
            )
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

}
